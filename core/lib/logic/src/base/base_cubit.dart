import 'package:core/core.dart';

part 'base_state.dart';

class BaseLogic<T> extends Cubit<BaseLogicState> {
  BaseLogic() : super(const BaseLogicInit(trigger: 0));

  Future<Either<BaseLogicError, BaseLogicSuccess<BaseResponse<T>>>> fetch<M>(
      Future<Either<Failure, BaseResponse<T>>> Function(M data) repo, M data,
      {bool isLoading = true}) async {
    try {
      if (isLoading) emit(BaseLogicLoading(trigger: state.trigger + 1));
      final res = await repo(data);
      res.fold((l) {
        final s = BaseLogicError(failure: l, trigger: state.trigger + 1);
        emit(s);
      }, (r) {
        final s = BaseLogicSuccess<BaseResponse<T>>(
            data: r, trigger: state.trigger + 1);
        emit(s);
      });
    } catch (e) {
      final s = BaseLogicError(
          failure: Failure(
              response: BaseResponse(status: 1001, message: e.toString())),
          trigger: state.trigger + 1);
      emit(s);
    }
    if (state is BaseLogicSuccess<BaseResponse<T>>) {
      return Right(state as BaseLogicSuccess<BaseResponse<T>>);
    }
    return Left(state as BaseLogicError);
  }

  void success(BaseResponse<T> data) =>
      emit(BaseLogicSuccess(data: data, trigger: state.trigger + 1));
  void error(BaseResponse<T> data) => emit(BaseLogicError(
      failure: Failure(response: data), trigger: state.trigger + 1));

  void reset() => emit(BaseLogicInit(trigger: state.trigger + 1));
  // Future popup(Either<BaseLogicError, BaseLogicSuccess<BaseResponse<T>>> res,
  //     BuildContext context) async {
  //   await res.fold(
  //     (l) async {
  //       await InfoCard(
  //         InfoType.error,
  //         message: l.failure.response.message,
  //       ).show(context);
  //     },
  //     (r) async {
  //       await InfoCard(
  //         InfoType.success,
  //         message: r.data?.message,
  //       ).show(context);
  //     },
  //   );
  // }
}
