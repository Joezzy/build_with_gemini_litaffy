import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:littafy/src/auth/presentation/controller/login_view_controller.dart';
import 'package:littafy/utils/app_theme.dart';
import 'package:littafy/utils/size_config.dart';

class SplashScreen extends StatefulWidget {
  static const String id = "splash";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final loginController = Get.put(LoginViewController());
  @override
  initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () => moveOn());
  }

  int initScreen = 1;

  moveOn() async {
    // SharedPreferences crypt = await SharedPreferences.getInstance();
    //
    // String? access  =  crypt.getString("access");
    //

    loginController.autoLogin(context);
    // if(mounted) {
    //   Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(builder: (BuildContext context) => OnBoardingScreen()),
    //         (Route<dynamic> route) => false);
    // }
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: AppTheme.primaryColor,
            bottomNavigationBar: SizedBox(
              height: MySize.size50,
              child: Column(
                children: [
                  Text(
                    "Powered by NEXNGIN",
                    style: TextStyle(
                        fontSize: MySize.size12, color: AppTheme.white),
                  ),
                ],
              ),
            ),
            body: GestureDetector(
              onTap: () {},
              child: Stack(children: <Widget>[
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/littafy.png',
                        width: MySize.size200,
                        height: MySize.size200,
                        fit: BoxFit.contain,
                        // color: AppTheme.pr,
                      ),
                      Text(
                        "Littafy",
                        style: TextStyle(
                            fontSize: MySize.size30,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.white),
                      )
                    ],
                  ),
                )
              ]),
            )));
  }
}
