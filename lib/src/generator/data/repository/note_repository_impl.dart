import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:littafy/core/errors/failure.dart';
import 'package:littafy/local/sqlHelper.dart';
import 'package:littafy/src/generator/domain/entities/note.dart';
import 'package:littafy/src/generator/domain/repository/note_repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  @override
  Future<Either<Failure, Success>> addNoteRepo(Note note) async {
    try {
      final data = await SQLHelper.createItem("notes", note.toJson());
      print("object");
      return Right(Success("Note successfully"));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Success>> deleteNoteRepo(int id) async {
    try {
      final data = await SQLHelper.deleteItem(id, "notes");
      return Right(Success("Note deleted!"));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Note>>> getNoteRepo(String text) async {
    try {
      var res;
      if (text.isEmpty) {
        res = await SQLHelper.getItems("notes");
      } else {
        // res = await SQLHelper.searchItem("notes","content",text);
        res = await SQLHelper.searchWhereTwoColumn(
            "notes", "title", "content", text);
      }
      log(json.encode(res));
      final data = noteFromJson(json.encode(res));
      return Right(data);
    } catch (e) {
      print(e);
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Success>> updateNoteRepo(Note note) async {
    try {
      final data = await SQLHelper.updateItem("notes", "id", note.id, note);
      return Right(Success("Note updated!"));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
