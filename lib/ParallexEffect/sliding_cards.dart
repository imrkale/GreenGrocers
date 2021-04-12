import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:greengrocers/ExternalUIDesign/screens/main_screen.dart';
import 'package:greengrocers/userside/helpers/screen_navigation.dart';
import 'dart:math' as math;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:greengrocers/userside/helpers/style.dart';
import 'package:greengrocers/userside/provider/app.dart';
import 'package:greengrocers/userside/provider/user.dart';
import 'package:greengrocers/userside/widgets/custom_text.dart';
import 'package:greengrocers/userside/widgets/loading.dart';
import 'package:greengrocers/userside/provider/product.dart';
import 'package:greengrocers/userside/screens/details.dart';
import 'package:provider/provider.dart';
import 'package:greengrocers/userside/models/products.dart';

class SlidingCardsView extends StatefulWidget {
  SlidingCardsView();
  @override
  _SlidingCardsViewState createState() => _SlidingCardsViewState();
}

class _SlidingCardsViewState extends State<SlidingCardsView> {
  PageController pageController;
  double pageOffset = 0;
  int cnt=0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
    pageController.addListener(() {
      setState(() => pageOffset = pageController.page);
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    print(MediaQuery.of(context).size.height * 0.55,);
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      child: PageView(
        controller: pageController,
        children: <Widget>[
                for(int i=0;i<productProvider.products.length;i++)
                  SlidingCard(
                    name: productProvider.products[i].name,
                    productModel: productProvider.products[i],
                    offset: pageOffset-i,)


        ],
      ),
    );
  }
}

class SlidingCard extends StatelessWidget {
  final String name;
  final ProductModel productModel;
  final double offset;


  const SlidingCard({
    Key key,
    @required this.name,
    @required this.productModel,
    @required this.offset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08));
    return Transform.translate(
      offset: Offset(-32 * gauss * offset.sign, 0),
      child: GestureDetector(
        onTap: (){
          changeScreen(context, Details(product: productModel));
        },
        child: Card(
          margin: EdgeInsets.only(left: 15, right: 40, bottom: 110),
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: Column(
            children: <Widget>[
              Hero(
                tag: productModel.image,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image:productModel.image,
                    height: 150,//MediaQuery.of(context).size.height * 0.3
                    alignment: Alignment(-offset.abs(), 0),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Expanded(
                child: CardContent(
                  productModel:productModel,
                  name: name,
                  store: productModel.restaurant,
                  price: productModel.price,
                  offset: gauss,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardContent extends StatefulWidget {
  final String name;
  final String store;
  final double offset;
  final int price;
  final ProductModel productModel;

  const CardContent({Key key,
    @required this.productModel,
    @required this.name,
    @required this.store,
    @required this.price,
    @required this.offset})
      : super(key: key);
  @override
  _CardContentState createState() => _CardContentState();
}
class _CardContentState extends State<CardContent> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Transform.translate(
                    offset: Offset(8 * widget.offset, 0),
                    child: Text(widget.name, style: TextStyle(fontSize: 20)),
                  ),
                  SizedBox(height: 8),
                  Transform.translate(
                    offset: Offset(32 * widget.offset, 0),
                    child: Text(
                      widget.store,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left:100.0),
                child: Transform.translate(
                  offset: Offset(32 * widget.offset, 0),
                  child: Text(
                    '${widget.price}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),

            ],
          ),
          SizedBox(height: 15.0,),
          Row(
            children: <Widget>[
              Transform.translate(
                offset: Offset(48 * widget.offset, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(
                          Icons.remove,
                          size: 15,
                        ),
                        onPressed: () {
                          if (quantity != 1) {
                            setState(() {
                              quantity -= 1;
                            });
                          }
                        }),
                    Transform.translate(
                      offset: Offset(24 * widget.offset, 0),
                      child: GestureDetector(
                        onTap: () async {
                          print("All set loading");
                          app.changeLoading();
                          bool value = await user.addToCard(
                              product: widget.productModel, quantity: quantity);
                          if (value) {
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
                          }
                          print("lOADING SET TO FALSE");
                        },
                        child: Container(
                          height: 40.0,
                          decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(15)),
                          child: app.isLoading
                              ? Loading()
                              : Padding(
                            padding:
                            const EdgeInsets.fromLTRB(28, 12, 28, 12),
                            child: CustomText(
                              text: "Add $quantity",
                              color: white,
                              size: 15,
                              weight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.add,
                          size: 15,
                          color: red,
                        ),
                        onPressed: () {
                          setState(() {
                            quantity += 1;
                          });
                        }),
                  ],
                ),
              ),
              // Transform.translate(
              //   offset: Offset(48 * offset, 0),
              //   child: RaisedButton(
              //     color: Color(0xFF162A49),
              //     child: Transform.translate(
              //       offset: Offset(24 * offset, 0),
              //       child: Text('ADD'),
              //     ),
              //     textColor: Colors.white,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(32),
              //     ),
              //     onPressed: () {
              //
              //     },
              //   ),
              // ),


            ],
          )
        ],
      ),
    );
  }
}
