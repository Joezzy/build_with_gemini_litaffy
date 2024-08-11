class AuthUrls {
  AuthUrls._();
  static const int receiveTimeout = 50000;
  static const int connectionTimeout = 50000;
  // static const String base = constBaseUrl;
  static const String loginUrl = "/auth/customer/login";
  static String requestPasswordResetUrl = '/auth/password/reset';
  static String resetPasswordUrl = '/auth/token/:token/password/reset';
  static String changePasswordUrl = '/auth/user/me/password/change';

  static const String registerUrl = "/customers/account/create";
  static const String requestOtpUrl = "/customers/account/otp";
  static const String customerUrl = "/v1/customers";

  static String customerByIdUrl(customerId) {
    return '/customers/$customerId';
  }

  static String completeSetUpUrl(accountCreationToken) {
    return '/customers/account/$accountCreationToken/complete';
  }
}
