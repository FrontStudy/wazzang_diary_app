import 'package:wazzang_diary/domain/usecases/member/sign_in_usecase.dart';
import 'package:wazzang_diary/domain/usecases/member/sign_up_usecase.dart';

abstract class MemberRemoteDataSource {
  signIn(SignInParams params) {}

  signUp(SignUpParams params) {}
}

class MemberRemoteDataSourceImpl implements MemberRemoteDataSource {
  @override
  signIn(SignInParams params) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  signUp(SignUpParams params) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}
