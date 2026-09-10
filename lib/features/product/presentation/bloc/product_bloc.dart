import 'package:apple_store/features/product/domain/entities/product.dart';
import 'package:apple_store/features/product/domain/repositories/product_repositiry.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepositiry _repositiry;

  ProductBloc(this._repositiry) : super(ProductInitial()) {
    on<ProductStarted>((event, emit) async {
      _getProducts(emit);
      // TODO: implement event handler
    });
    on<ProductRefreshed>((event, emit) async {
      _getProducts(emit);
      // TODO: implement event handler
    });
  }

  Future<void> _getProducts(Emitter<ProductState> emit) async {
    emit(ProductLoadInProgress());

    final result = await _repositiry.getProducts();
    print(result);

    result.fold(
      (failure) {
        emit(ProductLoadFailure(message: failure.message));
      },
      (products) {
        emit(ProductLoadSuccess(products: products));
      },
    );
  }
}
