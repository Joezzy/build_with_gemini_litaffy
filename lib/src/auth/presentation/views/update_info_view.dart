import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:littafy/custom/btn.dart';
import 'package:littafy/custom/drop_down.dart';
import 'package:littafy/custom/txt.dart';
import 'package:littafy/src/auth/domain/entities/user_model.dart';
import 'package:littafy/src/auth/presentation/controller/register_view_controller.dart';
import 'package:littafy/utils/app_theme.dart';
import 'package:littafy/utils/size_config.dart';

class UpdateInfoView extends StatefulWidget {
  const UpdateInfoView({super.key, this.user});

  final CurrentUser? user;
  @override
  State<UpdateInfoView> createState() => _UpdateInfoViewState();
}

class _UpdateInfoViewState extends State<UpdateInfoView> {
  final registerController = Get.put(RegisterViewController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    registerController.clearText();
    registerController.initPersonalInfo();
    registerController.initStateItem();
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Obx(() => updateInfoForm()),
          Positioned(
              left: 30,
              top: 80,
              child: Text(
                "Complete \nAccount Profile",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MySize.size30,
                    color: AppTheme.primaryColor),
              )),
        ],
      ),
    ));
  }

  Container updateInfoForm() {
    return Container(
      padding: EdgeInsets.only(
        top: MySize.size200,
        left: MySize.size20,
        right: MySize.size20,
      ),
      // margin: EdgeInsets.only(top: MySize.size250),
      // physics: const NeverScrollableScrollPhysics(),
      child: Form(
        key: registerController.updateInfoFormKey,
        child: Column(
          children: [
            Txt(
              hintText: "First name",
              controller: registerController.firstnameController,
              validator: registerController.validator.requiredValidator,
              onChanged: (val) => registerController
                  .registerFormKey.currentState!.widget.onChanged,
            ),
            Txt(
              hintText: "Last name",
              controller: registerController.lastNameController,
              validator: registerController.validator.requiredValidator,
            ),
            Txt(
              hintText: "Email",
              controller: registerController.emailController,
              validator: registerController.validator.emailValidator,
              denySpaces: true,
              readOnly: true,
            ),
            Txt(
              hintText: "Phone No.",
              controller: registerController.phoneController,
              validator: registerController.validator.phoneValidator,
              keyboardType: TextInputType.phone,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // MyDropDown(
                  //     // label: "Select date ",
                  //     hint: "Select country",
                  //     // value:  country,
                  //     value: registerController?.country != null
                  //         ? registerController.country?.value
                  //         : null,
                  //     width: MySize.screenWidth / 2.3,
                  //     itemFunction: registerController.countryList.map((item) {
                  //       return DropdownMenuItem(
                  //         value: item.name.toString(),
                  //         // child: Text("${item.name}"),
                  //         child: Text(
                  //           "${item.name}",
                  //           style: TextStyle(
                  //               fontWeight: FontWeight.normal,
                  //               fontSize: MySize.size16,
                  //               color: AppTheme.black),
                  //         ),
                  //       );
                  //     }).toList(),
                  //     onChanged: (newValue) async {
                  //       registerController.country =
                  //           RxString(newValue.toString());
                  //       // registerController. stateList.clear();
                  //       registerController.stateList.value = countryList
                  //           .where((element) => element.name == newValue)
                  //           .first
                  //           .states!;
                  //       setState(() {
                  //         // country=newValue.toString();
                  //         registerController
                  //             .getStates(registerController.country?.value);
                  //       });
                  //       // registerController.selectedState.value=registerController.stateList.first.name!;
                  //       // setState(() =>  expiryDateloginController.dateRange.value=newValue.toString());
                  //     }),
                  Obx(() {
                    return MyDropDown(
                        // label: "Select date ",
                        hint: "Select state",
                        value: registerController?.selectedState != null
                            ? registerController.selectedState?.value
                            : null,
                        width: MySize.screenWidth / 2.3,
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
                          registerController.selectedState =
                              RxString(newValue.toString());
                          setState(() {});
                        });
                  }),
                ],
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 5.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       MyDropDown(
            //         // label: "Select date ",
            //           hint: "Select country",
            //           value:  registerController.country != null? registerController.country?.value:null,
            //           width: MySize.screenWidth/2.3,
            //           itemFunction: countryList.map((item) {
            //             return DropdownMenuItem(
            //               value: item.name.toString(),
            //               child: Text("${item.name}",style: TextStyle(fontWeight: FontWeight.normal,fontSize: MySize.size16, color:AppTheme.textColor ),),
            //             );
            //           }).toList(),
            //           onChanged: (newValue) async {
            //             print(newValue);
            //             registerController.getStates(newValue.toString());
            //             // registerController.country.value=newValue.toString();
            //             // registerController. stateList.value= countryList.where((element) => element.name == newValue).first.states!;
            //             // print(registerController. selectedCountry.value.states);
            //             // registerController.state.value=registerController.stateList.first.name!;
            //             // // setState(() =>  expiryDateregisterController.dateRange.value=newValue.toString());
            //           }),
            //
            //       Obx(
            //               () {
            //             return MyDropDown(
            //               // label: "Select date ",
            //                 hint: "Select state",
            //                 value:  registerController.selectedState != null? registerController.selectedState?.value:null,
            //                 width: MySize.screenWidth/2.3,
            //                 itemFunction: registerController.stateList.map((item) {
            //                   return DropdownMenuItem(
            //                     value: item.name.toString(),
            //                     child: Text("${item.name}",style: TextStyle(fontWeight: FontWeight.normal,fontSize: MySize.size16, color:AppTheme.textColor ),),
            //                   );
            //                 }).toList(),
            //                 onChanged: (newValue) async {
            //                   print(newValue);
            //                   registerController.selectedState?.value=newValue.toString();
            //                 });
            //           }
            //       ),
            //     ],
            //   ),
            // ),

            const SizedBox(
              height: 30,
            ),
            FillButton(
              text: "Submit",
              enabled: registerController.isLoading.value ? false : true,
              onPressed: () =>
                  registerController.updateInfoMethod(context, false),
            ),
          ],
        ),
      ),
    );
  }
}
