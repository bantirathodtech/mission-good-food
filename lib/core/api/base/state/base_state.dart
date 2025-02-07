// lib/core/state/base_state.dart
import 'view_state.dart';

abstract class BaseState<T> {
  final ViewState<T> status;
  final T? data;
  final String? error;

  const BaseState({
    this.status = const ViewInitial(),
    this.data,
    this.error,
  });

  BaseState<T> copyWith({
    ViewState<T>? status,
    T? data,
    String? error,
  });
}