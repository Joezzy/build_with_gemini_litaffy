class BaseEndpoints {
  BaseEndpoints._();
  // static const int receiveTimeout = 90000;
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration connectionTimeout = Duration(seconds: 50);
  static const String initializePayStackUrl =
      "https://api.paystack.co/transaction/initialize";
  static String verifyPayStackUrl(reference) {
    return "https://api.paystack.co/transaction/verify/$reference";
  }

  // static const String clauseUrl = "https://skippa-service.onrender.com/v1";
}
