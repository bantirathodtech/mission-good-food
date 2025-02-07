// lib/core/exceptions/operation_exception.dart
import '../base/exception/base_exception.dart';

class OperationException extends BaseException {
  OperationException({
    required super.message,
    super.code,
    super.data,
  });
}
