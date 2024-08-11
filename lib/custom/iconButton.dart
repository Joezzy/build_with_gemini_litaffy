import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:littafy/utils/app_theme.dart';
import 'package:littafy/utils/size_config.dart';

class ButtonWithIcon extends StatelessWidget {
  ButtonWithIcon(
      {super.key,
      required this.text,
      this.onTap,
      this.icon,
      this.imageIcon,
      this.width = 100});

  IconData? icon;
  ImageIcon? imageIcon;
  String text;
  VoidCallback? onTap;
  double? width;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(
            horizontal: MySize.size20, vertical: MySize.size10),
        margin: EdgeInsets.symmetric(horizontal: MySize.size5),
        decoration: BoxDecoration(
            // color: AppTheme.primaryColor,
            color: AppTheme.primaryColor.withOpacity(0.9),
            borderRadius: BorderRadius.circular(MySize.size40)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text!,
              style: const TextStyle(color: Colors.white),
            ).tr(),
            SizedBox(
              width: MySize.size5,
            ),
            imageIcon ??
                Icon(
                  icon,
                  color: Colors.white,
                ),
          ],
        ),
      ),
    );
  }
}

class TabWidget extends StatelessWidget {
  TabWidget(
      {super.key,
      required this.text,
      this.onTap,
      this.isInput = true,
      this.value = true,
      this.width = 200});

  String text;
  bool isInput;
  bool value;
  VoidCallback? onTap;
  double? width;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        margin: EdgeInsets.only(right: MySize.size10),
        padding: EdgeInsets.symmetric(
            // horizontal: MySize.size10,
            vertical: MySize.size6),
        decoration: BoxDecoration(
            color: isInput == value ? AppTheme.primaryColor : Colors.white,
            border: Border.all(color: AppTheme.grey),
            borderRadius: BorderRadius.circular(MySize.size40)),
        child: Center(
          child: Text(
            text!,
            style: TextStyle(
                color: isInput == value ? AppTheme.white : AppTheme.black,
                fontSize: MySize.size12),
          ).tr(),
        ),
      ),
    );
  }
}

class ButtonChip extends StatelessWidget {
  ButtonChip(
      {super.key, required this.text, this.onTap, this.icon, this.width = 100});

  IconData? icon;
  String text;
  VoidCallback? onTap;
  double? width;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        margin: EdgeInsets.only(right: MySize.size10),
        padding: EdgeInsets.symmetric(
            horizontal: MySize.size20, vertical: MySize.size6),
        decoration: BoxDecoration(
            // color: Colors.white,
            border: Border.all(color: AppTheme.grey),
            borderRadius: BorderRadius.circular(MySize.size40)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text!,
              style: TextStyle(fontSize: MySize.size12),
            ).tr(),
            SizedBox(
              width: MySize.size5,
            ),
            Icon(
              icon,
              size: MySize.size20,
            ),
          ],
        ),
      ),
    );
  }
}
