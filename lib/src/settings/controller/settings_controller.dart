import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  RxBool isDarkMode = false.obs;
  Rx<Locale> myLocale = const Locale('en', 'US').obs;

  setTheme(bool dark) {
    isDarkMode.value = dark;
  }

  setLanguage(context, String language) {
    List localeCode = language.split("-");
    print(localeCode);
    context.setLocale(Locale(localeCode[0], localeCode[1]));
    // MyApp(context).setLocale( Locale.fromSubtags(languageCode: localeCode[0]));

    myLocale.value = Locale(localeCode[0], localeCode[1]);
  }
}
