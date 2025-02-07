import 'package:dio/dio.dart';

import '../base/exception/base_exception.dart';

// lib/core/exceptions/root_exception.dart
class RootException extends BaseException {
  RootException({
    required super.message,
    super.code,
    super.data,
  });

  factory RootException.fromDioError(DioException error) {
    String message;
    String? code;

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        message = 'Connection timeout';
        code = 'TIMEOUT';
        break;
      case DioExceptionType.sendTimeout:
        message = 'Send timeout';
        code = 'TIMEOUT';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Receive timeout';
        code = 'TIMEOUT';
        break;
      case DioExceptionType.badResponse:
        final response = error.response;
        message = response?.data?['message'] ?? 'Bad response';
        code = response?.statusCode?.toString();
        break;
      case DioExceptionType.cancel:
        message = 'Request cancelled';
        code = 'CANCELLED';
        break;
      default:
        message = error.message ?? 'Unknown error occurred';
        code = 'UNKNOWN';
    }

    return RootException(
      message: message,
      code: code,
      data: error.response?.data,
    );
  }

  @override
  String toString() => 'RootException: $message (Code: $code)';
}
