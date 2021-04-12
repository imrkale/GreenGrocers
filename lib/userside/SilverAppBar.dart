import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:greengrocers/userside/provider/user.dart';
import 'package:greengrocers/userside/helpers/screen_navigation.dart';
import 'package:greengrocers/userside/provider/app.dart';
import 'package:greengrocers/userside/provider/category.dart';
import 'package:greengrocers/userside/provider/product.dart';
import 'package:greengrocers/userside/provider/restaurant.dart';
import 'package:greengrocers/userside/screens/product_search.dart';
import 'package:greengrocers/userside/screens/restaurants_search.dart';
import 'package:provider/provider.dart';
import 'package:greengrocers/userside/widgets/grocerywidget.dart';
import 'package:greengrocers/userside/screens/details.dart';
class GroceryList extends StatefulWidget {
  @override
  _GroceryListState createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: RightWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
class LeftWidget extends StatefulWidget {
  @override
  _LeftWidgetState createState() => _LeftWidgetState();
}

class _LeftWidgetState extends State<LeftWidget> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Container(
      height: 500.0,
      color: Colors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                  children: [
                    GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 0.70,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      children: List.generate(8, (index) {
                        return GestureDetector(
                          onTap: (){
                            changeScreen(context, Details(product: productProvider.products[index]));
                          },
                          child: Grocerydesign(productProvider.products[1]),
                        );
                      },
                      ),
                    ),
                  ]
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RightWidget extends StatefulWidget {
  @override
  _RightWidgetState createState() => _RightWidgetState();
}

class _RightWidgetState extends State<RightWidget> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
  }

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppProvider>(context);
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(
          left: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20,bottom: 10.0),
              child: Text("Groceries",style: TextStyle(fontSize: 30.0,
                  fontWeight: FontWeight.bold,color: Colors.blueGrey,
                  fontFamily: 'Dosis',letterSpacing: 1.0),),

            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 8,right: 10.0,bottom: 10),
              child: Card(
                elevation: 5.0,
                child: ListTile(

                  leading: Icon(
                    Icons.search,
                    color: Colors.lightGreen,
                  ),
                  title: TextField(
                    textInputAction: TextInputAction.search,
                    onSubmitted: (pattern) async {
                      app.changeLoading();
                        await productProvider.search(
                            productName: pattern);
                        changeScreen(context, ProductSearchScreen());

                      app.changeLoading();
                    },
                    decoration: InputDecoration(
                      hintText: "Find Groceries",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  "Sort by:",
                  style:TextStyle(color: Colors.grey,
                    fontWeight: FontWeight.w300,),
                ),
                DropdownButton<String>(
                  value: app.filterBy,
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.w300),
                  icon: Icon(
                    Icons.filter_list,
                    color: Colors.green,
                  ),
                  elevation: 0,
                  onChanged: (value) {
                    if (value == "Products") {
                      app.changeSearchBy(newSearchBy: SearchBy.PRODUCTS);
                    } else {
                      app.changeSearchBy(
                          newSearchBy: SearchBy.RESTAURANTS);
                    }
                  },
                  items: <String>["Products", "Restaurants"]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                        value: value, child: Text(value));
                  }).toList(),
                ),
              ],
            ),

            Text("Categories",style: TextStyle(fontSize: 25.0,
                fontWeight: FontWeight.bold,color: Colors.blueGrey,
                fontFamily: 'Dosis',letterSpacing: 1.0),),
            SizedBox(height: 5.0,),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: SizedBox(
                height: 30,
                child: TabBar(
                  isScrollable: true,
                  unselectedLabelColor: Colors.black,
                  labelColor: Color(0xffED305A),
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: Color(0x55B71C1C),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  tabs: <Widget>[
                    Tab(
                      text: "All",
                    ),
                    Tab(
                      text: "Proteins",
                    ),
                    Tab(
                      text: "Vitamins",
                    ),
                    Tab(
                      text: "Calcium",
                    ),
                    Tab(
                      text: "Magnesium",
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  LeftWidget(),
                  LeftWidget(),
                  LeftWidget(),
                  LeftWidget(),
                  LeftWidget(),
                  ],
              ),
            )
          ],
        ),
      ),
    );
  }
}









