import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:greengrocers/ExternalUIDesign/util/categories.dart';
import 'package:greengrocers/ExternalUIDesign/widgets/category_item.dart';
import 'package:greengrocers/ImageSlider/dashboard.dart';
import 'package:greengrocers/userside/SilverAppBar.dart';
import 'package:greengrocers/userside/screens/cart.dart';
import 'package:greengrocers/userside/screens/login.dart';
import 'package:greengrocers/userside/screens/order.dart';
import 'package:greengrocers/userside/widgets/TopPicks.dart';
import 'package:greengrocers/global.dart';
import 'package:greengrocers/userside/Animation/FadeAnimation.dart';
import 'package:greengrocers/userside/provider/user.dart';
import 'package:greengrocers/userside/helpers/screen_navigation.dart';
import 'package:greengrocers/userside/helpers/style.dart';
import 'package:greengrocers/userside/provider/app.dart';
import 'package:greengrocers/userside/provider/category.dart';
import 'package:greengrocers/userside/provider/product.dart';
import 'package:greengrocers/userside/provider/restaurant.dart';
import 'package:greengrocers/userside/screens/category.dart';
import 'package:greengrocers/userside/screens/product_search.dart';
import 'package:greengrocers/userside/screens/restaurant.dart';
import 'package:greengrocers/userside/screens/restaurants_search.dart';
import 'package:greengrocers/userside/widgets/categories.dart';
import 'package:greengrocers/userside/widgets/custom_text.dart';
import 'package:greengrocers/userside/widgets/featured_products.dart';
import 'package:greengrocers/userside/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:greengrocers/ExternalUIDesign/widgets/slide_item.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final double maxSlide = 225.0;
  AnimationController animationController;

  // @override
  // void initState() {
  //   super.initState();
  //   animationController =
  //       AnimationController(vsync: this, duration: Duration(milliseconds: 250));
  // }
  //
  // void toggle() => animationController.isDismissed
  //     ? animationController.forward()
  //     : animationController.reverse();

  @override
  Widget build(BuildContext context) {
    var size =
        MediaQuery.of(context).size; //total height and width of ou screen
    final app = Provider.of<AppProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final user = Provider.of<UserProvider>(context);

    var myDrawer = Container(
      color: Colors.grey,
    );
    Widget myChild = app.isLoading
        ? Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Loading()],
      ),
    )
        : Container(
      color: Colors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: <Widget>[
                  // Stack(
                  //   children: [
                  //     Container(
                  //       // Here the height of the container is 45% of our total height
                  //       height: size.height * .30,
                  //       decoration: BoxDecoration(
                  //         color: Color(0xFFF5CEB8),
                  //       ),
                  //     ),
                  //     SafeArea(
                  //       child: Padding(
                  //         padding: const EdgeInsets.symmetric(
                  //             horizontal: 25, vertical: 15.0),
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: <Widget>[
                  //             Align(
                  //               alignment: Alignment.topRight,
                  //               child: GestureDetector(
                  //                 onTap: (){},
                  //                 child: Container(
                  //                   alignment: Alignment.center,
                  //                   height: 52,
                  //                   width: 52,
                  //                   decoration: BoxDecoration(
                  //                     color: Color(0xFFF2BEA1),
                  //                     shape: BoxShape.circle,
                  //                   ),
                  //                   child: Icon(
                  //                       Icons.notifications_none_sharp),
                  //                 ),
                  //               ),
                  //             ),
                  //             Text(
                  //               "Welcome ${user.userModel.name}",
                  //               style: Theme.of(context)
                  //                   .textTheme
                  //                   .display1
                  //                   .copyWith(
                  //                   fontWeight: FontWeight.w900,
                  //                   fontSize: 20.0),
                  //             ),
                  //             SizedBox(
                  //               height: 10.0,
                  //             ),
                  //             Text(
                  //               "Grocify \nyour needs!",
                  //               style: Theme.of(context)
                  //                   .textTheme
                  //                   .display1
                  //                   .copyWith(
                  //                   fontWeight: FontWeight.w900,
                  //                   fontSize: 30.0),
                  //             ),
                  //             Padding(
                  //               padding: const EdgeInsets.only(top: 25.0),
                  //               child: Container(
                  //                 decoration: BoxDecoration(
                  //                     color: Colors.grey,
                  //                     borderRadius: BorderRadius.all(
                  //                         Radius.circular(25))),
                  //                 child: Padding(
                  //                   padding: const EdgeInsets.only(
                  //                       top: 2.5,
                  //                       left: 2.5,
                  //                       right: 2.5,
                  //                       bottom: 2.5),
                  //                   child: Container(
                  //                     decoration: BoxDecoration(
                  //                       color: white,
                  //                       borderRadius:
                  //                       BorderRadius.circular(20),
                  //                     ),
                  //                     child: ListTile(
                  //                       leading: Icon(
                  //                         Icons.search,
                  //                         color: Colors.grey,
                  //                       ),
                  //                       title: TextField(
                  //                         textInputAction:
                  //                         TextInputAction.search,
                  //                         onSubmitted: (pattern) async {
                  //                           app.changeLoading();
                  //                           if (app.search ==
                  //                               SearchBy.PRODUCTS) {
                  //                             await productProvider
                  //                                 .search(
                  //                                 productName:
                  //                                 pattern);
                  //                             changeScreen(context,
                  //                                 ProductSearchScreen());
                  //                           } else {
                  //                             await restaurantProvider
                  //                                 .search(name: pattern);
                  //                             changeScreen(context,
                  //                                 RestaurantsSearchScreen());
                  //                           }
                  //                           app.changeLoading();
                  //                         },
                  //                         decoration: InputDecoration(
                  //                           hintText:
                  //                           "Find Grocery and Store",
                  //                           border: InputBorder.none,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(235, 210, 200, 1),
                        borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(40))),
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Find Your',
                          style: TextStyle(color: Colors.black87, fontSize: 25),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Groceries',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(244, 243, 243, 1),
                              borderRadius: BorderRadius.circular(20)),
                          child: TextField(
                            textInputAction:
                            TextInputAction.search,
                            onSubmitted: (pattern) async {
                              app.changeLoading();
                              if (app.search ==
                                  SearchBy.PRODUCTS) {
                                await productProvider
                                    .search(
                                    productName:
                                    pattern);
                                changeScreen(context,
                                    ProductSearchScreen());
                              } else {
                                await restaurantProvider
                                    .search(name: pattern);
                                changeScreen(context,
                                    RestaurantsSearchScreen());
                              }
                              app.changeLoading();
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.black87,
                                ),
                                hintText: "Search you're looking for",
                                hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 15)),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:15.0),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          CustomText(
                            text: "Search by:",
                            color: grey,
                            weight: FontWeight.w300,
                          ),
                          DropdownButton<String>(
                            value: app.filterBy,
                            style: TextStyle(
                                color: darkGreen,
                                fontWeight: FontWeight.w300),
                            icon: Icon(
                              Icons.filter_list,
                              color: darkGreen,
                            ),
                            elevation: 0,
                            onChanged: (value) {
                              if (value == "Products") {
                                app.changeSearchBy(
                                    newSearchBy: SearchBy.PRODUCTS);
                              } else {
                                app.changeSearchBy(
                                    newSearchBy: SearchBy.RESTAURANTS);
                              }
                            },
                            items: <String>[
                              "Products",
                              "Restaurants"
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                  value: value, child: Text(value));
                            }).toList(),
                          ),
                        ],
                      ),
                      Divider(),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 100,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categoryProvider.categories.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
//                              app.changeLoading();
                                  await productProvider
                                      .loadProductsByCategory(
                                      categoryName: categoryProvider
                                          .categories[index].name);

                                  changeScreen(
                                      context,
                                      CategoryScreen(
                                        categoryModel: categoryProvider
                                            .categories[index],
                                      ));

//                              app.changeLoading();
                                },
                                child: FadeAnimation(
                                  1,
                                  CategoryWidget(
                                    category:
                                    categoryProvider.categories[index],
                                  ),
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Dashboard(),
                      SizedBox(
                        height: 40,
                      ),
                      Text("Top Buys",style: TextStyle(fontSize: 25.0,
                          fontWeight: FontWeight.bold,color: Colors.black,
                          fontFamily: 'Dosis',letterSpacing: 1.0),),
                      SizedBox(
                        height: 14,
                      ),
                      // height: MediaQuery.of(context).size.height / 6,
                      // width: MediaQuery.of(context).size.height / 6,
                      Container(
                        height: 300,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 17),
                              blurRadius: 10,
                              spreadRadius: -10,
                              color: kShadowColor,
                            ),
                          ],
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            //Add one stop for each color. Stops should increase from 0 to 1
                            colors: [
                              darkGreen.withOpacity(0.6),
                              Colors.green.withOpacity(0.6),
                              darkGreen.withOpacity(0.2),
                              darkGreen.withOpacity(0.4),
                              darkGreen.withOpacity(0.1),
                              Colors.green.withOpacity(0.5),
                              darkGreen.withOpacity(0.2),
                            ],
                            // stops: [0.0, 0.1],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: GridView.count(
                            crossAxisCount: 2,
                            childAspectRatio: .85,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 25,
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              CategoryCard(
                                title: "Diet Recommendation",
                                svgSrc: "images/edible.png",
                                press: () {},
                              ),
                              Container(
                                child: CategoryCard(
                                  title: "Kegel Exercises",
                                  svgSrc: "images/grocery-bag.png",
                                  press: () {},
                                ),
                              ),
                              CategoryCard(
                                title: "Meditation",
                                svgSrc: "images/menu1.png",
                                press: () {},
                              ),
                              CategoryCard(
                                title: "Yoga",
                                svgSrc: "images/menu2.png",
                                press: () {},
                              ),
                              CategoryCard(
                                title: "Yoga",
                                svgSrc: "images/menu2.png",
                                press: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Featured",style: TextStyle(fontSize: 25.0,
                                fontWeight: FontWeight.bold,color: Colors.black,
                                fontFamily: 'Dosis',letterSpacing: 1.0),),
                            FlatButton(
                              onPressed: () {
                                app.changeLoading();
                                changeScreen(context, GroceryList());
                                app.changeLoading();
                              },
                              child: CustomText(
                                text: "View All",
                                size: 13,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Featured(),
                      Card(elevation:10.0,child: Image.asset("images/deskback.jpg")),
                      SizedBox(height: 15.0,),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:10.0),
                            child: Text("By Nutrients",style: TextStyle(fontSize: 25.0,
                                fontWeight: FontWeight.bold,color: Colors.black,
                                fontFamily: 'Dosis',letterSpacing: 1.0),),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.0,),
                      Container(
                        height: 100,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return
                                FadeAnimation(
                                  1,
                                  CategoryItem(
                                    cat: nutrients[index],
                                    index: index,
                                  ),
                                );
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Popular Stores",style: TextStyle(fontSize: 25.0,
                                fontWeight: FontWeight.bold,color: Colors.black,
                                fontFamily: 'Dosis',letterSpacing: 1.0),),
                            FlatButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>GroceryList()));
                              },
                              child: CustomText(
                                text: "View All",
                                size: 13,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          height:600.0,
                          child: ListView(
                            children: restaurantProvider.restaurants
                                .map((item) => GestureDetector(
                              onTap: () async {
                                app.changeLoading();

                                await productProvider
                                    .loadProductsByRestaurant(
                                    restaurantId: item.id);
                                await productProvider
                                    .loadProductByVegetables(
                                    item.name, "Leafy Green");
                                await productProvider
                                    .loadProductByVegetables(
                                    item.name, "Root");
                                await productProvider
                                    .loadProductByVegetables(
                                    item.name, "Marrow");
                                await productProvider
                                    .loadProductByVegetables(
                                    item.name, "Stem");
                                await productProvider
                                    .loadProductByVegetables(
                                    item.name, "Edible");
                                await productProvider
                                    .loadProductByVegetables(
                                    item.name, "Cruciferous");
                                app.changeLoading();

                                changeScreen(
                                    context,
                                    RestaurantScreen(
                                      restaurantModel: item,
                                    ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 7.0, right: 7.0),
                                child: SlideItem(
                                  restaurantModel: item,
                                ),
                              ),
                            ))
                                .toList(),
                          ),
                        ),
                      )
                    ],),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
    return Scaffold(
      body: myChild,
      // body: AnimatedBuilder(
      //   animation: animationController,
      //   builder: (context, _) {
      //     double slide = maxSlide * animationController.value;
      //     double scale = 1 - (animationController.value * 0.3);
      //     return Stack(
      //       children: [
      //         myDrawer,
      //         Transform(
      //           transform: Matrix4.identity()
      //             ..translate(slide)
      //             ..scale(scale),
      //           alignment: Alignment.centerLeft,
      //           child: myChild,
      //         ),
      //       ],
      //     );
      //   },
      // ),
      //
      // drawer: Drawer(
      //   child: ListView(
      //     children: <Widget>[
      //       UserAccountsDrawerHeader(
      //         decoration: BoxDecoration(color: primary),
      //         accountName: CustomText(
      //           text: user.userModel?.name ?? "username lading...",
      //           color: white,
      //           weight: FontWeight.bold,
      //           size: 18,
      //         ),
      //         accountEmail: CustomText(
      //           text: user.userModel?.email ?? "email loading...",
      //           color: white,
      //         ),
      //       ),
      //       ListTile(
      //         onTap: () {
      //           changeScreen(context, Home());
      //         },
      //         leading: Icon(Icons.home),
      //         title: CustomText(text: "Home"),
      //       ),
      //       ListTile(
      //         onTap: () async {
      //           await user.getOrders();
      //           changeScreen(context, OrdersScreen());
      //         },
      //         leading: Icon(Icons.bookmark_border),
      //         title: CustomText(text: "My orders"),
      //       ),
      //       ListTile(
      //         onTap: () {
      //           changeScreen(context, CartScreen());
      //         },
      //         leading: Icon(Icons.shopping_cart),
      //         title: CustomText(text: "Cart"),
      //       ),
      //       ListTile(
      //         onTap: () {
      //           user.signOut();
      //           changeScreenReplacement(context, LoginScreen());
      //         },
      //         leading: Icon(Icons.exit_to_app),
      //         title: CustomText(text: "Log out"),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
