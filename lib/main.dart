import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:littafy/firebase_options.dart';
// https://www.cbc.ca/radio/undertheinfluence/that-time-3-million-was-left-at-a-vancouver-bus-stop-1.7129454
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:littafy/di/appModule.dart';
import 'package:littafy/firebase_options.dart';
import 'package:littafy/splash_screen.dart';
import 'package:littafy/src/settings/controller/settings_controller.dart';
import 'package:littafy/utils/size_config.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  final engine = WidgetsFlutterBinding.ensureInitialized();
  engine.performReassemble();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await EasyLocalization.ensureInitialized();
  await initializeDI();
  await dotenv.load(fileName: ".env");

  // initializeDateFormatting().then((_) =>
  //     runApp(const MyApp())
  // );
  // await dotenv.load(fileName: ".env");

  runApp(EasyLocalization(
    supportedLocales: const [
      Locale('en', 'US'),
      Locale('fr', 'FR'),
      Locale('ig', 'NG'),
      Locale('yo', 'NG'),
      Locale('ha', 'NG'),
    ],
    path: 'assets/translations', // <-- change the path of the translation files
    fallbackLocale: const Locale('en', 'US'),
    startLocale: const Locale('en', 'US'),
    saveLocale: true,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    // context.setLocale(const Locale('en', 'US'));
    final settingsController = Get.put(SettingsController());
    // context.setLocale(const Locale('fr', 'FR'));

    return GetX<SettingsController>(builder: (settingsController) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: "Littafy",
        theme: ThemeData(
          brightness: settingsController.isDarkMode.value
              ? Brightness.dark
              : Brightness.light,
          // primaryColor: primarySwatch,
          useMaterial3: true,
          // fontFamily: 'EduNSWACTFoundation'
        ),
        home: SplashScreen(),
      );
    });
  }
}
