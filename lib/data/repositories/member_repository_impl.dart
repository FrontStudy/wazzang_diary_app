import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:wazzang_diary/core/error/failures.dart';
import 'package:wazzang_diary/core/usecases/usecase.dart';
import 'package:wazzang_diary/domain/entities/member/member.dart';
import 'package:wazzang_diary/domain/entities/member/member_detail_info.dart';
import 'package:wazzang_diary/domain/usecases/member/sign_in_usecase.dart';
import 'package:wazzang_diary/domain/usecases/member/sign_up_usecase.dart';
import '../../core/network/network_info.dart';
import '../../domain/repositories/member/member_repository.dart';
import '../datasources/local/member_local_data_source.dart';
import '../datasources/remote/member_remote_data_source.dart';
import '../models/member/authentication_response_model.dart';
import '../models/member/member_model.dart';

typedef _DataSourceChooser = Future<AuthenticationResponseModel> Function();

class MemberRepositoryImpl implements MemberRepository {
  final MemberRemoteDataSource remoteDataSoure;
  final MemberLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  MemberRepositoryImpl({
    required this.remoteDataSoure,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Member>> getCachedMembers() async {
    try {
      final memberModel = await localDataSource.getMember();
      return Right(memberModel.member);
    } on CacheFailure {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Member>> signIn(SignInParams params) async {
    return await _authenticate(() => remoteDataSoure.signIn(params));
  }

  @override
  Future<Either<Failure, NoParams>> signOut() async {
    try {
      await localDataSource.clearCache();
      return Right(NoParams());
    } on CacheFailure {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Member>> signUp(SignUpParams params) async {
    return await _authenticate(() => remoteDataSoure.signUp(params));
  }

  Future<Either<Failure, Member>> _authenticate(
    _DataSourceChooser getDataSource,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteResponse = await getDataSource();
        localDataSource.saveToken(remoteResponse.jtoken);
        localDataSource.saveMember(remoteResponse.memberModel);
        return Right(remoteResponse.memberModel.member);
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Member>>> fetchMembersByIds(
      Set<int> authorIds) async {
    if (await networkInfo.isConnected) {
      List<Future<MemberModel?>> tasks = [];

      for (var id in authorIds) {
        tasks.add(_fetchMemberById(id));
      }
      debugPrint("repo - impl : authorIds length :${authorIds.length}");
      List<MemberModel?> models = await Future.wait(tasks);
      debugPrint("repo - impl : models length :${models.length}");
      return Right(models
          .where((model) => model != null)
          .map((model) => model!.member)
          .toList());
    } else {
      return Left(NetworkFailure());
    }
  }

  Future<MemberModel?> _fetchMemberById(int id) async {
    try {
      final responseModel = await remoteDataSoure.getMemberByid(id);
      return responseModel.data;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<Either<Failure, MemberDetailInfo>> getOwnMemberDetailInfo() async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    if (!await localDataSource.isTokenAvailable()) {
      return Left(TokenFailure());
    }
    String token = await localDataSource.getToken();
    try {
      final remoteResponse =
          await remoteDataSoure.getOwnMemberDetailInfo(token);
      if (remoteResponse.data != null) {
        return Right(remoteResponse.data!.memberDetailInfo);
      } else {
        return Left(ServerFailure());
      }
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
