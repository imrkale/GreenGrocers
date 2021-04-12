import 'package:flutter/material.dart';
import 'package:greengrocers/global.dart';
import 'package:greengrocers/userside/models/products.dart';

class BuyProduct extends StatefulWidget {
  final ProductModel product;
  const BuyProduct(this.product);
  @override
  _BuyProductState createState() => _BuyProductState();
}

class _BuyProductState extends State<BuyProduct> {
  bool library = true;
  bool services = false;
  bool lottery = false;
  int quantity = 1;
  bool Loading = false;
  final _key = GlobalKey<ScaffoldState>();
  var selectedCard = 'WEIGHT';
  int price = 0;
  Widget tab;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: Container(
        color: Color(0xFF737373),
        child: ListView(
          children: [
            Stack(
              children: <Widget>[

                Positioned(
                    top: 40.0,
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(45.0),
                            topRight: Radius.circular(45.0),
                          ),
                          gradient: new LinearGradient(
                              colors: [darkGreen, lightBlueColor],
                              begin: const FractionalOffset(0.7, 0.7),
                              end: const FractionalOffset(0.2, 0.2),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width)),
                Center(
                  child: Hero(
                      tag: widget.product.image,
                      child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(widget.product.image),
                                  fit: BoxFit.cover)),
                          height: 200.0,
                          width: 250.0)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 230.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(widget.product.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 15.0),
                      Text("\$${widget.product.price}",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 20.0,
                              color: Colors.grey)),
                      SizedBox(height: 15.0),
                      Text(
                        "Description",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w300),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.product.description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Center(
                          child: Container(
                              height: 140.0,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  _buildInfoCard('WEIGHT', '300', 'G'),
                                  SizedBox(width: 10.0),
                                  _buildInfoCard('CALORIES', '267', 'CAL'),
                                  SizedBox(width: 10.0),
                                  _buildInfoCard('VITAMINS', 'A, B6', 'VIT'),
                                  SizedBox(width: 10.0),
                                  _buildInfoCard('AVAIL', 'NO', 'AV'),
                                  SizedBox(width: 10.0),
                                  _buildInfoCard('AVAIL', 'NO', 'AV'),
                                ],
                              )),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, bottom: 8.0, left: 8.0, right: 4.0),
                            child: IconButton(
                                icon: Icon(
                                  Icons.remove,
                                  size: 36,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  if (quantity != 1) {
                                    setState(() {
                                      quantity -= 1;
                                    });
                                  }
                                }),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(28, 12, 28, 12),
                              child: Text(
                                "Get $quantity",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, bottom: 8.0, right: 8.0, left: 4.0),
                            child: IconButton(
                                icon: Icon(
                                  Icons.add,
                                  size: 36,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    quantity += 1;
                                  });
                                }),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget cryptoLottery() {
    return Container(
      height: 100,
    );
  }

  Widget cryptoServices() {
    return Container(
      height: 100,
    );
  }

  Widget _buildInfoCard(String cardTitle, String info, String unit) {
    return InkWell(
        onTap: () {
          selectCard(cardTitle);
        },
        child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: cardTitle == selectedCard ? darkGreen : Colors.white,
              border: Border.all(
                  color: cardTitle == selectedCard
                      ? Colors.transparent
                      : Colors.grey.withOpacity(0.3),
                  style: BorderStyle.solid,
                  width: 0.75),
            ),
            height: 80.0,
            width: 80.0,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 15.0),
                    child: Text(cardTitle,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12.0,
                          color: cardTitle == selectedCard
                              ? Colors.white
                              : Colors.grey.withOpacity(0.7),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(info,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 14.0,
                                color: cardTitle == selectedCard
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold)),
                        Text(unit,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 12.0,
                              color: cardTitle == selectedCard
                                  ? Colors.white
                                  : Colors.black,
                            ))
                      ],
                    ),
                  )
                ])));
  }

  selectCard(cardTitle) {
    setState(() {
      selectedCard = cardTitle;
    });
  }
}
