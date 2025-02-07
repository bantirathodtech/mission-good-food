// lib/core/state/view_state.dart
sealed class ViewState<T> {
  const ViewState();
}

final class ViewInitial<T> extends ViewState<T> {
  const ViewInitial();
}

final class ViewLoading<T> extends ViewState<T> {
  const ViewLoading();
}

final class ViewSuccess<T> extends ViewState<T> {
  final T data;
  const ViewSuccess(this.data);
}

final class ViewError<T> extends ViewState<T> {
  final String message;
  const ViewError(this.message);
}