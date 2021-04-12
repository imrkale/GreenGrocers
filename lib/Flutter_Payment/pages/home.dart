import 'package:flutter/material.dart';
import 'package:greengrocers/Flutter_Payment/pages/transaction_success.dart';
import 'package:greengrocers/Flutter_Payment/services/payment-service.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:greengrocers/userside/provider/user.dart';
import 'package:provider/provider.dart';
import 'package:greengrocers/userside/models/cart_item.dart';


class HomePagePayment extends StatefulWidget {
  HomePagePayment({Key key}) : super(key: key);
  @override
  HomePagePaymentState createState() => HomePagePaymentState();
}

class HomePagePaymentState extends State<HomePagePayment> {
  final _key = GlobalKey<ScaffoldState>();
  onItemPress({BuildContext context, int index,int amount, UserProvider user}) async {
    switch(index) {
      case 0:
        payViaNewCard(context,amount*100);
        break;
      case 1:
        Navigator.pushNamed(context, '/existing-cards');
        break;
      case 2:
        for (CartItemModel cartItem
                in user.userModel.cart) {
              bool value =
                  await user.removeFromCart(
                      cartItem: cartItem);
              if (value) {
                user.reloadUserModel();
                print("Item added to cart");
                _key.currentState.showSnackBar(
                    SnackBar(
                        content: Text(
                            "Removed from Cart!")));
              } else {
                print("ITEM WAS NOT REMOVED");
              }
            }
    }
  }

  payViaNewCard(BuildContext context,int amountt) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(
        message: 'Please wait...'
    );
    await dialog.show();
    var response = await StripeService.payWithNewCard(
        amount: '${amountt}',
        currency: 'INR'
    );
    await dialog.hide();
    // Scaffold.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text(response.message),
    //       duration: new Duration(milliseconds: response.success == true ? 1200 : 3000),
    //     )
    // );
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => Transaction_Successful()));
  }

  @override
  void initState() {
    super.initState();
    StripeService.init();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.separated(
            itemBuilder: (context, index) {
              Icon icon;
              Text text;

              switch(index) {
                case 0:
                  icon = Icon(Icons.add_circle, color: theme.primaryColor);
                  text = Text('Pay via new card');
                  break;
                case 1:
                  icon = Icon(Icons.credit_card, color: theme.primaryColor);
                  text = Text('Pay via existing card');
                  break;
                case 2:
                  icon=Icon(Icons.payments_sharp, color: theme.primaryColor,);
                  text=Text('Pay on Delivery');
                  break;
              }

              return InkWell(
                onTap: () {
                  onItemPress(context:context,index: index,amount: user.userModel.totalCartPrice+50,user: user);
                },
                child: ListTile(
                  title: text,
                  leading: icon,
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(
              color: theme.primaryColor,
            ),
            itemCount: 3
        ),
      ),
    );;
  }
}
