import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:littafy/custom/btn.dart';
import 'package:littafy/custom/txt.dart';
import 'package:littafy/src/auth/presentation/controller/forgot_password_controller.dart';
import 'package:littafy/utils/app_theme.dart';
import 'package:littafy/utils/size_config.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final forgotPasswordController = Get.put(ForgotPasswordController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    forgotPasswordController.clearText();
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
                "Forgot Password",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MySize.size30,
                    color: AppTheme.black),
              ),
            ),
            forgotForm(),
          ],
        ),
      ),
    );
  }

  GetX forgotForm() {
    return GetX<ForgotPasswordController>(builder: (forgotPasswordController) {
      return SingleChildScrollView(
        padding: EdgeInsets.only(
          left: MySize.size20,
          right: MySize.size20,
        ),
        // margin: EdgeInsets.only(top: MySize.size250),
        physics: const NeverScrollableScrollPhysics(),
        child: Form(
          key: forgotPasswordController.forgotFormKey.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MySize.size20, horizontal: 15),
                child: Text(
                  "Enter the Email you registered with",
                  style: TextStyle(fontSize: MySize.size16),
                  // textAlign: TextAlign.center,
                ),
              ),
              Txt(
                hintText: "Email",
                controller: forgotPasswordController.emailController.value,
                validator: forgotPasswordController.validator.emailValidator,
                denySpaces: true,
              ),
              const SizedBox(
                height: 50,
              ),
              FillButton(
                  text: "Request OTP",
                  enabled:
                      forgotPasswordController.isLoading.value ? false : true,
                  onPressed: () async {
                    print("DID");
                    forgotPasswordController.forgotPasswordMethod(context);

                    // MyMailer.sendEmail("onalojoseph96@gmail.com",
                    //     "Testing",
                    //     "Still dont know",
                    //     "<b>We go ahead</b>");
                  }),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      );
    });
  }
}
