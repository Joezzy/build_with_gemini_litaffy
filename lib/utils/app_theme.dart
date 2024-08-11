import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:littafy/utils/size_config.dart';

enum Screen { phone, tab, win }

const Map<int, Color> color = {
  900: Color.fromRGBO(0, 128, 254, 1.0),
  50: Color.fromRGBO(0, 128, 254, 0.1),
  100: Color.fromRGBO(0, 128, 254, 0.2),
  200: Color.fromRGBO(0, 128, 254, 0.3),
  300: Color.fromRGBO(0, 128, 254, 0.4),
  400: Color.fromRGBO(0, 128, 254, 0.5),
  500: Color.fromRGBO(0, 128, 254, 0.6),
  600: Color.fromRGBO(0, 128, 254, 0.7),
  700: Color.fromRGBO(0, 128, 254, 0.8),
  800: Color.fromRGBO(0, 128, 254, 0.9),
};

MaterialColor primarySwatch = const MaterialColor(0xFF880E4F, color);

class AppTheme {
  static const Color primaryColor = Color(0xFF0080fe);
  // static const Color primaryColor = Color.fromRGBO(0, 128, 254, 1);
  static const Color black = Color(0xFF263238);
  static const Color patchBlue = Color(0xFF000075);
  // static const Color grey = Color(0xFFEBEBEB);
  static const Color grey = Color.fromRGBO(47, 45, 81, 0.3);

  static const Color pageBackground = Color(0xFF263238);
  static const Color bottomNavColor = Color(0xFF263238);
  static const Color secondary = Color(0xFFD9D9D9);
  static const Color lightGrey = Color(0xFFEFECEC);
  static const Color white = Color(0xFFFFFFFF);
  static const Color unSelected = Color(0xFFC7C7C7);
  static const Color iconBack = Color(0xFFF8F8F8);
  static const Color lightBlack = Color(0xFF393939);
  static const Color orderTrackColor = Color(0xFF888888);
  static const Color callColor = Color(0xFF5FDBA7);
  static const Color backColor = Color(0xFFF6F6F6);

  static TextStyle get bigTitle =>
      TextStyle(fontSize: MySize.size20, fontWeight: FontWeight.bold);
  static TextStyle get title1 =>
      TextStyle(fontSize: MySize.size15, fontWeight: FontWeight.bold);
  static TextStyle get title2 => TextStyle(
      fontSize: MySize.size14,
      fontWeight: FontWeight.bold,
      color: AppTheme.white);
  static TextStyle get title3 =>
      TextStyle(fontSize: MySize.size30, fontWeight: FontWeight.bold);
  static TextStyle get title4 => TextStyle(
      fontSize: MySize.size30,
      fontWeight: FontWeight.bold,
      color: primaryColor);
  static TextStyle get title5 => TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: MySize.size12,
      color: AppTheme.black);
  static TextStyle get title12White => TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: MySize.size12,
      color: AppTheme.white);

  static TextStyle get subtitle2 => const TextStyle(
        color: Color(0xFF616161),
        fontWeight: FontWeight.normal,
        fontSize: 16,
      );

  static TextStyle get bodyText2 => const TextStyle(
        color: AppTheme.black,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );

  static TextStyle get bodyText3 => const TextStyle(
        color: AppTheme.black,
        fontWeight: FontWeight.normal,
        fontSize: 12,
      );

  static TextStyle get subStyle =>
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 14);

  static TextStyle buttonWhiteTextStyle(
      {Color color = AppTheme.black,
      double fontSize = 14,
      FontWeight fontWeight = FontWeight.normal,
      double lineHeight = 1.35}) {
    return TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
        height: lineHeight);
  }

  static Color darken(Color color, {double amount = .08}) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    HSLColor hslDark =
        hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  static Color lighten(Color color, {double amount = .08}) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }

  static String money(double amount, {int digits = 2}) {
    var amt = NumberFormat.currency(
            symbol: '', locale: 'en-UK', decimalDigits: digits)
        .format(amount);
    return "\u20A6 $amt";
    // return "N$amt";
  }

  String maskNumber(String amt, {int digits = 0}) {
    double amount = double.parse(amt.toString());
    return NumberFormat.currency(
            symbol: '', locale: 'en-UK', decimalDigits: digits)
        .format(amount);
  }

  // currencyCode

  static double readMoney(String text, {int digits = 0}) {
    return NumberFormat.currency(
            symbol: '₦', locale: 'en-UK', decimalDigits: digits)
        .parse(text)
        .toDouble();
  }

  static String formatDate(DateTime date) {
    return DateFormat("dd-MM-yyy").format(date);
  }

  static String formatTime(DateTime date) {
    return DateFormat("hh:mm a").format(date);
  }

  static Screen getScreen() {
    // MediaQueryData win =  MediaQueryData.fromView(WidgetsBinding.instance.window);
    MediaQueryData win = MediaQueryData.fromView(
        WidgetsBinding.instance.platformDispatcher.views.single);
    double size = win.size.shortestSide;
    Screen screen = Screen.phone;
    if (size <= 760) {
      screen = Screen.phone;
    } else if (size > 760 && size < 1200) {
      screen = Screen.tab;
    } else if (size >= 1201) {
      screen = Screen.win;
    }
    return screen;
  }
}

extension TextStyleHelper on TextStyle {
  TextStyle override(
          {Color? color,
          double? fontSize,
          FontWeight? fontWeight,
          FontStyle? fontStyle}) =>
      TextStyle(
        color: color ?? this.color,
        fontSize: fontSize ?? this.fontSize,
        fontWeight: fontWeight ?? this.fontWeight,
        fontStyle: fontStyle ?? this.fontStyle,
      );
}
