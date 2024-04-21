import 'package:wazzang_diary/data/models/member/member_model.dart';

abstract class MemberLocalDataSource {
  Future<void> saveToken(String token);

  Future<void> saveUser(MemberModel memberModel);

  Future<void> clearCache();

  Future<MemberModel> getUser();
}

class MemberLocalDataSourcempl implements MemberLocalDataSource {
  @override
  Future<void> clearCache() {
    // TODO: implement clearCache
    throw UnimplementedError();
  }

  @override
  Future<MemberModel> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<void> saveToken(String token) {
    // TODO: implement saveToken
    throw UnimplementedError();
  }

  @override
  Future<void> saveUser(MemberModel memberModel) {
    // TODO: implement saveUser
    throw UnimplementedError();
  }

}
