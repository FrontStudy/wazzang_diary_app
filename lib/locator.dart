import 'package:get_it/get_it.dart';

import 'domain/usecases/member/get_cached_member_usecase.dart';
import 'domain/usecases/member/sign_in_usecase.dart';
import 'domain/usecases/member/sign_out_usecase.dart';
import 'domain/usecases/member/sign_up_usecase.dart';
import 'presentation/blocs/member/member_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //Features - User
  // Bloc
  sl.registerFactory(
    () => MemberBloc(sl(), sl(), sl(), sl()),
  );
  // Use cases
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  sl.registerLazySingleton(() => GetCachedMemberUseCase(sl()));
}
