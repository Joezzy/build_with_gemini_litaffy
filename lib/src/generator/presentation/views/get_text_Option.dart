import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:littafy/constant/constants.dart';
import 'package:littafy/src/generator/presentation/controller/generator_controller.dart';
import 'package:littafy/src/generator/presentation/views/url_input_view.dart';
import 'package:littafy/utils/app_theme.dart';
import 'package:littafy/utils/size_config.dart';

class GetTextOption extends StatefulWidget {
  GetTextOption({super.key, this.isInputView = false});

  final bool isInputView;

  @override
  State<GetTextOption> createState() => _GetTextOptionState();
}

class _GetTextOptionState extends State<GetTextOption> {
  final generatorController = Get.put(GeneratorController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MySize.size600,
      child: ListView.builder(
        itemCount: mainOptionList.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          final result = mainOptionList[index];
          return FadeInRight(
              delay: Duration(milliseconds: 50 * (index + 1)),
              child: RecCard(
                  title: result.title!,
                  subtitle: result.subtitle!,
                  icon: Icon(
                    result.icon!,
                    size: MySize.size28,
                  ),
                  onTap: () {
                    if (result.value == 'url') {
                      showUrl(context);
                    } else {
                      generatorController.textSelectionMethod(
                          context, result.value!, widget.isInputView);
                    }
                  })
              // .animate(delay: Duration(milliseconds: 100*(index+1))).slide(duration: 100.ms),
              );

          // OptionTile(text: result.title!,
          //   onTap: ()=>generatorController. textSelectionMethod(context, result.value!),);
        },
      ),
    );
  }

  showUrl(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        // backgroundColor: AppTheme.white,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState2) {
            return FractionallySizedBox(
              heightFactor: 0.6,
              child: Padding(
                padding: EdgeInsets.all(MySize.size22),
                child: UrlInputView(isInputView: widget.isInputView),
              ),
            );
          });
        });
  }
}

class RecCard extends StatelessWidget {
  RecCard(
      {super.key,
      required this.title,
      this.subtitle,
      this.icon,
      this.onTap,
      this.selected = false});

  String title;
  String? subtitle;
  Widget? icon;
  VoidCallback? onTap;
  bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(
          bottom: MySize.size15,
          // left: MySize.size5,
          // right: MySize.size5,
        ),
        // height: MySize.size180,
        // width: MySize.size180,

        decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(selected ? 1 : 0.1),
            borderRadius: BorderRadius.circular(MySize.size20)),
        child: Stack(
          children: [
            // if(subtitle!=null)
            // Positioned(
            //     top: -80,
            //     right: -MySize.size300,
            //     left: 0,
            //     child: Opacity(
            //       opacity: selected?1:0.1,
            //       child: Image.asset("assets/images/littafy.png",
            //         height: MySize.size300,),
            //     )),

            ListTile(
              leading: icon != null
                  ? Container(
                      padding: EdgeInsets.all(MySize.size10),
                      decoration: BoxDecoration(
                          // color: AppTheme.secondary,
                          borderRadius: BorderRadius.circular(MySize.size10)),
                      child: icon)
                  : null,
              title: Text(title,
                  style: TextStyle(
                      color: selected ? AppTheme.white : null,
                      fontSize: MySize.size14,
                      fontWeight: FontWeight.bold)),
              subtitle: Text(
                subtitle ?? "",
                style: TextStyle(fontSize: MySize.size11),
              ),
            ),

            // Positioned(
            //   top: MySize.size10,
            //   // left: 0,
            //   right: 0,
            //   child: GenIconWidget(child:icon!),
            //   // child: GenIconWidget(child:Icon(Iconsax.document,size: MySize.size70,)),
            // ),
          ],
        ),
      ),
    );
  }
}
