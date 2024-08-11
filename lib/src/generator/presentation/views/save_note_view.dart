import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:littafy/constant/constants.dart';
import 'package:littafy/custom/btn.dart';
import 'package:littafy/custom/drop_down.dart';
import 'package:littafy/custom/txt.dart';
import 'package:littafy/src/generator/presentation/controller/generator_controller.dart';
import 'package:littafy/src/generator/presentation/views/quiz_view.dart';
import 'package:littafy/utils/app_theme.dart';
import 'package:littafy/utils/custom_dialog.dart';
import 'package:littafy/utils/size_config.dart';
import 'package:littafy/utils/textToQuizConverter.dart';

class SaveNoteView extends StatefulWidget {
  const SaveNoteView({
    super.key,
    this.isQuiz = false,
  });
  final bool isQuiz;

  @override
  State<SaveNoteView> createState() => _SaveNoteViewState();
}

class _SaveNoteViewState extends State<SaveNoteView> {
  final generatorController = Get.put(GeneratorController());
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Title"),
        Txt(
          hintText: "Enter note's title",
          hintColor: Colors.grey,
          controller: generatorController.noteTitleController.value,
        ),
        if (!widget.isQuiz)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MySize.size10,
              ),
              Text("Type"),
              MyDropDown(
                  hint: "Select type",
                  value: generatorController.noteType?.value,
                  itemFunction: noteTypeList.map((item) {
                    return DropdownMenuItem(
                      value: item.value.toString(),
                      child: Text(
                        "${item.title}",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: MySize.size16,
                            color: AppTheme.black),
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) async {
                    generatorController.noteType =
                        RxString(newValue.toString());
                    print(newValue);
                    print(generatorController.noteType?.value);
                  }),
            ],
          ),
        SizedBox(
          height: MySize.size20,
        ),
        FillButton(
            text: "Save".tr,
            enabled: true,
            onPressed: () {
              if (generatorController.noteType == null ||
                  generatorController.noteTitleController.value.text.isEmpty) {
                Dialogs.alertBox(context, "Warning", "Fill all fields");
              } else {
                generatorController.saveNoteMethod(context);
              }
            }),
        if (widget.isQuiz)
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: FillButton(
                text: "Save & Play".tr,
                enabled: true,
                enabledColor: Colors.green,
                onPressed: () async {
                  if (generatorController.noteType == null ||
                      generatorController
                          .noteTitleController.value.text.isEmpty) {
                    Dialogs.alertBox(context, "Warning", "Fill all fields");
                  } else {
                    generatorController.noteType!.value = "quiz";
                    await generatorController.saveNoteMethod(context);

                    final getQuest = QuizGenerator.convertTriviaToJson(
                        generatorController.textOutputController.value.text);
                    Navigator.push(
                        this.context,
                        MaterialPageRoute(
                            builder: (context) => QuizScreen(
                                quizTitle: "New Quiz",
                                quizList: getQuest,
                                fromGenerator: true)));
                  }
                }),
          ),
      ],
    );
  }
}
