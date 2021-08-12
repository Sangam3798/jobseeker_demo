class ApiResponseHelper<T> {
  Status status;
  T? data;
  String? message;
  ApiResponseHelper.loading(this.message) : status = Status.LOADING;
  ApiResponseHelper.completed(this.data) : status = Status.COMPLETED;
  ApiResponseHelper.error(this.message) : status = Status.ERROR;
  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}
enum Status { LOADING, COMPLETED, ERROR }