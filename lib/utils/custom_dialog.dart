import 'package:flutter/material.dart';
import 'package:littafy/custom/btn.dart';
import 'package:littafy/utils/app_theme.dart';
import 'package:littafy/utils/size_config.dart';

enum DialogAction { yes, abort, yes_do_not, abort_do_not }

enum DialogType { success, warning, error, confirm, info }

class Dialogs {
  static Future<DialogAction> alertBox(
    BuildContext context,
    String title,
    String body,
  ) async {
    final action = await showDialog(
        context: context,
        // barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              height: MySize.size280,
              decoration: BoxDecoration(
                  // color: AppTheme.white,
                  borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.symmetric(
                horizontal: MySize.size20,
                vertical: MySize.size20,
              ),
              child: Column(
                children: [
                  Text(title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MySize.size20,
                        color: AppTheme.primaryColor,
                      )),
                  SizedBox(
                    height: MySize.size50,
                  ),
                  Text(
                    body,
                    // style: TextStyle(
                    //   color: Theme.of(context).textTheme.bodyText2?.color,
                    // ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: MySize.size50,
                  ),
                  FilledButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("OK"),
                  ),
                  SizedBox(
                    height: MySize.size20,
                  ),
                ],
              ),
            ),
          );
        });
    return (action != null) ? action : DialogAction.abort;
  }

  static Future<DialogAction> yesAbortDialog(
    BuildContext context,
    String title,
    String body,
  ) async {
    final action = await showDialog(
        context: context,
        // barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
                height: MySize.size200,
                width: MySize.size200,
                decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.all(MySize.size20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: MySize.size16, fontWeight: FontWeight.bold),
                    ),
                    Text(body),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FillButton(
                            height: MySize.size30,
                            width: MySize.size100,
                            fontSize: MySize.size14,
                            enabledColor: Colors.redAccent,
                            text: "Cancel",
                            onPressed: () =>
                                Navigator.of(context).pop(DialogAction.abort)),
                        FillButton(
                            height: MySize.size30,
                            text: "Ok",
                            width: MySize.size100,
                            fontSize: MySize.size14,
                            onPressed: () =>
                                Navigator.of(context).pop(DialogAction.yes)),
                      ],
                    )
                  ],
                )),
          );
        });
    return (action != null) ? action : DialogAction.abort;
  }
}
