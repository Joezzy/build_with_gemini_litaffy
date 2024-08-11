import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:littafy/di/appModule.dart';
import 'package:littafy/src/auth/domain/usecases/request_otp_use_case.dart';
import 'package:littafy/src/auth/presentation/controller/login_view_controller.dart';
import 'package:littafy/utils/custom_dialog.dart';
import 'package:littafy/utils/usecase.dart';
import 'package:littafy/utils/validator.dart';

class OtpViewController extends GetxController {
  // dynamic argumentData = Get.arguments;
  final loginController = Get.put(LoginViewController());

  var email = "".obs;
  var otp = "".obs;
  var password = "".obs;
  var accountCreationToken = "".obs;
  var countDown = 120.obs;
  var showCountDown = true.obs;
  final validator = getIt.get<Validator>();

  setVar(context, emailVar, passwordVar, otpVar, accountCreationTokenVar) {
    otp.value = otpVar;
    password.value = passwordVar;
    email.value = emailVar;
    accountCreationToken.value = accountCreationTokenVar;

    if (otp.value == "") {
      requestOtpMethod(context, true);
    }
    print("ARGUMENT");
    print("${email.value}");
    print("${password.value}");
    print("${otp.value}");
    print("${accountCreationToken.value}");
  }

  final otpFormKey = GlobalKey<FormState>();
  var otpEditController = TextEditingController().obs;
  var isLoading = false.obs;
  var isLoadingResend = false.obs;

  Future<void> requestOtpMethod(context, [bool firstTime = false]) async {
    isLoadingResend.value = true;
    final requestOtpUseCase = getIt.get<RequestOtpUseCase>();
    final result = await requestOtpUseCase(Params(email.value));
    result.fold((failure) {
      Dialogs.alertBox(context, "Failed", failure.message);
    }, (success) {
      countDown.value = 120;
      otp.value = success.message;
      showCountDown.value = true;
      if (!firstTime) {
        Dialogs.alertBox(context, "Successful", "OTP sent successfully!");
      }
    });
    isLoadingResend.value = false;
  }
}
