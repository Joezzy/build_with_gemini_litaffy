// import 'package:file_picker/file_picker.dart' as filepicker;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:littafy/custom/txt.dart';
import 'package:littafy/src/generator/presentation/controller/generator_controller.dart';
import 'package:littafy/src/generator/presentation/controller/note_controller.dart';
import 'package:littafy/src/generator/presentation/views/get_text_Option.dart';
import 'package:littafy/src/generator/presentation/views/quiz_view.dart';
import 'package:littafy/src/generator/presentation/views/text_input_view.dart';
import 'package:littafy/utils/app_theme.dart';
import 'package:littafy/utils/size_config.dart';
import 'package:littafy/utils/textToQuizConverter.dart';
// import 'package:pdf_text/pdf_text.dart';
// import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class NotesView extends StatefulWidget {
  @override
  _NotesViewState createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  final noteController = Get.put(NoteController());
  @override
  final generatorController = Get.put(GeneratorController());

  @override
  void initState() {
    super.initState();
    noteController.getNoteMethod(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: AppTheme.white,
        drawerEnableOpenDragGesture: true,
        // endDrawerEnableOpenDragGesture: true,
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          onPressed: () {
            getStarted(context);
          },
          child: const Icon(Iconsax.add),
        ),
        appBar: AppBar(),
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            height: MySize.screenHeight,
            padding: EdgeInsets.only(
              // top: MySize.size30,
              left: MySize.size25,
              right: MySize.size25,
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                Text(
                  "notes",
                  style: AppTheme.title3,
                ).tr(),
                SizedBox(
                  height: MySize.size20,
                ),
                SearchTxt(
                    controller: noteController.searchNoteController.value,
                    suffixIcon: const Icon(
                      Iconsax.search_normal,
                      // color: AppTheme.grey,
                    ),
                    borderRadius: MySize.size14,
                    onChanged: (val) {
                      noteController.getNoteMethod(context);
                    }),
                SizedBox(
                  height: MySize.size20,
                ),

                // Padding(
                //   padding:  EdgeInsets.only(top:MySize.size150),
                //   child: Icon(Iconsax.note_remove, size: MySize.size100, color: AppTheme.grey,),
                // ),

                Obx(
                  () => SizedBox(
                    height: MySize.screenHeight,
                    child: ListView.builder(
                      padding: EdgeInsets.only(bottom: MySize.size400),
                      itemCount: noteController.noteList.length,
                      // physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        final note = noteController.noteList[index];
                        return Container(
                            height: MySize.size120,
                            padding: EdgeInsets.all(MySize.size10),
                            margin: EdgeInsets.only(bottom: MySize.size10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius:
                                  BorderRadius.circular(MySize.size15),
                              border: Border.all(
                                color: AppTheme.primaryColor,
                              ),
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: Colors.grey.withOpacity(0.5),
                              //     spreadRadius: 1,
                              //     blurRadius: 10,
                              //     offset: const Offset(0, 3), // changes position of shadow
                              //   ),
                              // ],
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TitleTxt(
                                        note: note.category!,
                                        isNormal: false,
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                              onTap: () => noteController
                                                  .deleteNoteMethod(
                                                      context, note.id),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: MySize.size10),
                                                child: const Icon(
                                                  Iconsax.trash,
                                                  size: 17,
                                                  color: Colors.redAccent,
                                                ),
                                              )),
                                          (note.category!.toLowerCase() !=
                                                  "Quiz".toLowerCase())
                                              ? Row(
                                                  children: [
                                                    GestureDetector(
                                                        onTap: () =>
                                                            generatorController
                                                                .shareNotes(
                                                                    note.title,
                                                                    note
                                                                        .content!),
                                                        child: const Icon(
                                                            Icons
                                                                .share_outlined,
                                                            size: 17)),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    GestureDetector(
                                                        onTap: () {
                                                          generatorController
                                                                  .textInputController
                                                                  .value
                                                                  .text =
                                                              note.content
                                                                  .toString();
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const TextInputView()));
                                                        },
                                                        child: const Icon(
                                                            Iconsax.edit,
                                                            size: 17)),
                                                  ],
                                                )
                                              : GestureDetector(
                                                  onTap: () {
                                                    var quizList = QuizGenerator
                                                        .convertTriviaToJson(
                                                            note.content!);
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                QuizScreen(
                                                                    quizTitle: note
                                                                        .title!,
                                                                    quizList:
                                                                        quizList)));
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Iconsax.timer_start,
                                                        size: 20,
                                                        color: Colors.grey,
                                                      ),
                                                      Text(" Start quiz "),
                                                    ],
                                                  ))
                                        ],
                                      )
                                    ],
                                  ),
                                  const Divider(),
                                  TitleTxt(note: note.title!),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        AppTheme.formatDate(note.date!),
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ]));
                      },
                    ),
                  ),
                )

                // GetTextOption(),
              ],
            ),
          ),
        ));
  }

  getStarted(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        backgroundColor: AppTheme.white,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState2) {
            return FractionallySizedBox(
              heightFactor: 0.7,
              child: Container(
                width: MySize.screenWidth,
                padding: EdgeInsets.all(MySize.size20),
                decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(20)),
                child: GetTextOption(),
              ),
            );
          });
        });
  }
}

class TitleTxt extends StatelessWidget {
  const TitleTxt({
    super.key,
    required this.note,
    this.isNormal = true,
  });

  final String note;
  final bool isNormal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: MySize.size5),
      child: Text(
        toBeginningOfSentenceCase(note!).toString(),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontWeight: isNormal ? null : FontWeight.bold),
      ),
    );
  }
}
