import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:littafy/constant/constants.dart';
import 'package:littafy/di/appModule.dart';
import 'package:littafy/src/generator/domain/entities/note.dart';
import 'package:littafy/src/generator/domain/usecases/noteUseCase.dart';
import 'package:littafy/utils/custom_dialog.dart';
import 'package:littafy/utils/usecase.dart';

class NoteController extends GetxController {
  final noteUseCase = getIt<NoteUseCase>();

  var searchNoteController = TextEditingController().obs;
  var noteList = <Note>[].obs;
  Future addNoteMethod(
      context, String title, String content, String category) async {
    final res = await noteUseCase.addNoteUseCase(
        Params(Note(title: title, content: content, category: category)));

    res.fold((fail) {
      Dialogs.alertBox(context, appName, fail.message);
    }, (success) {
      Navigator.pop(context);
      Dialogs.alertBox(context, appName, success.message);
    });
  }

  updateNoteMethod(context) async {
    final res = await noteUseCase.updateNoteUseCase(Params(Note(
        title: "CESC Leo",
        content: "Leo is the goat no doubt..wether u like it or not",
        category: "summary")));

    res.fold((fail) {
      Dialogs.alertBox(context, appName, fail.message);
    }, (success) {
      Dialogs.alertBox(context, appName, success.message);
    });
  }

  deleteNoteMethod(context, noteId) async {
    DialogAction action = await Dialogs.yesAbortDialog(
        context, "Warning", "Are you sure you want to delete this app");
    print(action);
    if (action == DialogAction.yes) {
      final res = await noteUseCase.deleteNoteUseCase(Params(noteId));
      res.fold((fail) {
        Dialogs.alertBox(context, appName, fail.message);
      }, (success) {
        getNoteMethod(context);
        Dialogs.alertBox(context, appName, success.message);
      });
    }
  }

  getNoteMethod(context) async {
    final res = await noteUseCase
        .getNoteUseCase(Params(searchNoteController.value.text));
    res.fold((fail) {
      Dialogs.alertBox(context, appName, fail.message);
    }, (notes) {
      noteList.value = notes;
      noteList.refresh();
    });
  }
}
