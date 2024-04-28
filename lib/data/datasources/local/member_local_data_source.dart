import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wazzang_diary/data/models/member/member_model.dart';
import 'dart:convert';

import '../../../core/error/exceptions.dart';

abstract class MemberLocalDataSource {
  Future<void> saveToken(String token);

  Future<void> saveMember(MemberModel memberModel);

  Future<void> clearCache();

  Future<MemberModel> getMember();

  Future<String> getToken();

  Future<bool> isTokenAvailable();
}

const cachedToken = 'TOKEN';
const cachedMember = 'MEMBER';

class MemberLocalDataSourceImpl implements MemberLocalDataSource {
  final FlutterSecureStorage secureStorage;
  final SharedPreferences sharedPreferences;

  MemberLocalDataSourceImpl(
      {required this.secureStorage, required this.sharedPreferences});

  @override
  Future<void> clearCache() async {
    await secureStorage.deleteAll();
    await sharedPreferences.remove(cachedMember);
  }

  @override
  Future<MemberModel> getMember() async {
    if (sharedPreferences.getBool('first_run') ?? true) {
      await secureStorage.deleteAll();
      sharedPreferences.setBool('first_run', false);
    }
    final jsonString = sharedPreferences.getString(cachedMember);
    if (jsonString != null) {
      return Future.value(MemberModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> saveToken(String token) async {
    await secureStorage.write(key: cachedToken, value: token);
  }

  @override
  Future<void> saveMember(MemberModel memberModel) {
    return sharedPreferences.setString(
      cachedMember,
      json.encode(memberModel.toJson()),
    );
  }

  @override
  Future<String> getToken() async {
    String? token = await secureStorage.read(key: cachedToken);
    if (token != null) {
      return token;
    } else {
      throw CacheException();
    }
  }

  @override
  Future<bool> isTokenAvailable() async {
    String? token = await secureStorage.read(key: cachedToken);
    return Future.value((token != null));
  }
}
