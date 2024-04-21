import 'package:dartz/dartz.dart';
import 'package:wazzang_diary/core/error/failures.dart';
import 'package:wazzang_diary/core/usecases/usecase.dart';
import 'package:wazzang_diary/domain/entities/member/member.dart';
import 'package:wazzang_diary/domain/usecases/member/sign_in_usecase.dart';
import 'package:wazzang_diary/domain/usecases/member/sign_up_usecase.dart';
import '../../core/network/network_info.dart';
import '../../domain/repositories/member/member_repository.dart';
import '../datasources/local/member_local_data_source.dart';
import '../datasources/remote/member_remote_data_source.dart';

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
  Future<Either<Failure, Member>> getCachedMembers() {
    // TODO: implement getCachedMembers
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Member>> signIn(SignInParams params) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, NoParams>> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Member>> signUp(SignUpParams params) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}
