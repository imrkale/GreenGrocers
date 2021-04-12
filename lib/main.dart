import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:greengrocers/ExternalUIDesign/widgets/category_item.dart';
import 'package:greengrocers/ImageSlider/Slidemain.dart';
import 'package:greengrocers/ParallexEffect/home_page.dart';
import 'package:greengrocers/userside/provider/app.dart';
import 'package:greengrocers/userside/provider/category.dart';
import 'package:greengrocers/userside/provider/product.dart';
import 'package:greengrocers/userside/provider/restaurant.dart';
import 'package:greengrocers/userside/provider/user.dart';
import 'package:greengrocers/userside/screens/home.dart';
import 'package:greengrocers/userside/screens/login.dart';
import 'package:greengrocers/Flutter_Payment/pages/existing-cards.dart';
import 'package:greengrocers/userside/screens/splash.dart';
import 'package:greengrocers/userside/widgets/featured_products.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppProvider()),
        ChangeNotifierProvider.value(value: UserProvider.initialize()),
        ChangeNotifierProvider.value(value: CategoryProvider.initialize()),
        ChangeNotifierProvider.value(value: RestaurantProvider.initialize()),
        ChangeNotifierProvider.value(value: ProductProvider.initialize()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MarketYard',
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: ScreensController(),
        routes: {
      '/existing-cards': (context) => ExistingCardsPage()
      },)));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
    switch (auth.status) {
      case Status.Uninitialized:
        return Splash();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginScreen();
      case Status.Authenticated:
        return BottomBar();
      default:
        return LoginScreen();
    }
  }
}
