import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:littafy/constant/constants.dart';
import 'package:littafy/custom/iconButton.dart';
import 'package:littafy/src/generator/presentation/controller/generator_controller.dart';
import 'package:littafy/src/generator/presentation/views/generate_option_view.dart';
import 'package:littafy/src/generator/presentation/views/get_text_Option.dart';
import 'package:littafy/src/generator/presentation/views/save_note_view.dart';
import 'package:littafy/utils/app_theme.dart';
import 'package:littafy/utils/size_config.dart';

class TextInputView extends StatefulWidget {
  const TextInputView({super.key});
  @override
  State<TextInputView> createState() => _TextInputViewState();
}

class _TextInputViewState extends State<TextInputView> {
  final generatorController = Get.put(GeneratorController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    generatorController.isInput.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        icon: const Icon(Iconsax.arrow_left),
        onPressed: () {
          Navigator.pop(context);
        },
      )),
      body: GetX<GeneratorController>(builder: (generatorController) {
        return Stack(
          children: [
            SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: SizedBox(
                height: MySize.screenHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FadeInRight(
                        delay: const Duration(milliseconds: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ButtonChip(
                              text: tr('copy'),
                              icon: Iconsax.copy,
                              width: MySize.size100,
                              onTap: () {
                                generatorController.copyText();
                              },
                            ),
                            ButtonChip(
                              text: tr('share'),
                              icon: Iconsax.share,
                              width: MySize.size120,
                              onTap: () {
                                generatorController.shareText();
                              },
                            ),
                            ButtonChip(
                              text: tr('save'),
                              icon: Iconsax.save_2,
                              width: MySize.size100,
                              onTap: () {
                                showSaveDialog(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    FadeInLeft(
                      delay: const Duration(milliseconds: 5),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 20.0),
                        // width: MySize.size400,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TabWidget(
                              value: true,
                              text: tr('input'),
                              isInput: generatorController.isInput.value,
                              width: MySize.screenWidth / 2.5,
                              onTap: () {
                                generatorController.isInput.value = true;
                                // Clipboard.setData(
                                //   ClipboardData(
                                //     text: generatorController
                                //         .textInputController.value.text,
                                //   ),
                                // );
                              },
                            ),
                            TabWidget(
                              value: false,
                              text: tr('output'),
                              isInput: generatorController.isInput.value,
                              width: MySize.screenWidth / 2.5,
                              onTap: () {
                                // generatorController.saveNoteMethod(context);

                                generatorController.isInput.value = false;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    generatorController.isInput.value
                        ? FadeInLeft(
                            delay: const Duration(milliseconds: 50),
                            child: GenTextInput(
                                hint: tr('enter_text'),
                                controller: generatorController
                                    .textInputController.value),
                          )
                        : GenTextInput(
                            hint: tr('enter_text'),
                            controller:
                                generatorController.textOutputController.value)
                  ],
                ),
              ),
            ),
            if (generatorController.isInput.value)
              Positioned(
                  bottom: MySize.size20,
                  left: MySize.size10,
                  child: FadeInRight(
                    delay: const Duration(milliseconds: 10),
                    child: ButtonWithIcon(
                      text: tr('add'),
                      icon: Iconsax.add,
                      width: MySize.size160,
                      onTap: () => getStarted(context),
                    ),
                  )),
            if (generatorController.isInput.value)
              Positioned(
                  bottom: MySize.size20,
                  right: MySize.size10,
                  child: FadeInLeft(
                    delay: const Duration(milliseconds: 10),
                    child: ButtonWithIcon(
                      text: tr('action'),
                      imageIcon: ImageIcon(
                        const AssetImage(
                          "${assetImage}gen_logo.png",
                        ),
                        size: MySize.size20,
                        color: AppTheme.white,
                      ),
                      width: MySize.size160,
                      onTap: () {
                        generatorController.getGeneratorOptionMethod();
                        generateAction(context);
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) =>
                        //     const ActionOptionView(
                        //     )));
                      },
                    ),
                  )),
            if (generatorController.isLoading.value)
              Positioned(
                  bottom: 0,
                  right: 0,
                  top: 0,
                  child: Container(
                    height: MySize.screenHeight,
                    width: MySize.screenWidth,
                    color: AppTheme.primaryColor.withOpacity(.3),
                    child: Center(
                      child: Image.asset(
                        "${assetImage}ai_loader.gif",
                        height: MySize.size50,
                      ),
                    ),
                  )),
          ],
        );
      }),
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
                  child: GetTextOption(
                    isInputView: true,
                  ),
                ));
          });
        });
  }

  generateAction(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        // backgroundColor: AppTheme.white,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState2) {
            return const FractionallySizedBox(
              heightFactor: 0.8,
              child: ActionOptionView(),
            );
          });
        });
  }

  showSaveDialog(context) {
    showModalBottomSheet(
        context: this.context,
        isScrollControlled: true,
        useRootNavigator: true,
        // backgroundColor: AppTheme.white,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState2) {
            return FractionallySizedBox(
              heightFactor: 0.8,
              child: Padding(
                padding: EdgeInsets.all(MySize.size22),
                child: const SaveNoteView(),
              ),
            );
          });
        });
  }
}

class GenTextInput extends StatelessWidget {
  const GenTextInput({
    super.key,
    required this.controller,
    required this.hint,
  });

  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        controller: controller,
        // decoration:  InputDecoration(
        //     isDense: true,
        //     border: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(MySize.size15),
        //         borderSide: const BorderSide(color: AppTheme.grey)),
        //     hintText: "Enter text here..."),

        decoration: InputDecoration(
          hintText: hint,
          counterText: "",
          isDense: true,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppTheme.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppTheme.grey,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppTheme.grey,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          // filled: true,
          fillColor: const Color(0xFFC4C4C4).withOpacity(0.2),
          contentPadding: EdgeInsets.symmetric(
            vertical: MySize.size10,
            horizontal: MySize.size15,
          ),
        ),
        maxLines: 24,
        // minLines: 70,
        // controller: cpfcontroller,
      ),
    );
  }
}
