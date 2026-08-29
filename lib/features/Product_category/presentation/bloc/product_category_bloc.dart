import 'package:apple_store/features/product_category/domain/repositories/product_category_reposirory.dart';
import 'package:apple_store/features/product_category/presentation/bloc/product_category_state.dart';
import 'package:apple_store/features/product_category/presentation/bloc/product_category_event.dart';
import 'package:bloc/bloc.dart';

class ProductCategoryBloc
    extends Bloc<ProductCategoryEvent, ProductCategoryState> {
  final ProductCategoryRepository _repository;

  ProductCategoryBloc(this._repository) : super(ProductCategoryInitial()) {
    on<ProductCategoryStarted>((event, emit) async {
      await _getCategories(emit);
    });
    on<ProductCategoryRefreshed>((event, emit) async {
      emit(ProductCategoryLoadInProgress());
      await _getCategories(emit);
    });
  }
  Future<void> _getCategories(Emitter<ProductCategoryState> emit) async {
    emit(ProductCategoryLoadInProgress());

    final result = await _repository.getCategoies();

    result.fold(
      (failure) {
        emit(ProductCategoryLoadFailure(message: failure.message));
      },
      (categories) {
        emit(ProductCategoryLoadSuccess(categories: categories));
      },
    );
  }
}
