import 'package:dartz/dartz.dart';
import 'package:littafy/core/errors/failure.dart';
import 'package:littafy/src/generator/domain/repository/note_repository.dart';
import 'package:littafy/utils/usecase.dart';

class DeleteNoteUseCase implements UseCase<Success, Params<dynamic>> {
  final NoteRepository noteRepository;
  DeleteNoteUseCase(this.noteRepository);

  @override
  Future<Either<Failure, Success>> call(Params data) async {
    return await noteRepository.deleteNoteRepo(data.data);
  }
}
