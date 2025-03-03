import 'package:sound_mp3/utils/status.dart';

class ApiResponse<T> {
  Status? status;
  String? message;
  T? data;

  // Contructor
  ApiResponse(this.status, this.message, this.data);

  // Named Constructors with initializer list
  ApiResponse.loading() : status = Status.loading;
  ApiResponse.completed(this.data) : status = Status.completed;
  ApiResponse.error(this.message) : status = Status.error;

  @override
  String toString() {
    return '''ApiResponse {
    status: $status,
    data: $data,
    message: $message
  }''';
  }
}
