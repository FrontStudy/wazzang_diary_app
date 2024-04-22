import 'package:dartz/dartz.dart';
import 'package:wazzang_diary/domain/usecases/signup/check_email_usecase.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';

abstract class SignUpCheckRepository {
  Future<Either<Failure, NoParams>> checkEmail(CheckEmailParams params);
}
