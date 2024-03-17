import 'package:equatable/equatable.dart';

import '../../../categories/data/models/categories_model.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class GetCategoriesLoadingState extends CategoriesState {}

class GetCategoriesLoadingNextPageState extends CategoriesState {}

class GetCategoriesSuccessState extends CategoriesState {
  final List<Category> categories;
  const GetCategoriesSuccessState(this.categories);
}

class GetCategoriesErrorState extends CategoriesState {
  final String error;
  const GetCategoriesErrorState(this.error);
}
