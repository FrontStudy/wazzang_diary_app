import 'package:dartz/dartz.dart';
import 'package:wazzang_diary/domain/usecases/signup/check_email_usecase.dart';

import '../../../core/error/failures.dart';

abstract class SignUpCheckRepository {
  Future<Either<Failure, bool>> checkEmail(CheckEmailParams params);
}
