// lib/core/exceptions/base_exception.dart
abstract class BaseException implements Exception {
  final String message;
  final String? code;
  final dynamic data;

  BaseException({
    required this.message, 
    this.code,
    this.data,
  });

  @override
  String toString() => '$runtimeType: $message (Code: $code)';
}