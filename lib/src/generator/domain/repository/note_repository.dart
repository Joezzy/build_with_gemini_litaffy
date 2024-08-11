import 'package:dartz/dartz.dart';
import 'package:littafy/core/errors/failure.dart';
import 'package:littafy/src/generator/domain/entities/note.dart';

abstract class NoteRepository {
  Future<Either<Failure, Success>> addNoteRepo(Note dynamic);
  Future<Either<Failure, Success>> updateNoteRepo(Note dynamic);
  Future<Either<Failure, List<Note>>> getNoteRepo(String text);
  Future<Either<Failure, Success>> deleteNoteRepo(int id);
}
