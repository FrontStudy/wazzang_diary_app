import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {}

class NetworkFailure extends Failure {}

class AuthenticationFailure extends Failure {}

class ExceptionFailure extends Failure {}

class CacheFailure extends Failure {}

class CredentialFailure extends Failure {}

class DuplicateFailure extends Failure {}

class ValidationFailure extends Failure {}

class TokenFailure extends Failure {}
