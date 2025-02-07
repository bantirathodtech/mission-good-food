// lib/core/base/base_operational_service.dart
import '../result/operation_result.dart';

abstract class BaseOperationalService<T> {
  Future<OperationResult<T>> execute<R>(
    String path, {
    Map<String, dynamic>? params,
    T? data,
    String method = 'GET',
    R Function(Map<String, dynamic>)? fromJson,
  });
}
