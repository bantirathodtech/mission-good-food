// lib/core/result/operation_result.dart
sealed class OperationResult<T> {
  const OperationResult();

  factory OperationResult.success(T data) = OperationSuccess<T>;
  factory OperationResult.failure(String message, {String? code}) =
      OperationFailure<T>;
  factory OperationResult.loading() = OperationLoading<T>;

R when<R>({
    required R Function(T) success,
    required R Function(String, String?) failure,
    required R Function() loading,
  }) {
    if (this is OperationSuccess<T>) {
      return success((this as OperationSuccess<T>).data);
    } else if (this is OperationFailure<T>) {
      return failure((this as OperationFailure<T>).message, (this as OperationFailure<T>).code);
    } else {
      return loading();
    }
  }

}

final class OperationSuccess<T> extends OperationResult<T> {
  final T data;
  const OperationSuccess(this.data);
}

final class OperationFailure<T> extends OperationResult<T> {
  final String message;
  final String? code;
  const OperationFailure(this.message, {this.code});
}

final class OperationLoading<T> extends OperationResult<T> {
  const OperationLoading();
}
