// lib/core/base/base_repository.dart
import '../result/operation_result.dart';

abstract class BaseRepository<T> {
  // Future<OperationResult<List<T>>>? getAll([Map<String, dynamic>? params]);
  // Future<OperationResult<T>>? getById(String id); // Changed from getByIds
  // Future<OperationResult<List<T>>>? getByIds(
  //     List<String> ids); // Added new method

  // Optional methods
  Future<OperationResult<T>>? create(T data) => null;
  Future<OperationResult<T>>? update(String id, T data) => null;
  Future<OperationResult<bool>>? delete(String id) => null;
}
