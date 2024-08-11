import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:littafy/constant/constants.dart';
import 'package:littafy/di/appModule.dart';
import 'package:littafy/src/auth/domain/entities/login_model.dart';
import 'package:littafy/src/auth/domain/entities/user_model.dart';
import 'package:littafy/src/auth/domain/usecases/google_signin_usecase.dart';
import 'package:littafy/src/auth/domain/usecases/login_use_case.dart';
import 'package:littafy/src/auth/presentation/controller/register_view_controller.dart';
import 'package:littafy/src/auth/presentation/views/login_view.dart';
import 'package:littafy/src/generator/presentation/views/home_view.dart';
import 'package:littafy/utils/custom_dialog.dart';
import 'package:littafy/utils/usecase.dart';
import 'package:littafy/utils/validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewController extends GetxController {
  var registerViewController = Get.put(RegisterViewController());

  final loginFormKey = GlobalKey<FormState>();
  final validator = getIt.get<Validator>();

  final emailController =
      TextEditingController(text: kDebugMode ? "jon@gmail.com" : "");
  final passwordController =
      TextEditingController(text: kDebugMode ? "#Joe1234" : "");
  var showPassword = true.obs;
  var isLoading = false.obs;

  void clearText() {
    emailController.clear();
    passwordController.clear();
  }

  checkValidation() {
    loginFormKey.currentState!.widget.onChanged;
  }

  Future<void> login(context) async {
    if (loginFormKey.currentState!.validate()) {
      loginMethod(context, emailController.value.text.trim(),
          passwordController.value.text);
    }
  }

  Future<void> loginMethod(context, String userEmail, userPassword,
      [bool newUser = false]) async {
    isLoading.value = true;

    final loginUseCase = getIt.get<LoginUseCase>();

    final result = await loginUseCase(Params(LoginModel(
        email: userEmail, password: userPassword, authType: "password")));

    result.fold((failure) {
      Dialogs.alertBox(context, "Failed", failure.message);
    }, (user) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('currentUser', user.toJson());
      currentUser = user;
      print("PASSED");
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => HomeView()),
          (Route<dynamic> route) => false);
    });
    isLoading.value = false;
  }

  var isLoadingGoogle = false.obs;

  Future<void> googleLogin(context) async {
    if (isLoadingGoogle.value) {
      return;
    }

    isLoadingGoogle.value = true;
    final googleLoginUseCase = getIt.get<GoogleLoginUseCase>();
    final result = await googleLoginUseCase(NoParams());
    result.fold((failure) {
      Dialogs.alertBox(context, "Failed", failure.message);
    }, (user) async {
      final pref = await SharedPreferences.getInstance();
    });
    isLoadingGoogle.value = false;
  }

  autoLogin(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userPref = pref.getString('currentUser');
    print("userPref : $userPref");

    if (userPref != null) {
      Map<String, dynamic> userMap =
          jsonDecode(userPref!) as Map<String, dynamic>;
      final userModel = CurrentUser.fromJson(json.encode(userMap));
      currentUser = userModel;

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => HomeView()),
          (Route<dynamic> route) => false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => const LoginView()),
          (Route<dynamic> route) => false);
    }
  }
}
