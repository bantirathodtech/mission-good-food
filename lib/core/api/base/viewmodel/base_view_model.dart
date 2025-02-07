// lib/core/base/base_view_model.dart
import 'package:flutter/foundation.dart';

import '../repository/base_repository.dart';
import '../state/view_state.dart';

abstract class BaseViewModel<T> extends ChangeNotifier {
  final BaseRepository<T> repository;
  ViewState<T> _state = const ViewInitial();

  BaseViewModel(this.repository);

  ViewState<T> get state => _state;

  @protected
  set state(ViewState<T> newState) {
    _state = newState;
    notifyListeners();
  }

  // Make this optional by throwing error
  Future<void> loadData([Map<String, dynamic>? params]) async {
    throw UnimplementedError('Use theme-specific loading methods instead');
  }
}
