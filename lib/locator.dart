import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'core/network/network_info.dart';
import 'data/datasources/local/member_local_data_source.dart';
import 'data/datasources/remote/comment_remote_data_source.dart';
import 'data/datasources/remote/diary_remote_data_source.dart';
import 'data/datasources/remote/follow_remote_data_source.dart';
import 'data/datasources/remote/image_remote_data_source.dart';
import 'data/datasources/remote/member_remote_data_source.dart';
import 'data/datasources/remote/signup_check_remote_data_source.dart';
import 'data/repositories/comment_repository_impl.dart';
import 'data/repositories/diary_repository_impl.dart';
import 'data/repositories/follow_repository_impl.dart';
import 'data/repositories/image_repository_impl.dart';
import 'data/repositories/member_repository_impl.dart';
import 'data/repositories/signup_check_repository_impl.dart';
import 'domain/repositories/comment/comment_repository.dart';
import 'domain/repositories/diary/diary_repository.dart';
import 'domain/repositories/follow/follow_repository.dart';
import 'domain/repositories/image/image_repository.dart';
import 'domain/repositories/member/member_repository.dart';
import 'domain/repositories/signup/signup_check_repository.dart';
import 'domain/usecases/comment/add_comment_use_case.dart';
import 'domain/usecases/comment/fetch_comment_use_case.dart';
import 'domain/usecases/diary/add_bookmark_use_case.dart';
import 'domain/usecases/diary/fetch_diary_detail_list_use_case.dart';
import 'domain/usecases/diary/fetch_diary_detail_use_case.dart';
import 'domain/usecases/diary/fetch_diary_list_use_case.dart';
import 'domain/usecases/diary/like_diary_use_case.dart';
import 'domain/usecases/diary/remove_bookmark_use_case.dart';
import 'domain/usecases/diary/unlike_diary_use_case.dart';
import 'domain/usecases/follow/follow_use_case.dart';
import 'domain/usecases/follow/unfollow_use_case.dart';
import 'domain/usecases/member/get_cached_member_usecase.dart';
import 'domain/usecases/member/sign_in_usecase.dart';
import 'domain/usecases/member/sign_out_usecase.dart';
import 'domain/usecases/member/sign_up_usecase.dart';
import 'domain/usecases/signup/check_email_usecase.dart';
import 'domain/usecases/signup/set_profile_image_usecase.dart';
import 'presentation/blocs/comment/comment_bloc.dart';
import 'presentation/blocs/diary/current_diary_bloc.dart';
import 'presentation/blocs/diary/pub_diary_bloc.dart';
import 'presentation/blocs/member/member_bloc.dart';
import 'presentation/blocs/signup/check_email_bloc.dart';
import 'presentation/blocs/signup/profile_image_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //Features - Member
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
  sl.registerLazySingleton<MemberRepository>(() => MemberRepositoryImpl(
      remoteDataSoure: sl(), localDataSource: sl(), networkInfo: sl()));
  // Data sources
  sl.registerLazySingleton<MemberLocalDataSource>(() =>
      MemberLocalDataSourceImpl(sharedPreferences: sl(), secureStorage: sl()));
  sl.registerLazySingleton<MemberRemoteDataSource>(
      () => MemberRemoteDataSourceImpl(client: sl()));

  //Features - SignUp
  // Bloc
  sl.registerFactory(() => CheckEmailBloc(sl()));
  // Use cases
  sl.registerLazySingleton(() => CheckEmailUseCase(sl()));
  //repositories
  sl.registerLazySingleton<SignUpCheckRepository>(() =>
      SignUpCheckRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  //Data sources
  sl.registerLazySingleton<SignUpCheckRemoteDataSource>(
      () => SignUpCheckRemoteDataSourceImpl(client: sl()));

  //Features - Image
  //Bloc
  sl.registerFactory(() => ProfileImageBloc(sl()));
  // Use cases
  sl.registerLazySingleton(() => SetProfileImageUseCase(sl()));
  //Repositories
  sl.registerLazySingleton<ImageRepository>(() => ImageRepositoryImpl(
      memberLocalDataSource: sl(), networkInfo: sl(), remoteDataSource: sl()));
  //Data sources
  sl.registerLazySingleton<ImageRemoteDataSource>(
      () => ImageRemoteDataSourceImpl(client: sl()));

  //Features - Diary
  // Bloc
  sl.registerFactory(
      () => PubDiaryBloc(sl(), sl(), sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory(
      () => CurrentDiaryBloc(sl(), sl(), sl(), sl(), sl(), sl(), sl()));
  // Use cases
  sl.registerLazySingleton(() => FetchDiaryDetailUseCase(sl()));
  sl.registerLazySingleton(() => FetchPublicDiaryListUseCase(sl(), sl()));
  sl.registerLazySingleton(() => FetchPublicDiaryDetailListUseCase(sl()));
  sl.registerLazySingleton(() => LikeDiaryUseCase(sl()));
  sl.registerLazySingleton(() => UnlikeDiaryUseCase(sl()));
  sl.registerLazySingleton(() => AddBookmarkUseCase(sl()));
  sl.registerLazySingleton(() => RemoveBookmarkUseCase(sl()));
  sl.registerLazySingleton(() => FollowUseCase(sl()));
  sl.registerLazySingleton(() => UnfollowUseCase(sl()));
  //Repositories
  sl.registerLazySingleton<DiaryRepository>(() => DiaryRepositoryImpl(
      networkInfo: sl(), remoteDataSource: sl(), memberLocalDataSource: sl()));
  //Data sources
  sl.registerLazySingleton<DiaryRemoteDataSource>(
      () => DiaryRemoteDataSourceImpl(client: sl()));

  //Feature - Follow
  // Repositories
  sl.registerLazySingleton<FollowRepository>(() => FollowRepositoryImpl(
      networkInfo: sl(), remoteDataSource: sl(), memberLocalDataSource: sl()));
  //Data sources
  sl.registerLazySingleton<FollowRemoteDataSource>(
      () => FollowRemoteDataSourceImpl(client: sl()));

  //Features - Comment
  //Bloc
  sl.registerFactory(() => CommentBloc(sl(), sl()));
  // Use cases
  sl.registerLazySingleton(() => AddCommentUseCase(sl()));
  sl.registerLazySingleton(() => FetchCommentUseCase(sl()));
  // Repositories
  sl.registerLazySingleton<CommentRepository>(() => CommentRepositoryImpl(
      networkInfo: sl(), remoteDataSource: sl(), memberLocalDataSource: sl()));
  // Data Sources
  sl.registerLazySingleton<CommentRemoteDataSource>(
      () => CommentRemoteDataSourceImpl(client: sl()));

  // etc.
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  final sharedPreferences = await SharedPreferences.getInstance();
  const secureStorage = FlutterSecureStorage();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => secureStorage);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
