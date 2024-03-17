import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/core/routes/app_routes.dart';
import 'package:shoplo_client/features/home/presentation/cubit/categories_cubit.dart';
import 'package:shoplo_client/features/home/presentation/cubit/home_cubit.dart';
import 'package:shoplo_client/resources/images/images.dart';
import 'package:shoplo_client/widgets/app_image.dart';
import 'package:shoplo_client/widgets/app_list.dart';

import '../../../../resources/colors/colors.dart';
import '../../../categories/data/models/categories_model.dart';
import '../cubit/categories_state.dart';

class StoreCategories extends HookWidget {
  const StoreCategories({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read<CategoriesCubit>().getCategories({
        "is_paginated": "1",
        "type": 'stores',
      });
      return () {};
    });
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, state) {
          return Column(
            children: [
              // SearchTextField(
              //   hint: context.tr.search_your_favorite_store,
              //   onChanged: (s) {
              //     context.read<CategoriesCubit>().getCategories({
              //       "is_paginated": "1",
              //       "type": 'stores',
              //       "Searchwithtype": s.isEmpty ? '' : '$s,stores',
              //     });
              //   },
              // ),
              const SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: AppList(
                    physics: const AlwaysScrollableScrollPhysics(),
                    key: const Key('CategoriesList'),
                    grid: true,
                    childAspectRatio: 1,
                    loadingMoreResults:
                        context.watch<CategoriesCubit>().loadingMoreResults,
                    fetchPageData: (query) =>
                        context.read<CategoriesCubit>().getCategories({
                      ...query,
                      "is_paginated": "1",
                      "type": 'stores',
                    }),
                    loadingListItems: state is GetCategoriesLoadingState,
                    hasReachedEndOfResults:
                        context.watch<CategoriesCubit>().hasReachedEndOfResults,
                    endLoadingFirstTime:
                        context.watch<CategoriesCubit>().endLoadingFirstTime,
                    itemBuilder: (context, index) {
                      return CategoryItem(
                          category: context
                              .watch<CategoriesCubit>()
                              .categories[index]);
                    },
                    listItems: context.watch<CategoriesCubit>().categories,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.category,
  });
  final Category category;
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          debugPrint("object");
          if (category.id == 0) {
            Navigator.pushNamed(context, AppRoutes.otherStores);
          } else {
            context.read<HomeCubit>().selectCategory(category.id ?? 0);
          }
        },
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: category.id == 0
                    ? Container(
                        color: AppColors.primaryL.withOpacity(.5),
                        child: Image.asset(
                          AppImages.storeIcon,
                          fit: BoxFit.contain,
                        ),
                      )
                    : AppImage(
                        imageViewer: false,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        imageURL: category.image ?? "",
                      ),
              ),
            ),
            Container(
                height: 40,
                width: double.infinity,
                color: AppColors.primaryL,
                child: Center(
                    child: Text(
                  category.id == 0
                      ? context.tr.other_stores
                      : (category.name ?? ''),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white),
                ))),
          ],
        ),
      ),
    );
  }
}
