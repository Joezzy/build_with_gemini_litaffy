import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:littafy/constant/constants.dart';
import 'package:littafy/src/auth/presentation/controller/register_view_controller.dart';
import 'package:littafy/src/generator/presentation/views/notes_view.dart';
import 'package:littafy/utils/app_theme.dart';
import 'package:littafy/utils/size_config.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({
    super.key,
  });

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final registerController = Get.put(RegisterViewController());
  @override
  void initState() {
    // TODO: implement initState
    // TODO: implement initState
    super.initState();
    // tokenController.getAllToken(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        // onHorizontalDragUpdate: (_)=>null,
        child: Container(
      width: 250,
      // color: AppTheme.white ,
      decoration: BoxDecoration(
          color: AppTheme.white, borderRadius: BorderRadius.circular(20)),
      child: Drawer(
        child: Container(
          // color: AppTheme.white,
          child: Stack(
            children: [
              ListView(
                padding: const EdgeInsets.all(0),
                children: <Widget>[
                  Container(
                    // padding: EdgeInsets.only(top: MySize.size20),
                    height: MySize.size220,
                    child: DrawerHeader(
                      // decoration:
                      //     const BoxDecoration(
                      //         color: AppTheme.white
                      //     ),
                      child: Column(
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 15, top: MySize.size30),
                                child: SizedBox(
                                  width: MySize.size120,
                                  child: Text(
                                    "${currentUser!.firstName}",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: MySize.size24,
                                        color: AppTheme.primaryColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: MySize.size30,
                  ),

                  MenuWidget(
                      text: "saved_notes",
                      icon: Iconsax.note,
                      onTap: () async {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotesView()));
                      }),
                  // MenuWidget(
                  //     text: "about".tr,
                  //     icon: Iconsax.info_circle,
                  //     onTap: () async {
                  //       // Navigator.pop(context);
                  //       // Navigator.push(
                  //       //     context,
                  //       //     MaterialPageRoute(
                  //       //         builder: (context) =>
                  //       //             WalletScreen())
                  //       // );
                  //     }),
                  // MenuWidget(
                  //     text: "contact_us",
                  //     icon: Iconsax.message,
                  //     onTap: () async {
                  //
                  //       // Navigator.pop(context);
                  //       // Navigator.push(
                  //       //     context,
                  //       //     MaterialPageRoute(
                  //       //         builder: (context) =>
                  //       //             WalletScreen())
                  //       // );
                  //     }),
                  // MenuWidget(
                  //     text: "setting",
                  //     icon: Iconsax.setting,
                  //     onTap: () async {
                  //       Navigator.pop(context);
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) =>
                  //                   const SettingsView())
                  //       );
                  //
                  //     }),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      color: AppTheme.bottomNavColor.withOpacity(0.5),
                      height: MySize.size50,
                    ),
                  ),

                  MenuWidget(
                      text: "log_out",
                      icon: Iconsax.logout_1,
                      onTap: () async {
                        registerController.logOutMethod(context);
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class MenuWidget extends StatelessWidget {
  const MenuWidget({
    super.key,
    required this.text,
    this.iconText,
    this.icon,
    required this.onTap,
  });

  final String text;
  final String? iconText;
  final IconData? icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MySize.size15),
      child: ListTile(
        minLeadingWidth: 10,
        leading: Icon(
          icon,
          color: AppTheme.primaryColor,
        ),
        title: Text(
          text,
          style: TextStyle(fontSize: MySize.size15),
        ).tr(),
        onTap: onTap,
      ),
    );
  }
}
