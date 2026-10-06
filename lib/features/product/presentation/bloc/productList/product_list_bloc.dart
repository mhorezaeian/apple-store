import 'package:apple_store/core/error/failures.dart';
import 'package:apple_store/features/product/domain/entities/product.dart';
import 'package:apple_store/features/product/domain/repositories/product_repositiry.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductlistState> {
  final ProductRepositiry _productRepositiry;

  // final ProductCategoryRepository _repository;

  ProductListBloc(this._productRepositiry) : super(ProductListInitial()) {
    on<ProductListStarted>((event, emit) async {
      await _getProductDetail(emit, event.categryId);
      // TODO: implement event handler
    });
    on<ProductListRefreshed>((event, emit) async {
      await _getProductDetail(emit, event.categryId);
      // TODO: implement event handler
    });
  }

  Future<void> _getProductDetail(
    Emitter<ProductlistState> emit,
    String categoryId,
  ) async {
    emit(ProductLoadInProgress());

    final productListResult = await _productRepositiry.getProductsByCategory(
      categoryId,
    );

    Failure? failure;

    productListResult.fold((f) => failure ??= f, (_) {});

    if (failure != null) {
      emit(ProductListLoadFailure(message: failure!.message));
      return;
    }
    emit(
      ProductListLoadSuccess(products: productListResult.getOrElse(() => [])),
    );
  }
}
