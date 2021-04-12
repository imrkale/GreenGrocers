class PaymentCard{
  static const CARDNUMBER = "cardNumber";
  static const CARDHOLDERNAME = "cardHolderName";
  static const CVVCODE="cvvCode";
  static const EXPIRYDATE="expiryDate";
  static const SHOWBACKVIEW="showBackView";

  String _cardNumber;
  String _cardHolderName;
  String _cvvCode;
  String _expiryDate;
  bool _showBackView;
  //  getters
  String get cardNumber => _cardNumber;

  String get cardHolderName => _cardHolderName;

  String get cvvCode => _cvvCode;

  String get expiryDate => _expiryDate;

  bool get showBackView => _showBackView;

  PaymentCard.fromMap(Map data) {
    _cardNumber=data[CARDNUMBER];
    _cardHolderName=data[CARDHOLDERNAME];
    _cvvCode=data[CVVCODE];
    _expiryDate=data[EXPIRYDATE];
    _showBackView=data[SHOWBACKVIEW];
  }

  Map toMap() => {
    CARDNUMBER:_cardNumber,
    CARDHOLDERNAME: _cardHolderName,
    CVVCODE: _cvvCode,
    EXPIRYDATE: _expiryDate,
    SHOWBACKVIEW: _showBackView
  };

}