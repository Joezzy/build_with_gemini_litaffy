import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:littafy/constant/constants.dart';
import 'package:littafy/custom/btn.dart';
import 'package:littafy/custom/drop_down.dart';
import 'package:littafy/custom/txt.dart';
import 'package:littafy/src/auth/presentation/controller/register_view_controller.dart';
import 'package:littafy/utils/app_theme.dart';
import 'package:littafy/utils/size_config.dart';

class PersonalInfoView extends StatefulWidget {
  const PersonalInfoView({super.key});

  @override
  State<PersonalInfoView> createState() => _PersonalInfoViewState();
}

class _PersonalInfoViewState extends State<PersonalInfoView> {
  final registerController = Get.put(RegisterViewController());
  @override
  void initState() {
    registerController.initPersonalInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
        body: Container(
      height: MySize.screenHeight,
      color: AppTheme.pageBackground.withOpacity(.05),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Obx(() => personalForm()),
          ],
        ),
      ),
    ));
  }

  Form personalForm() {
    return Form(
      key: registerController.updateInfoFormKey,
      child: Column(
        children: [
          Txt(
            hintText: "First name",
            controller: registerController.firstnameController,
            validator: registerController.validator.requiredValidator,
          ),

          Txt(
            hintText: "Last name",
            controller: registerController.lastNameController,
            validator: registerController.validator.requiredValidator,
          ),

          // Txt(
          //   hintText: "Email",
          //
          //   controller: registerController.emailController,
          //   validator: registerController.validator.emailValidator,),

          Txt(
            hintText: "Phone Number",
            controller: registerController.phoneController,
            validator: registerController.validator.requiredValidator,
          ),

          MyDropDown(
              // label: "Select date ",
              hint: "Select country",
              value: registerController.country!.value,
              itemFunction: countryList.map((item) {
                return DropdownMenuItem(
                  value: item.name.toString(),
                  child: Text(
                    "${item.name}",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: MySize.size16,
                        color: AppTheme.black),
                  ),
                );
              }).toList(),
              onChanged: (newValue) async {
                print(newValue);
                registerController.country = RxString(newValue.toString());

                registerController.getStates(registerController.country!.value);

                // registerController. stateList.value= countryList.where((element) => element.name == newValue).first.states!;
                // print(registerController. selectedCountry.value.states);
                // registerController.selectedState.value=registerController.stateList.first.name!;
                // setState(() =>  expiryDateregisterController.dateRange.value=newValue.toString());
              }),

          Obx(() {
            return MyDropDown(
                // label: "Select date ",
                hint: "Select state",
                value: registerController.selectedState != null
                    ? registerController.selectedState?.value
                    : null,
                itemFunction: registerController.stateList.map((item) {
                  return DropdownMenuItem(
                    value: item.name.toString(),
                    child: Text(
                      "${item.name}",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: MySize.size16,
                          color: AppTheme.black),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) async {
                  print(newValue);
                  registerController.selectedState =
                      RxString(newValue.toString());
                  setState(() {});
                });
          }),

          SizedBox(
            height: MySize.size100,
          ),
          FillButton(
            text: "Save",
            enabled: registerController.isLoading.value ? false : true,
            onPressed: () => registerController.updateInfoMethod(context),
          ),
          SizedBox(
            height: MySize.size20,
          ),
        ],
      ),
    );
  }
}
