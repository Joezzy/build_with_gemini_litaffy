import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:littafy/custom/btn.dart';
import 'package:littafy/custom/txt.dart';
import 'package:littafy/src/auth/presentation/controller/change_password_controller.dart';
import 'package:littafy/utils/app_theme.dart';
import 'package:littafy/utils/size_config.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final changePasswordController = Get.put(ChangePasswordController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changePasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
        body: Container(
      color: AppTheme.pageBackground.withOpacity(.05),
      height: MySize.screenHeight,
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Obx(() => passwordForm()),
          ],
        ),
      ),
    ));
  }

  Form passwordForm() {
    return Form(
      key: changePasswordController.passwordFormKey,
      child: Column(
        children: [
          Txt(
            hintText: "Old Password",
            controller: changePasswordController.oldPassword,
            validator: changePasswordController.validator.passwordValidator,
          ),
          SizedBox(
            height: MySize.size280,
          ),
          Txt(
            hintText: "Old Password",
            controller: changePasswordController.oldPassword,
            validator: changePasswordController.validator.passwordValidator,
          ),
          FillButton(
              text: "Save",
              enabled: changePasswordController.isLoading.value ? false : true,
              onPressed: () {
                changePasswordController.changePassword(context);
              }),
          SizedBox(
            height: MySize.size20,
          ),
        ],
      ),
    );
  }
}
