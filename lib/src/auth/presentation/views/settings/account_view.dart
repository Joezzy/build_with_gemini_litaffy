import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:littafy/constant/constants.dart';
import 'package:littafy/custom/btn.dart';
import 'package:littafy/src/auth/presentation/controller/register_view_controller.dart';
import 'package:littafy/src/auth/presentation/views/settings/change_password_view.dart';
import 'package:littafy/src/auth/presentation/views/settings/personal_info_view.dart';
import 'package:littafy/utils/app_theme.dart';
import 'package:littafy/utils/size_config.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  final registerController = Get.put(RegisterViewController());

  @override
  void initState() {
    registerController.initAccount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.grey,
      body: Container(
        // padding: EdgeInsets.all(MySize.size20),
        decoration: const BoxDecoration(
          // color: AppTheme.pageBackground.withOpacity(.01),
          color: AppTheme.backColor,

          // color: AppTheme.pageBackground,
        ),

        child: ListView(
          children: [
            Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          padding: EdgeInsets.all(MySize.size30),
                          decoration: BoxDecoration(
                              color: AppTheme.backColor,
                              borderRadius: BorderRadius.circular(50)),
                          child: Image.asset(
                            "${assetImage}avatar.png",
                            height: 30,
                            width: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Personal Information",
                          style: TextStyle(
                              fontSize: MySize.size16,
                              fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigator.pushNamed(context, AppRoute.personalInfo),

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PersonalInfoView()));
                          },
                          child: Row(
                            children: [
                              Text(
                                "Edit",
                                style: TextStyle(
                                    color: AppTheme.primaryColor,
                                    fontSize: MySize.size16,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(
                                MdiIcons.pencil,
                                color: AppTheme.primaryColor,
                                size: 20,
                              )
                            ],
                          ),
                        ),
                      ]),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Password",
                  style: TextStyle(
                      fontSize: MySize.size16, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MySize.size15, right: MySize.size20),
                      child: Text(
                        "**********",
                        style: TextStyle(
                            fontSize: MySize.size20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    FillButton(
                        height: MySize.size30,
                        width: MySize.size100,
                        fontSize: MySize.size10,
                        text: "Change",
                        onPressed: () {
                          // Get.toNamed(AppRoute.personalInfo);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ChangePasswordView()));
                          // Navigator.of(context).pushNamed(AppRoute.changePassword);
                        })
                  ],
                ),
                SizedBox(
                  height: MySize.size50,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AccountTile extends StatelessWidget {
  final String text;
  final String? subtitle;

  AccountTile({
    super.key,
    required this.text,
    this.subtitle = "",
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: MySize.size10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style:
                TextStyle(fontSize: MySize.size16, fontWeight: FontWeight.bold),
          ),
          Text(
            subtitle!,
            style: TextStyle(fontSize: MySize.size16, color: AppTheme.black),
          ),
        ],
      ),
    );
  }
}
