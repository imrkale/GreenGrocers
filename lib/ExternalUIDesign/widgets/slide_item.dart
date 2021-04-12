import 'package:flutter/material.dart';
import 'package:greengrocers/ExternalUIDesign/util/const.dart';
import 'package:greengrocers/userside/helpers/style.dart';
import 'package:greengrocers/userside/models/restaurant.dart';
import 'package:greengrocers/userside/widgets/loading.dart';
import 'package:greengrocers/global.dart';
import 'package:transparent_image/transparent_image.dart';


class SlideItem extends StatelessWidget {
  final RestaurantModel restaurantModel;

  const SlideItem({
    Key key,
    @required this.restaurantModel,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width/1.2 ,
        child: Card(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 3.0,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 3.7,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(height: 120, child: Loading()),
                              )),
                              restaurantModel.image.isNotEmpty ? FadeInImage.memoryNetwork(

                                  placeholder: kTransparentImage,
                                  image: restaurantModel.image,fit: BoxFit.cover,):
                                  FadeInImage.memoryNetwork(
                                   placeholder: kTransparentImage,
                                  image: "images/table.png",fit: BoxFit.fill,),
                        ],

                      ),
                    ),
                  ),
                  Positioned(
                    top: 6.0,
                    right: 6.0,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: Constants.ratingBG,
                              size: 10,
                            ),
                            Text(
                              " ${restaurantModel.rating} ",
                              style: TextStyle(
                                fontSize: 10.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 6.0,
                    left: 6.0,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.0)),
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          " OPEN ",
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 7.0),

              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.store,color: darkGreen,),
                      SizedBox(width: 10.0,),
                      Text(
                        "${restaurantModel.name}",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.0,bottom: 10.0),
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width/2.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.location_on_outlined,color: Colors.blue,),
                          SizedBox(width: 5.0,),
                          Text(
                            "Detect Location",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              Padding(
                padding: EdgeInsets.only(left:10.0,right: 10.0,bottom: 10.0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.local_phone,color: Colors.blue,),
                      SizedBox(width: 5.0,),
                      Text(
                        "${restaurantModel.contact}",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
                ],
    ),
            ],
          ),
        ),
      ),
    );
  }
}