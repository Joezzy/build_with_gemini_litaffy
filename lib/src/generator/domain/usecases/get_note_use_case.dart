import 'package:dartz/dartz.dart';
import 'package:littafy/core/errors/failure.dart';
import 'package:littafy/src/generator/domain/entities/note.dart';
import 'package:littafy/src/generator/domain/repository/note_repository.dart';
import 'package:littafy/utils/usecase.dart';

class GetNoteUseCase implements UseCase<List<Note>, Params<dynamic>> {
  final NoteRepository noteRepository;
  GetNoteUseCase(this.noteRepository);

  @override
  Future<Either<Failure, List<Note>>> call(Params data) async {
    return await noteRepository.getNoteRepo(data.data);
  }
}
