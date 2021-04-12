class CartItemModel {
  static const ID = "id";
  static const NAME = "name";
  static const IMAGE = "image";
  static const PRODUCT_ID = "productId";
  static const QUANTITY = "quantity";
  static const PRICE = "price";
  static const RESTAURANT_ID = "restaurantId";
  static const TOTAL_RESTAURANT_SALES = "totalRestaurantSale";
  static const AREA_NAME = "areaname";
  static const RESTAURANT = "restaurant";

  String _id;
  List _areaname;
  String _restaurant;
  String _name;
  String _image;
  String _productId;
  String _restaurantId;
  int _totalRestaurantSale;
  int _quantity;
  int _price;

  //  getters
  String get id => _id;

  String get restaurant => _restaurant;

  List get areaname => _areaname;

  String get name => _name;

  String get image => _image;

  String get productId => _productId;

  String get restaurantId => _restaurantId;

  int get price => _price;

  int get totalRestaurantSale => _totalRestaurantSale;

  int get quantity => _quantity;

  CartItemModel.fromMap(Map data) {
    _id = data[ID];
    _name = data[NAME];
    _image = data[IMAGE];
    _productId = data[PRODUCT_ID];
    _price = data[PRICE];
    _quantity = data[QUANTITY];
    _totalRestaurantSale = data[TOTAL_RESTAURANT_SALES];
    _restaurantId = data[RESTAURANT_ID];
    _areaname = data[AREA_NAME];
    _restaurant = data[RESTAURANT];
  }

  Map toMap() => {
        ID: _id,
        IMAGE: _image,
        NAME: _name,
        PRODUCT_ID: _productId,
        QUANTITY: _quantity,
        PRICE: _price,
        AREA_NAME: _areaname,
        RESTAURANT: _restaurant,
        RESTAURANT_ID: _restaurantId,
        TOTAL_RESTAURANT_SALES: _totalRestaurantSale
      };
}
