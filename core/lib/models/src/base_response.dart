class BaseResponse<T> {
  int? status;
  String? message;
  T? data;

  BaseResponse({this.status, this.message, this.data});
}
