import 'package:core/core.dart';
import '../domain/entities.dart';
import '../domain/usecases.dart';

class AuthRepositories implements AuthUsecases {
  final Htreq htreq;
  AuthRepositories(this.htreq);
  @override
  Future<Either<Failure, BaseResponse<LoginEntity>>> login(
      BaseRequest data) async {
    final res = await htreq.req(ReqProperties(Endpoints.login, Methods.POST));
    return res.fold(
        (l) => Left(l),
        (r) => Right(
            BaseResponse(status: 200, message: "sukses", data: LoginEntity())));
  }
}
