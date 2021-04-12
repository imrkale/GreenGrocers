import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantModel {
  static const ID = "id";
  static const NAME = "name";
  static const AVG_PRICE = "avgPrice";
  static const RATING = "rating";
  static const RATES = "rates";
  static const IMAGE = "image";
  static const POPULAR = "popular";
  static const USER_LIKES = "userLikes";
  static const AREA_NAME = "areaname";
  static const CONTACT = "contact";

  String _id;
  String _contact;
  String _name;
  List _areaname;
  String _image;
  List<String> _userLikes;
  double _rating;
  double _avgPrice;
  bool _popular;
  int _rates;

//  getters
  String get id => _id;

  String get contact => _contact;

  String get name => _name;

  String get image => _image;

  List<String> get userLikes => _userLikes;

  List get areaname => _areaname;

  double get avgPrice => _avgPrice;

  double get rating => _rating;

  bool get popular => _popular;

  int get rates => _rates;

  // public variable
  bool liked = false;

  RestaurantModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.get(ID);
    _name = snapshot.get(NAME);
    _image = snapshot.get(IMAGE);
    _avgPrice = snapshot.get(AVG_PRICE);
    _rating = snapshot.get(RATING);
    _popular = snapshot.get(POPULAR);
    _rates = snapshot.get(RATES);
    _areaname = snapshot.get(AREA_NAME);
    _contact = snapshot.get(CONTACT);
  }
}
