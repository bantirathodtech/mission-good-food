// lib/core/provider/base_provider.dart
import 'package:flutter/foundation.dart';
import '../state/base_state.dart';
import '../state/view_state.dart';
import '../viewmodel/base_view_model.dart';

abstract class BaseProvider<T> extends ChangeNotifier {
  final BaseViewModel<T> viewModel;
  late BaseState<T> _state;

  BaseProvider(this.viewModel) {
    _state = initialState;
    setupViewModelListener();
  }

  BaseState<T> get initialState;
  BaseState<T> get state => _state;
  
  @protected
  set state(BaseState<T> value) {
    _state = value;
    notifyListeners();
  }

  void setupViewModelListener() {
    viewModel.addListener(() {
      handleViewModelState(viewModel.state);
    });
  }

  void handleViewModelState(ViewState<T> viewState) {
    switch (viewState) {
      case ViewSuccess s:
        state = state.copyWith(
          status: viewState,
          data: s.data,
          error: null,
        );
      case ViewError e:
        state = state.copyWith(
          status: viewState,
          error: e.message,
        );
      default:
        state = state.copyWith(status: viewState);
    }
  }
}