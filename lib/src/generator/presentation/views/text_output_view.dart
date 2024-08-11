import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:littafy/constant/constants.dart';
import 'package:littafy/custom/iconButton.dart';
import 'package:littafy/src/generator/presentation/controller/generator_controller.dart';
import 'package:littafy/src/generator/presentation/views/get_text_Option.dart';
import 'package:littafy/utils/size_config.dart';
import 'package:share_plus/share_plus.dart';

class TextOutputView extends StatefulWidget {
  const TextOutputView({super.key});
  @override
  State<TextOutputView> createState() => _TextOutputViewState();
}

class _TextOutputViewState extends State<TextOutputView> {
  final generatorController = Get.put(GeneratorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Output"),
          leading: IconButton(
            icon: const Icon(Iconsax.arrow_left),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: Obx(
        () => Stack(
          children: [
            SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: SizedBox(
                height: MySize.screenHeight,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ButtonChip(
                            text: "edit".tr,
                            icon: Iconsax.edit_2,
                            width: MySize.size120,
                            onTap: () {
                              generatorController.textInputController.value
                                  .text = generatorController.outputText.value;
                              Navigator.pop(context);
                            },
                          ),
                          ButtonChip(
                            text: "share".tr,
                            icon: Iconsax.share,
                            width: MySize.size120,
                            onTap: () {
                              Share.share(
                                  generatorController
                                      .textOutputController.value.text,
                                  subject: appName);
                            },
                          ),
                          ButtonChip(
                            text: "save".tr,
                            icon: Iconsax.save_2,
                            width: MySize.size120,
                            onTap: () {
                              generatorController.saveNoteMethod(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // height: MySize.size650,
                      padding: const EdgeInsets.all(8.0),
                      margin: EdgeInsets.all(MySize.size10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all()),
                      child: Text(generatorController.outputText.value),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getStarted(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        // backgroundColor: AppTheme.white,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState2) {
            return FractionallySizedBox(
                heightFactor: 0.7,
                child: Padding(
                  padding: EdgeInsets.all(MySize.size25),
                  child: GetTextOption(),
                ));
          });
        });
  }

  // generate(context) {
  //   showModalBottomSheet(
  //       context: context,
  //       isScrollControlled: true,
  //       useRootNavigator: true,
  //       // backgroundColor: AppTheme.white,
  //       builder: (context) {
  //         return StatefulBuilder(
  //             builder: (BuildContext context, StateSetter setState2) {
  //           return const FractionallySizedBox(
  //             heightFactor: 0.8,
  //             child: ActionOptionView(),
  //           );
  //         });
  //       });
  // }
}
