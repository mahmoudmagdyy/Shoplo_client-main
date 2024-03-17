import 'package:flutter/material.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';

import '../../../../resources/colors/colors.dart';
import '../../../../resources/styles/app_text_style.dart';
import '../../../categories/data/models/categories_model.dart';

class ProductCategoryItem extends StatelessWidget {
  const ProductCategoryItem({
    super.key,
    required this.category,
    required this.onSelected,
    required this.selected,
  });

  final Category category;
  final bool selected;
  final Function(Category category) onSelected;
  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.hardEdge,
        shape: const StadiumBorder(),
        color: !selected ? AppColors.backgroundGray2 : AppColors.primaryL,
        child: InkWell(
          onTap: () {
            onSelected(category);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Text(
                category.id == null
                    ? context.tr.all_categories
                    : category.name ?? "",
                style: AppTextStyle.textStyleTitle.copyWith(
                    fontSize: 14,
                    color: selected ? AppColors.white : AppColors.black),
              ),
            ),
          ),
        ));
  }
}
