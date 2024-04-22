import 'package:dartz/dartz.dart';

import 'package:wazzang_diary/core/error/failures.dart';

import '../../../core/usecases/usecase.dart';
import '../../repositories/signup/signup_check_repository.dart';

class CheckEmailUseCase implements UseCase<NoParams, CheckEmailParams> {
  final SignUpCheckRepository repository;
  CheckEmailUseCase(this.repository);

  @override
  Future<Either<Failure, NoParams>> call(CheckEmailParams params) async {
    return await repository.checkEmail(params);
  }
}

class CheckEmailParams {
  final String email;
  CheckEmailParams({required this.email});
}
