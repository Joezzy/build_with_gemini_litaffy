import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:littafy/constant/constants.dart';
import 'package:littafy/custom/btn.dart';
import 'package:littafy/src/auth/presentation/controller/login_view_controller.dart';
import 'package:littafy/src/auth/presentation/views/login_view.dart';
import 'package:littafy/src/auth/presentation/views/onBoardingScreens/frame1.dart';
import 'package:littafy/utils/app_theme.dart';
import 'package:littafy/utils/size_config.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final int totalPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final loginController = Get.put(LoginViewController());
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    // loginController.autoLogin(context);
  }

  bool showPassword = true;
  @override
  Widget build(BuildContext context) {
    MySize().init(context);

    return Scaffold(
      // backgroundColor: AppTheme.white,
      appBar: AppBar(
        // backgroundColor: AppTheme.whiteBackground,
        elevation: 0,
        iconTheme: IconThemeData(
          color: AppTheme.black,
        ),
        actions: [],
      ),

      body: Column(
        children: [
          SizedBox(
            height: MySize.size500,
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                _currentPage = page;
                setState(() {});
              },
              children: <Widget>[
                FrameOne(
                  image: ClipRRect(
                    borderRadius: BorderRadius.circular(MySize.size20),
                    child: Image.asset(
                      "${assetImage}ai_slide.png",
                      height: MySize.size300,
                      width: MySize.size300,
                    ),
                  ),
                  body: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: MySize.size20,
                      vertical: MySize.size50,
                    ),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Learn with ease with the power of ',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.color,
                                fontSize: MySize.size26,
                                fontFamily: 'Raleway'),
                          ),
                          TextSpan(
                            text: ' AI',
                            style: TextStyle(
                                color: AppTheme.primaryColor,
                                fontSize: MySize.size26,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Raleway'),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // canLaunchUrl(Uri.parse('https://docs.flutter.io/flutter/services/UrlLauncher-class.html'));
                              },
                          ),
                          TextSpan(
                            text: ' narrowed content',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.color,
                                fontSize: MySize.size26,
                                fontFamily: 'Raleway'),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Text("Move with Skippa today your gateway to logistics",
                  //  textAlign: TextAlign.center,
                  //  style: TextStyle(fontSize: MySize.size20),),
                ),
                FrameOne(
                  image: ClipRRect(
                    borderRadius: BorderRadius.circular(MySize.size20),
                    child: Image.asset(
                      "${assetImage}quiz_slide.png",
                      height: MySize.size300,
                      width: MySize.size300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  body: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: MySize.size20,
                      vertical: MySize.size50,
                    ),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Scan and get',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.color,
                                fontSize: MySize.size24,
                                fontFamily: 'Raleway'),
                          ),
                          TextSpan(
                            text: ' answer',
                            style: TextStyle(
                                color: AppTheme.primaryColor,
                                fontSize: MySize.size24,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Raleway'),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // canLaunchUrl(Uri.parse('https://docs.flutter.io/flutter/services/UrlLauncher-class.html'));
                              },
                          ),
                          TextSpan(
                            text: ' to your assignment/home in seconds',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.color,
                                fontSize: MySize.size24,
                                fontFamily: 'Raleway'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                FrameOne(
                  image: ClipRRect(
                    borderRadius: BorderRadius.circular(MySize.size20),
                    child: Image.asset(
                      "${assetImage}text_slide.png",
                      fit: BoxFit.cover,
                      height: MySize.size300,
                      width: MySize.size300,
                    ),
                  ),
                  body: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: MySize.size20,
                      vertical: MySize.size50,
                    ),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Get ',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.color,
                                fontSize: MySize.size24,
                                fontFamily: 'Raleway'),
                          ),
                          TextSpan(
                            text: ' Text',
                            style: TextStyle(
                                color: AppTheme.primaryColor,
                                fontSize: MySize.size24,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Raleway'),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // canLaunchUrl(Uri.parse('https://docs.flutter.io/flutter/services/UrlLauncher-class.html'));
                              },
                          ),
                          TextSpan(
                            text: ' from PDF, image, live camera & url',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.color,
                                fontSize: MySize.size24,
                                fontFamily: 'Raleway'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  OnBoardingProgress(
                    ticks: _currentPage,
                  ),
                  SizedBox(
                    height: MySize.size50,
                  ),
                  SizedBox(
                    height: MySize.size60,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: MySize.size40),
                    child: FillButton(
                      borderRadius: MySize.size40,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginView()));
                      },
                      text: "Get started",
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}

class OnBoardingProgress extends StatelessWidget {
  final int ticks;
  final bool alt;

  OnBoardingProgress({
    required this.ticks,
    this.alt = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        tick1(alt),
        const SizedBox(
          width: 10,
        ),
        tick2(alt),
        const SizedBox(
          width: 10,
        ),
        tick3(alt),
      ],
    );
  }

  Widget tick(bool isChecked, bool alt) {
    return isChecked
        ? Container(
            height: alt ? MySize.size10 : MySize.size15,
            width: alt ? MySize.size10 : MySize.size15,
            // padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
                color: alt ? AppTheme.primaryColor : AppTheme.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                    color: alt ? AppTheme.white : AppTheme.primaryColor,
                    width: 1)),
            child: Container(
              height: MySize.size10,
              width: MySize.size10,
              decoration: BoxDecoration(
                  color: alt ? AppTheme.white : AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                      color: alt ? AppTheme.white : AppTheme.primaryColor,
                      width: 1)),
            ),
          )
        : Container(
            height: alt ? MySize.size10 : MySize.size15,
            width: alt ? MySize.size10 : MySize.size15,
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
                color: alt ? AppTheme.primaryColor : AppTheme.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                    color: alt ? AppTheme.white : AppTheme.primaryColor,
                    width: 1)),
          );
  }

  Widget tick1(bool alt) {
    return this.ticks == 0 ? tick(true, alt) : tick(false, alt);
  }

  Widget tick2(bool alt) {
    return this.ticks == 1 ? tick(true, alt) : tick(false, alt);
  }

  Widget tick3(bool alt) {
    return this.ticks == 2 ? tick(true, alt) : tick(false, alt);
  }
}
