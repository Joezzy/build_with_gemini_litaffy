import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:littafy/network/dio_client.dart';
import 'package:littafy/src/auth/data/dataSource/auth_service.dart';
import 'package:littafy/src/auth/data/repositories/auth_repository_impl.dart';
import 'package:littafy/src/auth/domain/repositries/auth_repository.dart';
import 'package:littafy/src/auth/domain/usecases/change_password_use_case.dart';
import 'package:littafy/src/auth/domain/usecases/forgot_password_use_case.dart';
import 'package:littafy/src/auth/domain/usecases/google_signin_usecase.dart';
import 'package:littafy/src/auth/domain/usecases/login_use_case.dart';
import 'package:littafy/src/auth/domain/usecases/register_use_case.dart';
import 'package:littafy/src/auth/domain/usecases/request_otp_use_case.dart';
import 'package:littafy/src/auth/domain/usecases/updateInfo_use_case.dart';
import 'package:littafy/src/generator/data/dataSource/ai_service.dart';
import 'package:littafy/src/generator/data/repository/ai_repository_impl.dart';
import 'package:littafy/src/generator/data/repository/note_repository_impl.dart';
import 'package:littafy/src/generator/domain/repository/ai_repository.dart';
import 'package:littafy/src/generator/domain/repository/note_repository.dart';
import 'package:littafy/src/generator/domain/usecases/add_note_use_case.dart';
import 'package:littafy/src/generator/domain/usecases/ai_use_cases.dart';
import 'package:littafy/src/generator/domain/usecases/delete_note_use_case.dart';
import 'package:littafy/src/generator/domain/usecases/gemini_use_case.dart';
import 'package:littafy/src/generator/domain/usecases/get_article_use_case.dart';
import 'package:littafy/src/generator/domain/usecases/get_note_use_case.dart';
import 'package:littafy/src/generator/domain/usecases/noteUseCase.dart';
import 'package:littafy/src/generator/domain/usecases/update_note_use_case.dart';
import 'package:littafy/utils/validator.dart';

final getIt = GetIt.instance;

Future initializeDI() async {
  // getIt.registerFactory(() => DioClient());
  getIt.registerFactory(() => Dio());
  getIt.registerFactory(() => DioClient());

  getIt.registerFactory<AiServices>(
    () => AiServicesImpl(dio: getIt()),
  );
  getIt.registerFactory<AiRepository>(
    () => AiRepositoryImpl(aiServices: getIt()),
  );
  getIt.registerFactory<NoteRepository>(
    () => NoteRepositoryImpl(),
  );
  getIt.registerLazySingleton(() => Validator());

  getIt.registerFactory<AuthService>(
    () => ApiServiceImpl(),
  );
  getIt.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(authService: getIt()),
  );

  getIt.registerFactory(() => LoginUseCase(getIt()));
  getIt.registerFactory(() => GoogleLoginUseCase(getIt()));
  getIt.registerLazySingleton(() => RegisterUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateInfoUseCase(getIt()));
  getIt.registerLazySingleton(() => ChangePasswordUseCase(getIt()));
  getIt.registerLazySingleton(() => RequestOtpUseCase(getIt()));
  getIt.registerLazySingleton(() => ForgotPasswordUseCase(getIt()));

  getIt.registerLazySingleton(() => AiUseCases(
        getArticleUseCase: GetArticleUseCase(getIt()),
        geminiUseCase: GeminiUseCase(getIt()),
      ));

  getIt.registerLazySingleton(() => NoteUseCase(
      addNoteUseCase: AddNoteUseCase(getIt()),
      updateNoteUseCase: UpdateNoteUseCase(getIt()),
      deleteNoteUseCase: DeleteNoteUseCase(getIt()),
      getNoteUseCase: GetNoteUseCase(getIt())));
}
