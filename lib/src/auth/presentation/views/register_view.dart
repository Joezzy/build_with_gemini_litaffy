import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:littafy/constant/constants.dart';
import 'package:littafy/custom/btn.dart';
import 'package:littafy/custom/txt.dart';
import 'package:littafy/src/auth/presentation/controller/register_view_controller.dart';
import 'package:littafy/utils/app_theme.dart';
import 'package:littafy/utils/size_config.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final registerController = Get.put(RegisterViewController());
  String? country;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    registerController.initStateItem();
    registerController.clearText();
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(MySize.size10),
        child: Stack(
          children: [
            Obx(() => signUpForm()),
            Positioned(
                left: MySize.size30,
                top: MySize.size70,
                child: FadeInRight(
                  delay: const Duration(milliseconds: 50),
                  child: Text(
                    "join",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MySize.size30,
                      // color: AppTheme.white
                    ),
                  ).tr(args: ['Litaffy']),
                )),
          ],
        ),
      ),
    ));
  }

  Container signUpForm() {
    return Container(
      padding: EdgeInsets.only(
        top: MySize.size200,
        left: MySize.size20,
        right: MySize.size20,
      ),

      // margin: EdgeInsets.only(top: MySize.size250),
      // physics: const NeverScrollableScrollPhysics(),
      child: Form(
        key: registerController.registerFormKey,
        child: Column(
          children: [
            FadeInLeft(
              delay: const Duration(milliseconds: 50),
              child: Column(
                children: [
                  Txt(
                    hintText: tr('first_name'),
                    controller: registerController.firstnameController,
                    validator: registerController.validator.requiredValidator,
                    // textStyle:const  TextStyle(fontSize: 14),
                    // contentPadding: EdgeInsets.symmetric(vertical: 0),
                    onChanged: (val) => registerController
                        .registerFormKey.currentState!.widget.onChanged,
                  ),
                  Txt(
                    hintText: tr('last_name'),
                    controller: registerController.lastNameController,
                    validator: registerController.validator.requiredValidator,
                  ),
                  Txt(
                    hintText: tr('email'),
                    controller: registerController.emailController,
                    validator: registerController.validator.emailValidator,
                    denySpaces: true,
                  ),
                  Obx(() {
                    return Txt(
                      hintText: tr('password'),
                      controller: registerController.passwordController,
                      validator: registerController.validator.passwordValidator,
                      isPasswordField: registerController.showPassword.value,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 24.0),
                        child: Icon(
                          registerController.showPassword.value
                              ? MdiIcons.eyeOutline
                              : MdiIcons.eyeOffOutline,
                          color: AppTheme.black.withOpacity(.5),
                        ),
                      ),
                      onSuffixItemTapped: () {
                        if (!registerController.showPassword.value) {
                          registerController.showPassword.value = true;
                        } else {
                          registerController.showPassword.value = false;
                        }
                      },
                    );
                  }),
                  Obx(() {
                    return Txt(
                      hintText: tr('confirm_password'),
                      controller: registerController.passwordController2,
                      validator: registerController.validator.passwordValidator,
                      isPasswordField: registerController.showPassword.value,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 24.0),
                        child: Icon(
                          registerController.showPassword.value
                              ? MdiIcons.eyeOutline
                              : MdiIcons.eyeOffOutline,
                          color: AppTheme.black.withOpacity(.5),
                        ),
                      ),
                      onSuffixItemTapped: () {
                        if (!registerController.showPassword.value) {
                          registerController.showPassword.value = true;
                        } else {
                          registerController.showPassword.value = false;
                        }
                      },
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            FadeInRight(
              delay: const Duration(milliseconds: 100),
              child: FillButton(
                text: tr("sign_up"),
                enabled: registerController.isLoading.value ? false : true,
                onPressed: () {
                  registerController.registerMethod(context);
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(
                bottom: MySize.size10,
              ),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'By clicking sign up you agree to all our',
                      style: TextStyle(
                          color: AppTheme.black,
                          fontSize: MySize.size14,
                          fontFamily: 'Raleway'),
                    ),
                    TextSpan(
                      text: ' terms & condition',
                      style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontSize: MySize.size14,
                          fontFamily: 'Raleway',
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // launchUrl(Uri.parse(terms_and_condition),mode: LaunchMode.externalApplication);
                        },
                    ),
                    TextSpan(
                      text: ' and ',
                      style: TextStyle(
                          color: AppTheme.black,
                          fontSize: MySize.size14,
                          fontFamily: 'Raleway'),
                    ),
                    TextSpan(
                      text: 'Privacy policy ',
                      style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontSize: MySize.size14,
                          fontFamily: 'Raleway',
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // launchUrl(Uri.parse(privacy_policy),mode: LaunchMode.externalApplication);
                        },
                    ),
                  ],
                ),
              ),
            ),
            Row(children: <Widget>[
              const Expanded(child: Divider()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: const Text("or_sign_up_with").tr(),
              ),
              const Expanded(child: Divider()),
            ]),
            GestureDetector(
              onTap: () {
                registerController.googleRegisterMethod(context);
                // Dialogs.welcomeAlert( context,"Welcome ${currentUser!.lastName}","");
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1, color: AppTheme.primaryColor),
                  // color: loginController.isLoadingGoogle.value
                  //     ? AppTheme.grey
                  //     : AppTheme.white
                ),
                padding: EdgeInsets.all(MySize.size8),
                margin: EdgeInsets.symmetric(vertical: MySize.size20),
                child: registerController.isLoadingGoogle.value
                    ? const CupertinoActivityIndicator(color: AppTheme.black)
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            "${assetImage}google.png",
                            height: MySize.size30,
                          ),
                          Text(
                            tr("login_with_google"),
                            style: TextStyle(
                              fontSize: MySize.size20,
                            ),
                          )
                        ],
                      ),
              ),
            ),
            SizedBox(
              height: MySize.size10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?  ",
                    style: TextStyle(
                      fontSize: MySize.size14,
                      // color: Colors.grey
                    )),
                GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);
                      // Get.toNamed(AppRoute.registerToLogin);
                      // Navigator.of(context).pushNamedAndRemoveUntil(
                      //     AppRoute.login, (Route<dynamic> route) => false);
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: MySize.size16,
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: MySize.size50,
            )
          ],
        ),
      ),
    );
  }
}
