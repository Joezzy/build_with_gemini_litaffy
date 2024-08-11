import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:littafy/di/appModule.dart';
import 'package:littafy/src/auth/domain/usecases/forgot_password_use_case.dart';
import 'package:littafy/src/auth/presentation/views/reset_password_view.dart';
import 'package:littafy/utils/custom_dialog.dart';
import 'package:littafy/utils/usecase.dart';
import 'package:littafy/utils/validator.dart';

class ForgotPasswordController extends GetxController {
  final validator = getIt.get<Validator>();

  var forgotFormKey = GlobalKey<FormState>().obs;
  var resetFormKey = GlobalKey<FormState>().obs;
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var passwordController2 = TextEditingController().obs;
  var code = TextEditingController().obs;
  var showPassword = true.obs;
  var isLoading = false.obs;

  void clearText() {
    emailController.value.clear();
  }

  checkValidation() {
    forgotFormKey.value.currentState!.widget.onChanged;
  }

  Future<void> forgotPasswordMethod(context) async {
    if (forgotFormKey.value.currentState!.validate()) {
      isLoading.value = true;
      final forgotPasswordUseCase = getIt.get<ForgotPasswordUseCase>();
      final result = await forgotPasswordUseCase(
          Params(emailController.value.text.trim()));
      result.fold((failure) {
        Dialogs.alertBox(context, "Failed", failure.message.toString());
      }, (success) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ResetPasswordView()));
      });
      isLoading.value = false;
    }
  }

  Future<void> resetPasswordMethod(context) async {
    if (resetFormKey.value.currentState!.validate()) {
      isLoading.value = true;
      final forgotPasswordUseCase = getIt.get<ForgotPasswordUseCase>();
      final result = await forgotPasswordUseCase(
          Params(emailController.value.text.trim()));
      result.fold((failure) {
        Dialogs.alertBox(context, "Failed", failure.message.toString());
      }, (success) {
        Navigator.pop(context);
        Navigator.pop(context);
        clearText();
        Dialogs.alertBox(context, "Successful", success.message.toString());
      });
      isLoading.value = false;
    }
  }
}
