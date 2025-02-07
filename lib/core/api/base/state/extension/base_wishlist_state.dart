// lib/core/state/base_wishlist_state.dart
import '../base_state.dart';
import '../view_state.dart';

abstract class BaseWishlistState<T> extends BaseState<T> {
  final List<String> wishlistedProductIds;

  const BaseWishlistState({
    required super.status,
    super.data,
    super.error,
    this.wishlistedProductIds = const [],
  });

  @override
  BaseWishlistState<T> copyWith({
    ViewState<T>? status,
    T? data,
    String? error,
    List<String>? wishlistedProductIds,
  });

  bool isProductWishlisted(String id) => wishlistedProductIds.contains(id);
}
