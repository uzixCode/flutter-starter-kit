import 'package:core/core.dart';
import 'entities.dart';

abstract class AuthUsecases {
  Future<Either<Failure, BaseResponse<LoginEntity>>> login(BaseRequest data);
}
