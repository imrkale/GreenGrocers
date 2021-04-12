import 'package:flutter/material.dart';
import 'package:greengrocers/GroceryMenuUI/model/food.dart';
import 'package:greengrocers/userside/models/products.dart';

class FoodImage extends StatelessWidget {
  FoodImage({this.food});
  final ProductModel food;

  @override
  Widget build(BuildContext context) {
    return new Align(
      alignment: FractionalOffset.topCenter,
      child:  new GestureDetector(
        behavior: HitTestBehavior.opaque,
//        onTap: () =>
//            Routes.navigateTo(
//              context,
//              '/detail/${food.id}',
//            ),
        child: new Hero(
          tag: 'icon-${food.id}',
          child: new Image(
            image: new AssetImage(food.image),
            height: 150.0,
            width: 150.0,
          ),
        ),
      ),
    );
  }
}