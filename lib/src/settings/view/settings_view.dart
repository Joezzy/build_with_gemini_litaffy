import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:littafy/core/language_json.dart';
import 'package:littafy/src/settings/controller/settings_controller.dart';
import 'package:littafy/utils/app_theme.dart';
import 'package:littafy/utils/size_config.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final settings = Get.put(SettingsController());

  @override
  void didChangeDependencies() {
    Locale myLocale = Localizations.localeOf(context);
    print('my locale ${myLocale.countryCode}');
    print('my locale ${myLocale.languageCode}');
    print('my locale ${myLocale.toLanguageTag()}');
    print('my locale ${myLocale.scriptCode}');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              "settings",
              style: AppTheme.title3,
            ).tr(),
            MyContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("dark_theme").tr(),
                  FlutterSwitch(
                    value: settings.isDarkMode.value,
                    height: 26,
                    width: 45,
                    padding: 2,
                    activeColor: AppTheme.primaryColor,
                    inactiveColor: AppTheme.grey,
                    onToggle: (val) {
                      setState(() {
                        settings.isDarkMode.value = val;
                      });
                    },
                  ),
                ],
              ),
            ),
            MyContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("language").tr(),
                  GestureDetector(
                      onTap: () => languageSheet(context),
                      child: const Text("English"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void languageSheet(context) async {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: MySize.size830,
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: MySize.size20),
                      child: Text(
                        "Language",
                        style: TextStyle(
                            fontSize: MySize.size18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: MySize.screenHeight,
                      child: ListView.builder(
                        itemCount: languageList.length,
                        itemBuilder: (context, index) {
                          LocalModel language = languageList[index];
                          return ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(language.name!),
                              ],
                            ),
                            onTap: () async {
                              Navigator.of(context).pop();
                              List localeCode = language.code!.split("-");
                              print(localeCode);
                              // EasyLocalization.of(context)?.setLocale(Locale(localeCode[0], localeCode[1]));
                              context.setLocale(
                                  Locale(localeCode[0], localeCode[1]));
                              await WidgetsBinding.instance.performReassemble();
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          });
        });
  }
}

class MyContainer extends StatelessWidget {
  const MyContainer({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MySize.screenWidth,
        margin: EdgeInsets.all(MySize.size10),
        padding: EdgeInsets.all(MySize.size10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MySize.size10),
          border: Border.all(
            color: AppTheme.primaryColor,
          ),
        ),
        child: child);
  }
}
