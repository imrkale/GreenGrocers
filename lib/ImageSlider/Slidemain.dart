import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:greengrocers/Flutter_Payment/pages/home.dart';
import 'package:greengrocers/restaurantareaside/areadashboard.dart';
import 'package:greengrocers/userside/CheckoutPage/checkout.dart';
import 'package:greengrocers/userside/Profile/profile_page.dart';
import 'package:greengrocers/userside/screens/home.dart';
import 'package:greengrocers/ImageSlider/dashboard.dart';
import 'package:greengrocers/userside/screens/cart.dart';

import 'package:greengrocers/userside/screens/home.dart';
import 'package:greengrocers/userside/helpers/screen_navigation.dart';
import 'package:greengrocers/userside/screens/login.dart';
import 'package:greengrocers/userside/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:greengrocers/userside/screens/order.dart';
import 'package:greengrocers/userside/provider/user.dart';


class BottomBar extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex;
  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(

      bottomNavigationBar: BubbleBottomBar(


        opacity: 0.2,


        backgroundColor: Colors.white,


        borderRadius: BorderRadius.vertical(


          top: Radius.circular(16.0),


        ),


        currentIndex: currentIndex,


        hasInk: true,


        inkColor: Colors.black12,


        onTap: changePage,


        items: <BubbleBottomBarItem>[

          BubbleBottomBarItem(


            backgroundColor: Colors.green,


            icon: Icon(


              Icons.home_outlined,


              color: Colors.black,


            ),


            activeIcon: Icon(


              Icons.home_outlined,


              color: Colors.green,


            ),


            title: Text('Home'),


          ),


          BubbleBottomBarItem(


            backgroundColor: Colors.indigo,


            icon: Icon(


              Icons.bookmark_border,


              color: Colors.black,


            ),


            activeIcon: Icon(


              Icons.bookmark_border,


              color: Colors.indigo,


            ),

            title: Text('My Orders'),

          ),

          BubbleBottomBarItem(

            backgroundColor: Colors.deepPurple,

            icon: Icon(

              Icons.shopping_cart_outlined,

              color: Colors.black,

            ),

            activeIcon: Icon(

              Icons.shopping_cart_outlined,

              color: Colors.deepPurple,

            ),

            title: Text('Cart'),

          ),
          BubbleBottomBarItem(


            backgroundColor: Colors.red,


            icon: Icon(


              Icons.assignment_ind_outlined,


              color: Colors.black,


            ),


            activeIcon: Icon(


              Icons.assignment_ind_outlined,


              color: Colors.green,


            ),


            title: Text('Profile'),


          ),

          BubbleBottomBarItem(

            backgroundColor: Colors.green,

            icon: Icon(

              Icons.list,

              color: Colors.black,

            ),

            activeIcon: Icon(

              Icons.list,

              color: Colors.green,

            ),

            title: Text('List'),

          ),

        ],

      ),

      body: (currentIndex == 0)

          ? Home()

          : (currentIndex == 1)

          ? OrdersScreen()

          : (currentIndex == 2)

          ? CartScreen()
          : (currentIndex==3)
          ?AreaAdmin()

          :SafeArea(
            child: ListTile(
              onTap: () async{
               await user.signOut();
                changeScreenReplacement(context, LoginScreen());
              },
              leading: Icon(Icons.exit_to_app),
              title: CustomText(text: "Log out"),
            ),
          ),



    );

  }

}