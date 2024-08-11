import 'package:dartz/dartz.dart';
import 'package:littafy/core/errors/failure.dart';
import 'package:littafy/src/generator/domain/entities/note.dart';
import 'package:littafy/src/generator/domain/repository/note_repository.dart';
import 'package:littafy/utils/usecase.dart';

class UpdateNoteUseCase implements UseCase<Success, Params<Note>> {
  final NoteRepository noteRepository;
  UpdateNoteUseCase(this.noteRepository);

  @override
  Future<Either<Failure, Success>> call(Params data) async {
    return await noteRepository.updateNoteRepo(data.data);
  }
}
