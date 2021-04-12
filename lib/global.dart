import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
Color darkBlueColor = Color(0xFF283A62);
Color lightBlueColor = Color(0xFF71B9EB);
Color lighterBlueColor = Color(0xFF71B9EB).withOpacity(0.5);
Color lightGreen = Color(0xFF95E08E);
Color lightBlueIsh = Color(0xFF33BBB5);
Color darkGreen = Color(0xFF00AA12);
Color backgroundColor = Color(0xFFEFEEF5);
final Color kPrimaryColor = HexColor('#53B175');
final Color kShadowColor = HexColor('#A8A8A8');
const kBackgroundColor = Color(0xFFF8F8F8);
const kActiveIconColor = Color(0xFFE68342);
const kTextColor = Color(0xFF222B45);
const kBlueLightColor = Color(0xFFC7B8F5);
const kBlueColor = Color(0xFF817DC0);
final Color kBlackColor = HexColor('#181725');
final Color kSubtitleColor = HexColor('#7C7C7C');
final Color kSecondaryColor = HexColor('#F2F3F2');
final Color kBorderColor = HexColor('#E2E2E2');

final TextStyle kTitleStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: kBlackColor,
);

final TextStyle kDescriptionStyle = TextStyle(
    color: kSubtitleColor,
    fontSize: 13,
);


TextStyle pageTitleStyle = new TextStyle(
    fontFamily: 'Helvetica',
    fontWeight: FontWeight.bold,
    fontSize: 50,
    color: darkBlueColor);

TextStyle tabTitleStyle = new TextStyle(
    fontFamily: 'Helvetica',
    fontWeight: FontWeight.bold,
    fontSize: 30,
    color: Colors.white);

TextStyle blogTitleStyle =
    new TextStyle(fontFamily: 'Avenir', fontSize: 20, color: Colors.white);

TextStyle blogDateStyle = new TextStyle(
    fontFamily: 'Avenir', fontSize: 12, color: Colors.white.withOpacity(0.5));

TextStyle smallButtonTextStyle = new TextStyle(
    fontFamily: 'Avenir',
    fontWeight: FontWeight.bold,
    fontSize: 12,
    color: darkBlueColor);


TextStyle titleStyleWhite = new TextStyle(
    fontFamily: 'Helvetica',
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 25);
TextStyle jobCardTitileStyleBlue = new TextStyle(
    fontFamily: 'Avenir',
    color: lightBlueIsh,
    fontWeight: FontWeight.bold,
    fontSize: 12);
TextStyle jobCardTitileStyleBlack = new TextStyle(
    fontFamily: 'Avenir',
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 12);
TextStyle titileStyleLighterBlack = new TextStyle(
    fontFamily: 'Avenir',
    color: Color(0xFF34475D),
    fontWeight: FontWeight.bold,
    fontSize: 20);

TextStyle titileStyleBlack = new TextStyle(
    fontFamily: 'Helvetica',
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 20);
TextStyle salaryStyle = new TextStyle(
    fontFamily: 'Avenir',
    color: darkGreen,
    fontWeight: FontWeight.bold,
    fontSize: 12);
