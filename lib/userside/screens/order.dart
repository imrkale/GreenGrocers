import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greengrocers/userside/helpers/style.dart';
import 'package:greengrocers/userside/models/order.dart';
import 'package:greengrocers/userside/provider/app.dart';
import 'package:greengrocers/userside/provider/user.dart';
import 'package:greengrocers/userside/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    print(user.orders.length);
    user.getOrders();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        elevation: 0.0,
        title: CustomText(text: " Your Orders"),

      ),
      backgroundColor: Colors.grey.shade100,
      body: (user.orders.length)>0?ListView.builder(
          itemCount: user.orders.length,
          itemBuilder: (_, index) {
            OrderModel _order = user.orders[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.asset("images/OrdersPage.jpg",height: 320.0,),
                  Card(
                    elevation: 100.0,
                    color: Colors.white,
                    margin: EdgeInsets.only(left:10.0,right: 10.0,top: 10.0),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Text("Order ${_order.status}",style: TextStyle(color: Colors.green,
                          fontWeight: FontWeight.bold,fontSize: 20.0),),
                          Card(
                            margin: EdgeInsets.only(bottom: 10.0,top: 10.0),
                            elevation: 2.0,
                            shadowColor: Color.fromRGBO(250, 200, 200, 1),
                            child:
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                  Text(
                                    "${DateTime.fromMillisecondsSinceEpoch(_order.createdAt).toString()}",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5.0,),
                                  Text('Total ${_order.total}',style: TextStyle(color: Colors.blue,
                                  fontWeight: FontWeight.bold,fontSize: 15.0),)
                            ],
                            ),
                              )
                          ),
                          Container(
                            height: 250.0,
                            child: ListView.builder(
                                itemCount: _order.cart.length,
                                itemBuilder: (_,index){
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(left: 0.0, right: 10.0),
                                              child: Container(
                                                height: MediaQuery.of(context).size.width/3.5,
                                                width: MediaQuery.of(context).size.width/3,
                                                child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                    child: Image.network(
                                                      _order.cart[index].image,
                                                      fit: BoxFit.cover,
                                                    ),
                                                ),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Text(
                                                  _order.cart[index].name,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                                SizedBox(height: 10.0),
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                      "${_order.cart[index].areaname[0]}",
                                                      style: TextStyle(
                                                        fontSize: 12.0,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.grey
                                                      ),
                                                    ),
                                                    SizedBox(width: 10.0),

                                                    Text(
                                                      r"$ "+"${_order.cart[index].price}",
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight: FontWeight.w900,
                                                        color: Theme.of(context).accentColor,
                                                      ),
                                                    ),

                                                  ],
                                                ),

                                                SizedBox(height: 10.0),

                                                Text(
                                                  "Quantity: ${_order.cart[index].quantity}",
                                                  style: TextStyle(

                                                      fontSize: 12.0,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.grey
                                                  ),
                                                ),
                                                SizedBox(height: 10.0),

                                                Text(
                                                  "${_order.cart[index].restaurant}",
                                                  style: TextStyle(

                                                      fontSize: 12.0,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.green.shade400
                                                  ),
                                                ),


                                              ],

                                            ),
                                          ],
                                        ),
                                      ),
                                      index==(_order.cart.length)-1? Container(height:0.0):Container(height: 1.0,color: Colors.grey,
                                        width: MediaQuery.of(context).size.width/1.5,)],
                                  );
                                }),
                          ),
                        ],
                      ),
                    )
                  ),
                ],
              ),
            );
          }):Text("No Orders"),
    );
  }

  Widget stores(List<dynamic> restaurant) {
    for (int i = 0; i < restaurant.length; i++) {
      print(restaurant[i]);
      return Text(restaurant[i] + "\n");
    }
  }

  Widget contacts(List<dynamic> contact) {
    for (int i = 0; i < contact.length; i++) {
      return Text(contact[i] + "\n");
    }
  }
}
