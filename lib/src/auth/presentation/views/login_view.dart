import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:littafy/custom/btn.dart';
import 'package:littafy/custom/txt.dart';
import 'package:littafy/src/auth/presentation/controller/login_view_controller.dart';
import 'package:littafy/src/auth/presentation/views/forgot_password_view.dart';
import 'package:littafy/src/auth/presentation/views/register_view.dart';
import 'package:littafy/utils/app_theme.dart';
import 'package:littafy/utils/size_config.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final loginController = Get.put(LoginViewController());

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      // backgroundColor: AppTheme.white,
      body: Padding(
        padding: EdgeInsets.all(MySize.size10),
        child: Stack(
          children: [
            Obx(() => loginForm()),
            Positioned(
                left: MySize.size30,
                top: MySize.size100,
                child: FadeInRight(
                  delay: const Duration(milliseconds: 50),
                  child: Text(
                    tr("login_to_your_account"),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MySize.size30,
                      // color: AppTheme.white
                    ),
                  ),
                )),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: MySize.size100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(tr("dont_have_account"),
                style: TextStyle(
                  fontSize: MySize.size15,
                  // color: Colors.grey
                )),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterView()));

                  // Navigator.of(context).pushNamedAndRemoveUntil(
                  //     AppRoute.register, (Route<dynamic> route) => false);
                },
                child: Text(
                  tr("sign_up"),
                  style: TextStyle(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: MySize.size15,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView loginForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        top: MySize.size250,
        left: MySize.size20,
        right: MySize.size20,
      ),
      // margin: EdgeInsets.only(top: MySize.size250),
      physics: const NeverScrollableScrollPhysics(),
      child: Form(
        key: loginController.loginFormKey,
        child: Column(
          children: [
            FadeInLeft(
              delay: const Duration(milliseconds: 50),
              child: Txt(
                hintText: tr("email"),
                controller: loginController.emailController,
                validator: loginController.validator.emailValidator,
                denySpaces: true,
              ),
            ),
            SizedBox(
              height: MySize.size10,
            ),
            Obx(() {
              return FadeInLeft(
                delay: const Duration(milliseconds: 50),
                child: Txt(
                  hintText: tr("password"),
                  controller: loginController.passwordController,
                  validator: loginController.validator.passwordValidator,
                  isPasswordField: loginController.showPassword.value,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 24.0),
                    child: Icon(
                      loginController.showPassword.value
                          ? MdiIcons.eyeOutline
                          : MdiIcons.eyeOffOutline,
                      color: AppTheme.black.withOpacity(.5),
                    ),
                  ),
                  onSuffixItemTapped: () {
                    if (!loginController.showPassword.value) {
                      loginController.showPassword.value = true;
                    } else {
                      loginController.showPassword.value = false;
                    }
                  },
                ),
              );
            }),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPasswordView()));
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MySize.size5, horizontal: MySize.size15),
                    child: Text(
                      tr("forgot_password"),
                      style: TextStyle(fontSize: MySize.size13),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            FadeInLeft(
              delay: const Duration(milliseconds: 80),
              child: FillButton(
                  text: tr("log_in"),
                  enabled: loginController.isLoading.value ? false : true,
                  onPressed: () {
                    loginController.login(context);
                  }),
            ),
            SizedBox(
              height: MySize.size25,
            ),
            // Row(children: <Widget>[
            //   Expanded(
            //       child: Divider(
            //     thickness: 1,
            //     color: Colors.black.withOpacity(0.5),
            //   )),
            //   Padding(
            //     padding: EdgeInsets.symmetric(horizontal: MySize.size8),
            //     child: Text(
            //       tr("or"),
            //       style: TextStyle(fontSize: MySize.size15),
            //     ),
            //   ),
            //   Expanded(
            //       child: Divider(
            //     thickness: 1,
            //     color: Colors.black.withOpacity(0.5),
            //   )),
            // ]),
            // SizedBox(
            //   height: MySize.size5,
            // ),
            // GestureDetector(
            //   onTap: () {
            //     loginController.googleLogin(context);
            //     // Dialogs.welcomeAlert( context,"Welcome ${currentUser!.lastName}","");
            //   },
            //   child: Container(
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(20),
            //       border: Border.all(width: 1, color: AppTheme.primaryColor),
            //       // color: loginController.isLoadingGoogle.value
            //       //     ? AppTheme.grey
            //       //     : AppTheme.white
            //     ),
            //     padding: EdgeInsets.all(MySize.size8),
            //     margin: EdgeInsets.symmetric(vertical: MySize.size20),
            //     child: loginController.isLoadingGoogle.value
            //         ? const CupertinoActivityIndicator(color: AppTheme.black)
            //         : Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //             children: [
            //               Image.asset(
            //                 "${assetImage}google.png",
            //                 height: MySize.size30,
            //               ),
            //               Text(
            //                 tr('login_with_google'),
            //                 style: TextStyle(
            //                   fontSize: MySize.size20,
            //                 ),
            //               )
            //             ],
            //           ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
