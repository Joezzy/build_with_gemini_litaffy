import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:littafy/constant/constants.dart';
import 'package:littafy/constant/countryJson.dart';
import 'package:littafy/di/appModule.dart';
import 'package:littafy/src/auth/domain/entities/country_state_model.dart';
import 'package:littafy/src/auth/domain/entities/user_model.dart';
import 'package:littafy/src/auth/domain/usecases/register_use_case.dart';
import 'package:littafy/src/auth/domain/usecases/updateInfo_use_case.dart';
import 'package:littafy/src/auth/presentation/controller/login_view_controller.dart';
import 'package:littafy/src/auth/presentation/views/login_view.dart';
import 'package:littafy/src/generator/presentation/views/home_view.dart';
import 'package:littafy/utils/custom_dialog.dart';
import 'package:littafy/utils/usecase.dart';
import 'package:littafy/utils/validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterViewController extends GetxController {
  final validator = getIt.get<Validator>();
  var user = CurrentUser().obs;
  // List<CountryStateModel> countryList = countryStateListFromJson(json.encode(countryJson));
  var stateLabel = "Select a state";
  final registerFormKey = GlobalKey<FormState>();
  final updateInfoFormKey = GlobalKey<FormState>();
  final firstnameController = TextEditingController(text: "Jin");
  final lastNameController = TextEditingController(text: "Drew");
  final emailController = TextEditingController(text: "jin@gmail.com");
  final phoneController = TextEditingController(text: "09044332233");
  final passwordController = TextEditingController(text: "#Joe1234");
  final passwordController2 = TextEditingController(text: "#Joe1234");
  final code = TextEditingController();
  var showPassword = true.obs;
  RxString? country = RxString("Nigeria");
  var selectedCountry = CountryStateModel().obs;
  RxString? selectedState;
  var accessToken = "".obs;
  var stateList = [].obs;
  var isLoading = false.obs;

  initAccount() {
    // user.value= currentUser!;
  }

  initPersonalInfo() {
    clearText();
    // print(currentUser!.address!.country);
    // print(currentUser!.address!.state);
    // user.value=currentUser!;
    firstnameController.text = user.value!.firstName!;
    lastNameController.text = user.value!.lastName!;
    emailController.text = user.value!.email!;
    country =
        user.value!.country == null ? null : RxString(user.value!.country!);

    stateList.clear();
    List<CountryStateModel> countryList =
        countryStateListFromJson(json.encode(countryJson));
    if (country != null) {
      stateList.value = countryList
          .where((element) => element.name == "Nigeria")
          .first
          .states!;
    }
    // stateList.value.add(StateItem(name: "Select a state",stateCode: "Select a state"));
  }

  void clearText() {
    firstnameController.clear();
    lastNameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    passwordController2.clear();
    code.clear();
    // country=RxString("Nigeria");
    country = RxString("Nigeria");
  }

  initStateItem() {
    country = RxString("Nigeria");
    stateList.clear();
    List<CountryStateModel> countryList =
        countryStateListFromJson(json.encode(countryJson));
    stateList.value =
        countryList.where((element) => element.name == "Nigeria").first.states!;
    // stateList.value.add(StateItem(name: "Select a state",stateCode: "Select a state"));
    // selectedState?.value="Select a state";
  }

  getStates(countryValue) {
    selectedState = null;
    stateList.value = [];
    country!.value = countryValue;
    List<CountryStateModel> countryList =
        countryStateListFromJson(json.encode(countryJson));
    stateList.value = countryList
        .where((element) => element.name == country!.value)
        .first
        .states!;
    // stateList.refresh();
    print("--------------------");
    print(stateList.length);
    print(stateList);
    print(selectedState);
    // stateList.value.add(StateItem(name: "Select a state",stateCode: "Select a state"));
  }

  Future<void> registerMethod(context) async {
    if (registerFormKey.currentState!.validate()) {
      isLoading.value = true;
      // var phoneId = await getPhoneId();
      final registerUseCase = getIt.get<RegisterUseCase>();

      final result = await registerUseCase(Params(CurrentUser(
        email: emailController.value.text.trim(),
        firstName: firstnameController.text.trim(),
        lastName: lastNameController.text.trim(),
        password: passwordController.value.text,
        country: country?.value,
        pushToken: accessToken.value,
        credit: 0.0,
      )));
      result.fold((failure) {
        Dialogs.alertBox(context, "Failed", failure.message);
        isLoading.value = false;
      }, (registerResponseModel) {
        // Get.snackbar("Succeessful","${success.message} added!");
        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(
        //         builder: (BuildContext context) => OtpView(
        //               email: emailController.value.text,
        //               password: passwordController.value.text,
        //               accountCreationToken:
        //                   registerResponseModel.accountCreationToken!,
        //               otp: registerResponseModel.otpCode!,
        //             )),
        //     (Route<dynamic> route) => false);

        // clearText();

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => HomeView()),
            (Route<dynamic> route) => false);
        isLoading.value = false;
      });
    }
  }

  var isLoadingGoogle = false.obs;

  Future<void> googleRegisterMethod(context) async {
    if (isLoadingGoogle.value) {
      return;
    }
    isLoadingGoogle.value = true;
    final loginViewController = Get.put(LoginViewController());
    await loginViewController.googleLogin(context);
    isLoadingGoogle.value = false;
  }

  Future<void> updateInfoMethod(context, [bool inApp = true]) async {
    if (updateInfoFormKey.currentState!.validate()) {
      isLoading.value = true;
      final updateInfoUseCase = getIt.get<UpdateInfoUseCase>();

      final result = await updateInfoUseCase(Params({
        "firstName": firstnameController.text.trim(),
        "lastName": lastNameController.text.trim(),
        "mobile": phoneController.value.text,
        "address": {
          "country": country?.value,
          "state": selectedState?.value,
        }
      }));
      result.fold((failure) {
        Dialogs.alertBox(context, "Failed", failure.message);
        isLoading.value = false;
      }, (newUser) async {
        user.value = newUser;
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('currentUser', user.toJson());
        currentUser = newUser;
        clearText();
        isLoading.value = false;
      });
    }
  }

  final googleSignIn = GoogleSignIn();

  logOutMethod(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove("currentUser");
    pref.clear();
    // final res= await googleSignIn.signOut();
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => const LoginView()),
        (Route<dynamic> route) => false);
  }
}

// Future<String?> getPhoneId() async {
//   // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//   // AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//   String? identifier;
//   try {
//     if (Platform.isAndroid) {
//       var build = await deviceInfo.androidInfo;
//       print(build.id);
//       identifier = build.id; //UUID for Android
//     } else if (Platform.isIOS) {
//       var data = await deviceInfo.iosInfo;
//       identifier = data.identifierForVendor.toString(); //UUID for iOS
//     }
//   } on PlatformException {
//     print('Failed to get platform version');
//   }
//
//   return identifier;
// }
