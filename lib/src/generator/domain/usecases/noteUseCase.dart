import 'package:littafy/src/generator/domain/usecases/add_note_use_case.dart';
import 'package:littafy/src/generator/domain/usecases/delete_note_use_case.dart';
import 'package:littafy/src/generator/domain/usecases/get_note_use_case.dart';
import 'package:littafy/src/generator/domain/usecases/update_note_use_case.dart';

class NoteUseCase {
  final AddNoteUseCase addNoteUseCase;
  final UpdateNoteUseCase updateNoteUseCase;
  final DeleteNoteUseCase deleteNoteUseCase;
  final GetNoteUseCase getNoteUseCase;

  NoteUseCase(
      {required this.getNoteUseCase,
      required this.deleteNoteUseCase,
      required this.updateNoteUseCase,
      required this.addNoteUseCase});
}
