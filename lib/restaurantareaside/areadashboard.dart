import 'dart:io';
import 'package:greengrocers/ExternalUIDesign/widgets/slide_item.dart';
import 'package:greengrocers/restaurantareaside/areaorders.dart';
import 'package:greengrocers/userside/models/cart_item.dart';
import 'package:greengrocers/userside/models/restaurant.dart';
import 'package:greengrocers/userside/provider/restaurant.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:greengrocers/adminside/db/brand.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greengrocers/userside/provider/product.dart';
import 'package:greengrocers/userside/widgets/restaurant.dart';
import 'package:greengrocers/userside/screens/restaurant.dart';
import 'package:greengrocers/userside/helpers/screen_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:greengrocers/restaurantareaside/addgrocery.dart';
import 'package:greengrocers/userside/provider/app.dart';

enum Page { dashboard, manage }

class AreaAdmin extends StatefulWidget {
  @override
  _AreaAdminState createState() => _AreaAdminState();
}

class _AreaAdminState extends State<AreaAdmin> {
  Page _selectedPage = Page.dashboard;
  MaterialColor active = Colors.red;
  MaterialColor notActive = Colors.grey;
  TextEditingController categoryController = TextEditingController();
  TextEditingController restController = TextEditingController();
  GlobalKey<FormState> _restFormKey = GlobalKey();
  BrandService _restService = BrandService();
  File _image1;
  String imageURL;
  String areaname = "Hadapsar";
  String cityname = "Pune";
  String contact = '9423533919';
  List<RestaurantModel> list = [];
  List<DocumentSnapshot> brands = <DocumentSnapshot>[];

  @override
  Widget build(BuildContext context) {
    final restProvider = Provider.of<RestaurantProvider>(context);
    final app = Provider.of<AppProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Expanded(
                  child: FlatButton.icon(
                      onPressed: () {
                        setState(() => _selectedPage = Page.dashboard);
                      },
                      icon: Icon(
                        Icons.dashboard,
                        color: _selectedPage == Page.dashboard
                            ? active
                            : notActive,
                      ),
                      label: Text('Dashboard'))),
              Expanded(
                  child: FlatButton.icon(
                      onPressed: () {
                        setState(() => _selectedPage = Page.manage);
                      },
                      icon: Icon(
                        Icons.sort,
                        color:
                            _selectedPage == Page.manage ? active : notActive,
                      ),
                      label: Text('Manage'))),
            ],
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: _loadScreen(restProvider, app, productProvider));
  }

  Widget _loadScreen(RestaurantProvider restProvider, AppProvider app,
      ProductProvider productProvider) {
    switch (_selectedPage) {
      case Page.dashboard:
        return ListView(
          children: [
            Column(
              children: restProvider.arearestaurant
                  .map((item) => GestureDetector(
                        onTap: () async {
                          app.changeLoading();
                          await productProvider.loadProductsByRestaurant(
                              restaurantId: item.id);
                          app.changeLoading();
                          changeScreen(
                              context,
                              SlideItem(
                                restaurantModel: item,
                              ));
                        },
                        child: RestaurantWidget(
                          restaurant: item,
                        ),
                      ))
                  .toList(),
            ),
          ],
        );
        break;
      case Page.manage:
        return ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text("See Orders"),
              onTap: () {
                getData(cityname);
              },
            ),
            ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text("Add Store"),
              onTap: () {
                _StoreAlert("");
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.library_books),
              title: Text("Store list"),
              onTap: () async {
                await _restService.getBrands();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Add Grocery"),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => AddGrocery()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.change_history),
              title: Text("Grocery list"),
              onTap: () {},
            ),
            Divider(),
          ],
        );
        break;
      default:
        return Container();
    }
  }

  void _StoreAlert(String url) {
    var alert = new AlertDialog(
      content: Form(
        key: _restFormKey,
        child: TextFormField(
          controller: restController,
          // ignore: missing_return
          validator: (value) {
            if (value.isEmpty) {
              return 'Store Name cannot be empty';
            }
          },
          decoration: InputDecoration(hintText: "Add Store"),
        ),
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              setImage(ImagePicker.pickImage(source: ImageSource.gallery), 1,
                  restController.text);

//          Fluttertoast.showToast(msg: 'category created');
            },
            child: Text('Upload Image')),
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('CANCEL')),
      ],
    );

    showDialog(context: context, builder: (_) => alert);
  }

  void setImage(Future<File> pickImage, int imageNumber, String name) async {
    File tempImg = await pickImage;
    switch (imageNumber) {
      case 1:
        setState(() => _image1 = tempImg);
        validateimage(1, _image1, name);
        break;
    }
  }

  void validateimage(int i, File image1, String name) async {
    File image;
    if (image1 != null && name != null) {
      image = image1;
      final FirebaseStorage storage = FirebaseStorage.instance;
      final String picture1 =
          "storeimages/${areaname}/${name}/images/${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
      StorageUploadTask task1 = storage.ref().child(picture1).putFile(image);
      StorageTaskSnapshot snapshot1 =
          await task1.onComplete.then((snapshot) => snapshot);
      imageURL = await snapshot1.ref.getDownloadURL();
      if (i == 1) {
        _restService.createBrand(
          {
            "name": name,
            "areaname": [areaname, cityname],
            "avgPrice": 40.5,
            "rating": 4.3,
            "rates": 40,
            "image": imageURL,
            "contact": contact,
            "popular": true,
          },
        );
      }
    } else {
      print("Please choose a valid Image");
    }
  }

  void getData (String cityname)async
  {
    FirebaseFirestore _firestore=FirebaseFirestore.instance;
    List<CartItemModel> convertedCart = [];
    await _firestore.collection("users")
        .where("cart".length>=1)
        .get()
        .then((result) {
      for (DocumentSnapshot product in result.docs) {
        for(Map item in product.get("cart"))
        {
          convertedCart.add(CartItemModel.fromMap(item));
        }
      }
    }
    );
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return AreaOrderWidget(cartItemModel: convertedCart,cityname:cityname);
    }));
  }
}
