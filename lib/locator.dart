import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'core/network/network_info.dart';
import 'data/repositories/mock_member_repository_impl.dart';
import 'domain/repositories/member/member_repository.dart';
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
  //Repositories
  sl.registerLazySingleton<MemberRepository>(() => MockMemberRepositoryImpl());

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  final sharedPreferences = await SharedPreferences.getInstance();
  const secureStorage = FlutterSecureStorage();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => secureStorage);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
