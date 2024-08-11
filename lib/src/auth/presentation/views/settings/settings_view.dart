import 'package:flutter/material.dart';
import 'package:littafy/utils/app_theme.dart';
import 'package:littafy/utils/size_config.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.grey,
      body: Container(
        decoration: const BoxDecoration(
          // color: AppTheme.pageBackground.withOpacity(.01),
          color: AppTheme.backColor,

          // color: AppTheme.pageBackground,
        ),
        child: Container(
          margin: EdgeInsets.only(bottom: MySize.size50),
          child: Container(
            color: AppTheme.white,
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 5),
            child: Column(
              children: [
                SettingsOptionButton(
                  text: "Account",
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const AccountView()));
                  },
                ),
                // SettingsOptionButton(
                //   text: "Payment",
                //   onTap: (){},
                // ),
                SettingsOptionButton(
                  text: "Terms & Condition",
                  onTap: () {},
                ),
                SettingsOptionButton(
                  text: "Privacy Policy",
                  onTap: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SettingsOptionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const SettingsOptionButton(
      {super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: TextStyle(fontSize: MySize.size16),
              ),
              const Icon(
                Icons.chevron_right,
                color: AppTheme.primaryColor,
                size: 30,
              )
            ],
          ),
          const Divider(
            height: 20,
            thickness: 0.5,
          )
        ],
      ),
    );
  }
}
