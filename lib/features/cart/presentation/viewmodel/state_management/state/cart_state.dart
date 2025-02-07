// lib/features/cart/presentation/state/cart_state.dart
import 'package:flutter/cupertino.dart';

import '../../../../../../core/api/base/state/base_state.dart';
import '../../../../../../core/api/base/state/view_state.dart';
import '../../../../domain/model/cart_model.dart';

@immutable
class CartState extends BaseState<CartModel> {
  final bool isLoading;
  final bool isProcessing; // For background operations
  final String? activeOperation; // Tracks current operation type

  const CartState({
    ViewState<CartModel> status = const ViewInitial(),
    CartModel? data,
    String? error,
    this.isLoading = false,
    this.isProcessing = false,
    this.activeOperation,
  }) : super(status: status, data: data, error: error);

  @override
  CartState copyWith({
    ViewState<CartModel>? status,
    CartModel? data,
    String? error,
    bool? isLoading,
    bool? isProcessing,
    String? activeOperation,
  }) {
    return CartState(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      isProcessing: isProcessing ?? this.isProcessing,
      activeOperation: activeOperation ?? this.activeOperation,
    );
  }

  // Cart state calculations
  bool get isEmpty => data?.isEmpty ?? true;
  int get itemCount => data?.items?.length ?? 0;
  num get subtotal => data?.orderSummary?.subtotal ?? 0;
  num get totalAmount => data?.orderSummary?.grandTotal ?? 0;
  bool get hasShipping => data?.orderSummary?.shippingCost != null;
  bool get hasDiscount => data?.orderSummary?.totalDiscount != null;
}
