import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:littafy/di/appModule.dart';
import 'package:littafy/src/auth/domain/usecases/change_password_use_case.dart';
import 'package:littafy/utils/custom_dialog.dart';
import 'package:littafy/utils/usecase.dart';
import 'package:littafy/utils/validator.dart';

class ChangePasswordController extends GetxController {
  dynamic argumentData = Get.arguments;
  final validator = getIt.get<Validator>();

  @override
  void onInit() {
    super.onInit();
  }

  clear() {
    oldPassword.clear();
    newPassword.clear();
    confirmPassword.clear();
  }

  final passwordFormKey = GlobalKey<FormState>();

  var isLoading = false.obs;

  final oldPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();

  Future<void> changePassword(context) async {
    if (passwordFormKey.currentState!.validate()) {
      isLoading.value = true;
      final changePasswordUseCase = getIt.get<ChangePasswordUseCase>();
      final result = await changePasswordUseCase(Params({
        "currentPassword": oldPassword.text,
        "newPassword": newPassword.text,
        "confirmPassword": confirmPassword.text
      }));

      result.fold((failure) {
        Dialogs.alertBox(context, "Failed", failure.message);
      }, (success) {
        clear();
        Navigator.pop(context);
        Dialogs.alertBox(
            context, "Successful", "Password changed successfully");
      });
      isLoading.value = false;
    }
  }
}
