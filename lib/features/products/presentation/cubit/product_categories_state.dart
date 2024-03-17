import '../../../categories/data/models/categories_model.dart';

abstract class ProductCategoryState {
  const ProductCategoryState();
}

class ProductCategoryInitial extends ProductCategoryState {}

class GetProductCategoryLoadingState extends ProductCategoryState {}

class GetProductCategoryLoadingNextPageState extends ProductCategoryState {}

class GetProductCategorySuccessState extends ProductCategoryState {
  final List<Category> categories;
  const GetProductCategorySuccessState(this.categories);
}

class GetProductCategoryErrorState extends ProductCategoryState {
  final String error;
  const GetProductCategoryErrorState(this.error);
}

class SelectProductCategoryState extends ProductCategoryState {
  final Category category;
  const SelectProductCategoryState(this.category);
}
