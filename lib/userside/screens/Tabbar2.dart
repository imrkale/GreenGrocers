import 'package:greengrocers/userside/models/products.dart';
import 'package:greengrocers/userside/widgets/product.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:greengrocers/userside/provider/app.dart';
import 'package:greengrocers/userside/provider/user.dart';
import 'package:greengrocers/userside/widgets/loading.dart';
import 'package:greengrocers/userside/helpers/style.dart';
import 'package:greengrocers/userside/widgets/custom_text.dart';
import 'package:greengrocers/userside/provider/product.dart';

class HomeTopTabs extends StatefulWidget {

  HomeTopTabs(this.colorVal,this.restaurant,this.keys);
  int colorVal;
  String restaurant;
  final keys;

  _HomeTopTabsState createState() => _HomeTopTabsState();
}

class _HomeTopTabsState extends State<HomeTopTabs> with SingleTickerProviderStateMixin{
  TabController _tabController;
  int quantity = 1;
  final _key = GlobalKey<ScaffoldState>();
  var selectedCard = 'WEIGHT';
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 6);
    _tabController.addListener(_handleTabSelection);
  }
  void _handleTabSelection() {
    setState(() {
      widget.colorVal=0xff228B22;
    });
  }
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);

    return DefaultTabController(
      length:6,
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.green,
          toolbarHeight: 50.0,
          backgroundColor: Colors.white,
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorWeight: 2.0,
            indicator: BoxDecoration(
              color: Colors.lightGreen,//Color(0x55B71C1C),
              borderRadius: BorderRadius.circular(5.0)
              // borderRadius: BorderRadius.only(
              //   topRight: Radius.circular(20),
              //   bottomLeft: Radius.circular(20),
              // ),
            ),
            unselectedLabelColor: Colors.grey,
            tabs: <Widget>[
              Tab(
                child:Column(
                  children: [
                    Image.asset("images/lettuce.png",width: 25.0,),
                    SizedBox(height: 5.0,),
                    Text('Leafy Green',style: TextStyle( color: _tabController.index == 0
                        ?  Color( widget.colorVal)
                        : Colors.blueGrey)),

                  ],
                ),
              ),
              Tab(
                child: Column(
                  children: [
                    Image.asset("images/potatoicon.png",width: 25.0,),
                    SizedBox(height: 5.0,),
                    Text('Root',style: TextStyle( color: _tabController.index == 1
                        ?  Color( widget.colorVal)
                        : Colors.blueGrey)),
                  ],
                ),
              ),
              Tab(
                child: Column(
                  children: [
                    Image.asset("images/cucumbericon.png",width: 25.0,),
                    SizedBox(height: 5.0,),
                    Text('Marrow',style: TextStyle( color: _tabController.index == 2
                        ?  Color( widget.colorVal)
                        : Colors.blueGrey)),
                  ],
                ),
              ),
              Tab(
                child: Column(
                  children: [
                    Image.asset("images/onionicon.png",width: 25.0,),
                    SizedBox(height: 5.0,),
                    Text('Stem',style: TextStyle( color: _tabController.index == 3
                        ?  Color( widget.colorVal)
                        : Colors.blueGrey)),
                  ],
                ),
              ),
              Tab(
                child: Column(
                  children: [
                    Image.asset("images/leafygreenicon.png",width: 25.0,),
                    SizedBox(height: 5.0,),
                    Text('Edible',style: TextStyle( color: _tabController.index == 4
                        ?  Color( widget.colorVal)
                        : Colors.blueGrey)),
                  ],
                ),
              ),
              Tab(
                child: Column(
                  children: [
                    Image.asset("images/cabbageicon.png",width: 25.0,),
                    SizedBox(height: 5.0,),
                    Text('Cruciferous',style: TextStyle( color: _tabController.index == 5
                        ?  Color( widget.colorVal)
                        : Colors.blueGrey)),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Data("Leafy Green",widget.restaurant,context,user,app),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Data("Root",widget.restaurant,context,user,app),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Data("Marrow",widget.restaurant,context,user,app),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Data("Stem",widget.restaurant,context,user,app),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Data("Edible",widget.restaurant,context,user,app),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Data("Cruciferous",widget.restaurant,context,user,app),
            ),
          ],
        ),
      ),
    );
  }

  Widget Data(String s, String restaurant,BuildContext context,UserProvider user,AppProvider app) {
    final productProvider = Provider.of<ProductProvider>(context);
    List<ProductModel> promodel=[];
    switch(s)
    {
      case "Leafy Green":
        promodel=productProvider.productsLeafy;
        break;
      case "Root":
        promodel=productProvider.productsroot;
        break;
      case "Marrow":
        promodel=productProvider.productsmarrow;
        break;
      case "Stem":
        promodel=productProvider.productsstem;
        break;
      case "Edible":
        promodel=productProvider.productsedible;
        break;
      case "Cruciferous":
        promodel=productProvider.productscruciferous;

        break;
    }
    return promodel.length == 0
        ? Text("No Data")
        : Column(
      children: productProvider.productsByRestaurant
          .map((item) =>
          GestureDetector(
            onTap: () {
              dialog(context,item,user,app);
            },
            child: ProductWidget(
              product: item,
              keys:widget.keys,
            ),
          ))
          .toList(),
    );
  }

  Widget dialog(BuildContext context,ProductModel productModel,UserProvider user,AppProvider app )
  {
    showDialog(context: context,builder: (BuildContext context){
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Consts.padding),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: Consts.avatarRadius + Consts.padding,
                bottom: Consts.padding,
                left: Consts.padding,
                right: Consts.padding,
              ),
              margin: EdgeInsets.only(top: Consts.avatarRadius),
              decoration: new BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(Consts.padding),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: const Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,// To make the card compact
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Text(productModel.name,
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 10.0),
                  Text("\$${productModel.price}",
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 20.0,
                          color: Colors.grey)),
                  SizedBox(height: 10.0),
                  CustomText(
                      text: "Description", size: 18, weight: FontWeight.w400),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                     productModel.description,
                      textAlign: TextAlign.center,
                      style:
                      TextStyle(color: Colors.grey, fontWeight: FontWeight.w300),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                        height: 150.0,
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
                ],
              ),
            ),
            Positioned(
              left: Consts.padding,
              right: Consts.padding,
              child: Hero(
                tag: productModel.image,
                child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(productModel.image),
                            )),
                    height: 180.0,
                    width: 200.0),
              ),
            ),
          ],
        ),
      );
    }
    );
  }
  _buildInfoCard(String cardTitle, String info, String unit)
  {
    return InkWell(
        onTap: () {
          selectCard(cardTitle);
        },
        child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: cardTitle == selectedCard ? Colors.green : Colors.white,
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

  void selectCard(cardTitle)
  {
    setState(() {
      selectedCard = cardTitle;
    });
  }
}
class Consts {
Consts._();

static const double padding = 16.0;
static const double avatarRadius = 66.0;
}