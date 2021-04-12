import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
          options: CarouselOptions(
            height: 180.0,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 10 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            scrollDirection: Axis.horizontal,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            viewportFraction: 0.8,
          ),

          items: [
            Container(
              margin: EdgeInsets.only(top: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: AssetImage('images/Grocery-PNG-Pic.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Usable Flower for Health', style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,),),
                  Padding(


                    padding: const EdgeInsets.all(15.0),


                    child: Text(


                      'Lorem Ipsum is simply dummy text use for printing and type script',


                      style: TextStyle(


                        color: Colors.white,


                        fontSize: 15.0,


                      ),


                      textAlign: TextAlign.center,


                    ),


                  ),


                ],


              ),


            ),



            Container(


              margin: EdgeInsets.only(top: 5.0),


              decoration: BoxDecoration(


                borderRadius: BorderRadius.circular(10.0),


                image: DecorationImage(


                  image: AssetImage('images/tomo.jpg'),


                  fit: BoxFit.cover,


                ),


              ),


              child: Column(


                mainAxisAlignment: MainAxisAlignment.center,


                crossAxisAlignment: CrossAxisAlignment.center,


                children: <Widget>[


                  Text(


                    'Usable Flower for Health',


                    style: TextStyle(


                      color: Colors.white,


                      fontWeight: FontWeight.bold,


                      fontSize: 18.0,


                    ),


                  ),



                  Padding(


                    padding: const EdgeInsets.all(15.0),


                    child: Text(


                      'Lorem Ipsum is simply dummy text use for printing and type script',


                      style: TextStyle(


                        color: Colors.white,


                        fontSize: 15.0,


                      ),


                      textAlign: TextAlign.center,


                    ),


                  ),


                ],


              ),


            ),



            Container(


              margin: EdgeInsets.only(top: 5.0),


              decoration: BoxDecoration(


                borderRadius: BorderRadius.circular(10.0),


                image: DecorationImage(


                  image: AssetImage('images/menu4.png'),


                  fit: BoxFit.cover,


                ),


              ),


              child: Column(


                mainAxisAlignment: MainAxisAlignment.center,


                crossAxisAlignment: CrossAxisAlignment.center,


                children: <Widget>[


                  Text(


                    'Usable Flower for Health',


                    style: TextStyle(


                      color: Colors.white,


                      fontWeight: FontWeight.bold,


                      fontSize: 18.0,


                    ),


                  ),



                  Padding(


                    padding: const EdgeInsets.all(15.0),


                    child: Text(


                      'Lorem Ipsum is simply dummy text use for printing and type script',


                      style: TextStyle(


                        color: Colors.white,


                        fontSize: 15.0,


                      ),


                      textAlign: TextAlign.center,


                    ),


                  ),


                ],


              ),


            ),


          ],


        );





  }


}