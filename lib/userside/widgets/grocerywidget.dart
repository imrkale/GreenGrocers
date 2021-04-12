import 'package:flutter/material.dart';
import 'package:greengrocers/userside/models/products.dart';
import 'package:greengrocers/userside/widgets/loading.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:greengrocers/userside/provider/app.dart';
import 'package:greengrocers/userside/provider/user.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';
import 'package:greengrocers/userside/helpers/screen_navigation.dart';
import 'package:greengrocers/userside/screens/details.dart';
import '../helpers/style.dart';
import 'custom_text.dart';
import 'loading.dart';


class Grocerydesign extends StatefulWidget {
  final ProductModel productModel;

  Grocerydesign(this.productModel);
  @override
  _GrocerydesignState createState() => _GrocerydesignState();
}

class _GrocerydesignState extends State<Grocerydesign> {
  int quantity = 1;
  final _key = GlobalKey<ScaffoldState>();
  TextEditingController quatity = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    return Padding(
        padding: EdgeInsets.fromLTRB(12, 14, 16, 12),
        child: GestureDetector(
          onTap: () {
            changeScreen(
                context,
                Details(
                  product: widget.productModel,
                ));
          },
          child: LayoutBuilder(
            builder: (_, Constraints) {
              return Container(

                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(-2, -1),
                          blurRadius: 5),
                    ]),
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: Loading(),
                              )),
                          Center(
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: widget.productModel.image,
                              height: 100,
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                            Text(
                              widget.productModel.name ??
                                  "id null",style: TextStyle(fontSize: 20.0,
                                fontWeight: FontWeight.bold,color: Colors.black,
                                fontFamily: 'Dosis',letterSpacing: 0.5),)
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: GestureDetector(
                            onTap: () {
//                                  setState(() {
//                                    productProvider.products[index].liked = !productProvider.products[index].liked;
//                                  });
//                                  productProvider.likeDislikeProduct(userId: user.userModel.id, product: productProvider.products[index], liked: productProvider.products[index].liked);
                            },
                            child: Container(),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Text("Rich in proteins",style: TextStyle(fontSize: 15.0,
                              fontWeight: FontWeight.w500,color: Colors.blueGrey,
                              fontFamily: 'Dosis'),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            "\$${widget.productModel.price / 100}",
                            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),

                          ),
                        ),
                      ],
                    ),
                    //RawMaterialButton(
                    //   shape: CircleBorder(),
                    //   fillColor: Colors.green,
                    //   onPressed: () {
                    //     showModalBottomSheet(
                    //       //this builder should return a widget
                    //       context: context,
                    //       builder: (context) => BuyProduct(
                    //           productProvider.products[index]),
                    //     );
                    //   },
                    Padding(
                      padding: const EdgeInsets.only(top:15.0),
                      child: GestureDetector(
                        onTap: () async {
                          _showDialog(app,user);
                        },
                        child: Container(

                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5.0)),
                          child:Padding(
                            padding:
                            const EdgeInsets.fromLTRB(28, 12, 28, 12),
                            child: CustomText(
                              text: "Add",
                              color: white,
                              size: 12,
                              weight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    //)
                  ],
                ),
              );
            },
          ),
        ));
  }
  void _showDialog(AppProvider app,UserProvider user) {
    int values=0;
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            Text("From:",style: TextStyle(color: Colors.grey),),
            Text(" ${widget.productModel.restaurant}",style: TextStyle(fontFamily: 'Dosis',color: Colors.green),),
            Padding(
              padding: const EdgeInsets.only(left:15.0),
              child: Positioned(
                top: 6.0,
                left: 6.0,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.0)),
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      " OPEN ",
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
          ),
          content: Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              controller: quatity,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Quantity',
              ),
              // ignore: missing_return
              validator: (value) {
                values=int.parse(value);

                if (value.isEmpty) {
                  return 'You must enter the quantity';
                }
              },
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(onPressed: ()async
            {
              print("All set loading");
              app.changeLoading();
              bool value = await values==0?user.addToCard(
                  product: widget.productModel, quantity: 5):false;
              if (value) {
                Navigator.of(context).pop();
                print("Item added to cart");
                Fluttertoast.showToast(
                    msg: "Added to basket!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
                user.reloadUserModel();
                app.changeLoading();
                return;
              } else {
                print("Item NOT added to cart");
                if(values==0)
                {
                  Fluttertoast.showToast(
                      msg: "Please enter the quantity!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                }
                else
                  {
                    Fluttertoast.showToast(
                        msg: "Something went wrong!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }


              }
              print("lOADING SET TO FALSE");
            }, child: Text("ADD")),
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
