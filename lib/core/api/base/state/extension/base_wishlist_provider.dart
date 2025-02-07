// lib/core/provider/base_wishlist_provider.dart
import 'package:flutter/cupertino.dart';

import '../../provider/base_provider.dart';
import '../../repository/base_repository.dart';
import '../../viewmodel/base_view_model.dart';
import '../base_state.dart';
import 'base_wishlist_state.dart';

abstract class BaseWishlistProvider<T> extends BaseProvider<T> {
  String? _customerId;
  BaseRepository<T>? get repository => (viewModel as dynamic).repository;

  BaseWishlistProvider(BaseViewModel<T> viewModel) : super(viewModel);

  void setCustomerId(String id) {
    _customerId = id;
    _loadWishlist();
  }

  Future<void> _loadWishlist();
  Future<void> toggleWishlist(String id);

  String? get customerId => _customerId;
  bool isProductWishlisted(String id);

  @override
  BaseWishlistState<T> get state => super.state as BaseWishlistState<T>;

  @protected
  @override
  set state(BaseState<T> value) {
    if (value is BaseWishlistState<T>) {
      super.state = value;
    }
  }
}
