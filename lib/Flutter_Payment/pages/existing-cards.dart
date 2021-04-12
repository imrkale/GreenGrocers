import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:greengrocers/Flutter_Payment/pages/transaction_success.dart';
import 'package:greengrocers/Flutter_Payment/services/payment-service.dart';
import 'package:greengrocers/userside/models/payment_card.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:greengrocers/userside/provider/app.dart';
import 'package:greengrocers/userside/provider/user.dart';
import 'package:provider/provider.dart';

class ExistingCardsPage extends StatefulWidget {
  ExistingCardsPage({Key key}) : super(key: key);

  @override
  ExistingCardsPageState createState() => ExistingCardsPageState();
}

class ExistingCardsPageState extends State<ExistingCardsPage> {
  List cards = [{
    'cardNumber': '378282246310005',
    'expiryDate': '04/24',
    'cardHolderName': 'Kale Raj Dnyaneshwar',
    'cvvCode': '424',
    'showBackView': false,
  }, {
    'cardNumber': '5555555555554444',
    'expiryDate': '04/23',
    'cardHolderName': 'Tracer',
    'cvvCode': '123',
    'showBackView': false,
  }];

  payViaExistingCard(BuildContext context,PaymentCard card,int amount) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(
        message: 'Please wait...'
    );
    await dialog.show();
    print("aaaaaaaaaaaaaaaaaaaaaaaaa111111111111");
    var expiryArr = card.expiryDate.split('/');
    print("aaaaaaaaaaaaaaaaaaaaaaaaa222222222222");
    CreditCard stripeCard = CreditCard(
      number: card.cardNumber,
      expMonth: int.parse(expiryArr[0]),
      expYear: int.parse(expiryArr[1]),
    );
    print("aaaaaaaaaaaaaaaaaaaaaaaaa");


    var response = await StripeService.payViaExistingCard(
        amount: '${amount*100}',
        currency: 'INR',
        card: stripeCard
    );
    print(response);
    await dialog.hide();
    // Scaffold.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text(response.message),
    //       duration: new Duration(milliseconds: 1200),
    //     )
    // ).closed.then((_) {
      Navigator.push(
          context, MaterialPageRoute(builder: (BuildContext context) => Transaction_Successful()));
    // });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose existing card'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: (user.userModel.pay_card.length)>0?user.userModel.pay_card.length:0,
          itemBuilder: (BuildContext context, int index) {
            print("fhjsafhbijiasjfsdfddsfdfdf");

            return InkWell(
              onTap: () {
                payViaExistingCard(context,PaymentCard.fromMap(user.userModel.pay_card[index].toMap()),user.userModel.totalCartPrice+50);
              },
              child: CreditCardWidget(
                cardNumber: user.userModel.pay_card[index].cardNumber,
                expiryDate: user.userModel.pay_card[index].expiryDate,
                cardHolderName: user.userModel.pay_card[index].cardHolderName,
                cvvCode: user.userModel.pay_card[index].cvvCode,
                showBackView: user.userModel.pay_card[index].showBackView,
              ),
            );
          },
        ),
      ),
    );
  }
}