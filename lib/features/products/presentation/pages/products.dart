import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/core/routes/app_routes.dart';
import 'package:shoplo_client/features/products/presentation/cubit/product_categories_state.dart';
import 'package:shoplo_client/widgets/form_field/search_text_field.dart';
import 'package:shoplo_client/widgets/shoplo/app_app_bar.dart';

import '../../../../resources/colors/colors.dart';
import '../../../../resources/images/images.dart';
import '../../../../widgets/alert_dialogs/login_alert_dialog.dart';
import '../../../../widgets/app_list.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../home/data/models/place_details.dart';
import '../../../layout/presentation/cubit/user/user_cubit.dart';
import '../cubit/product_categories_cubit.dart';
import '../cubit/product_cubit.dart';
import '../widgets/new_product_widget.dart';
import '../widgets/product_category_item.dart';

class ProductsScreen extends StatelessWidget {
  final PlaceDetails store;

  const ProductsScreen({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appAppBar(
        context,
        store.name,
        actions: [
          InkWell(
            onTap: () {
              if (UserCubit.get(context).userData != null) {
                Navigator.of(context).pushNamed(AppRoutes.cartScreen);
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const LoginAlertDialog(),
                );
              }
            },
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    AppImages.shoppingCart,
                    width: 30,
                    height: 25,
                  ),
                ),
                if (UserCubit.get(context).userData != null)
                  Positioned(
                    top: 0,
                    right: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                        border: Border.all(
                          color: Colors.red,
                        ),
                      ),
                      child: BlocBuilder<CartCubit, CartState>(
                        builder: (context, state) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              CartCubit.get(context).cartCount.toString(),
                              style: const TextStyle(
                                  color: AppColors.white, fontSize: 10),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<ProductCategoryCubit>(
            create: (context) => ProductCategoryCubit(),
          ),
          BlocProvider<ProductsCubit>(
            create: (context) => ProductsCubit(),
          ),
        ],
        child: Builder(builder: (context) {
          ProductCategoryCubit categoryCubit =
              context.read<ProductCategoryCubit>();
          return Column(
            children: [
              const SizedBox(height: 20),
              BlocConsumer<ProductCategoryCubit, ProductCategoryState>(
                  listener: (context, state) {
                // if (state is GetProductCategorySuccessState &&
                //     categoryCubit.selectedCategoryId == null) {
                //   if (categoryCubit.categories.isNotEmpty) {
                //     categoryCubit.selectCategory(categoryCubit.categories[0]);
                //   }
                //   final ProductsCubit productsCubit =
                //       context.read<ProductsCubit>();
                // }
              }, builder: (context, state) {
                return SizedBox(
                  height: 40,
                  child: AppList(
                    horizontal: true,
                    grid: false,
                    emptyBuilder: (context) => const SizedBox(),
                    numberOfColumn: 1,
                    key: const Key('productsList'),
                    fetchPageData: (query) => context
                        .read<ProductCategoryCubit>()
                        .getCategories({
                      'type': "products",
                      "store_id": store.placeId,
                      "is_paginated": 1,
                      ...query
                    }),
                    loadingListItems: state is GetProductCategoryLoadingState,
                    hasReachedEndOfResults: true,
                    endLoadingFirstTime: categoryCubit.endLoadingFirstTime,
                    loadingMoreResults: false,
                    itemBuilder: (context, index) {
                      return ProductCategoryItem(
                        selected: categoryCubit.selectedCategoryId ==
                            categoryCubit.categories[index].id,
                        category: categoryCubit.categories[index],
                        onSelected: (category) {
                          categoryCubit.selectCategory(category);
                          final ProductsCubit productsCubit =
                              context.read<ProductsCubit>();
                          productsCubit.getStoresProducts({
                            'store': store.placeId,
                            'category': categoryCubit.selectedCategoryId,
                            if (productsCubit.searchController.text.isNotEmpty)
                              'publicSearch':
                                  productsCubit.searchController.text
                          });
                        },
                      );
                    },
                    listItems: categoryCubit.categories,
                  ),
                );
              }),
              Expanded(
                child: BlocBuilder<ProductsCubit, ProductsState>(
                  builder: (context, state) {
                    ProductsCubit cubit = ProductsCubit.get(context);
                    return Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SearchTextField(
                              controller: cubit.searchController,
                              onChanged: (s) {
                                if (s.length >= 3 || s.isEmpty) {
                                  cubit.getStoresProducts({
                                    'store': store.placeId,
                                    'publicSearch': s,
                                    'category':
                                        categoryCubit.selectedCategoryId,
                                  });
                                }
                              },
                              hint: context.tr.search_your_favorite_store),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: AppList(
                              grid: false,
                              numberOfColumn: 1,
                              key: const Key('productsList'),
                              fetchPageData: (query) =>
                                  cubit.getStoresProducts({
                                'store': store.placeId,
                                ...query,
                                'publicSearch': cubit.searchController.text,
                                'category': categoryCubit.selectedCategoryId,
                              }),
                              loadingListItems:
                                  state is GetStoresProductsLoadingState,
                              hasReachedEndOfResults:
                                  cubit.hasReachedEndOfResults,
                              endLoadingFirstTime: cubit.endLoadingFirstTime,
                              loadingMoreResults: cubit.loadingMoreResults,
                              itemBuilder: (context, index) {
                                return NewProductWidget(
                                  product: cubit.products[index],
                                );
                              },
                              listItems: cubit.products,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
