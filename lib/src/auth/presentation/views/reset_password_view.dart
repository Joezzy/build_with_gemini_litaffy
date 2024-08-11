import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:littafy/custom/btn.dart';
import 'package:littafy/custom/txt.dart';
import 'package:littafy/src/auth/presentation/controller/forgot_password_controller.dart';
import 'package:littafy/utils/app_theme.dart';
import 'package:littafy/utils/size_config.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final forgotPasswordController = Get.put(ForgotPasswordController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // forgotPasswordController.clearText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MySize.size30,
              ),
              child: Text(
                "Reset Password",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MySize.size30,
                    color: AppTheme.black),
              ),
            ),
            Obx(() => forgotForm()),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView forgotForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: MySize.size20,
        right: MySize.size20,
      ),
      // margin: EdgeInsets.only(top: MySize.size250),
      physics: const NeverScrollableScrollPhysics(),
      child: Form(
        key: forgotPasswordController.resetFormKey.value,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: MySize.size20, horizontal: 15),
              child: Text(
                "Enter the 6-digit OTP sent to  ${forgotPasswordController.emailController.value.text}",
                style: TextStyle(fontSize: MySize.size16),
                // textAlign: TextAlign.center,
              ),
            ),
            Txt(
              hintText: "OTP",
              controller: forgotPasswordController.code.value,
              validator: forgotPasswordController.validator.requiredValidator,
              denySpaces: true,
            ),
            Obx(() {
              return Txt(
                hintText: "Password",
                controller: forgotPasswordController.passwordController.value,
                validator: forgotPasswordController.validator.passwordValidator,
                isPasswordField: forgotPasswordController.showPassword.value,
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 24.0),
                  child: Icon(
                    forgotPasswordController.showPassword.value
                        ? MdiIcons.eyeOutline
                        : MdiIcons.eyeOffOutline,
                    color: AppTheme.black.withOpacity(.5),
                  ),
                ),
                onSuffixItemTapped: () {
                  if (!forgotPasswordController.showPassword.value) {
                    forgotPasswordController.showPassword.value = true;
                  } else {
                    forgotPasswordController.showPassword.value = false;
                  }
                },
              );
            }),
            Obx(() {
              return Txt(
                hintText: "Confirm Password",
                controller: forgotPasswordController.passwordController2.value,
                validator: forgotPasswordController.validator.passwordValidator,
                isPasswordField: forgotPasswordController.showPassword.value,
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 24.0),
                  child: Icon(
                    forgotPasswordController.showPassword.value
                        ? MdiIcons.eyeOutline
                        : MdiIcons.eyeOffOutline,
                    color: AppTheme.black.withOpacity(.5),
                  ),
                ),
                onSuffixItemTapped: () {
                  if (!forgotPasswordController.showPassword.value) {
                    forgotPasswordController.showPassword.value = true;
                  } else {
                    forgotPasswordController.showPassword.value = false;
                  }
                },
              );
            }),
            const SizedBox(
              height: 50,
            ),
            FillButton(
                text: "Reset Password",
                enabled:
                    forgotPasswordController.isLoading.value ? false : true,
                onPressed: () {
                  // forgotPasswordController.resetPasswordMethod(context);
                }),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
