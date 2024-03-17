import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplo_client/features/multiple_orders/presentation/cubit/multiple_orders_cubit.dart';

import 'order_description_input_widget.dart';

class OrderDescriptionList extends StatelessWidget {
  const OrderDescriptionList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MultipleOrdersCubit, MultipleOrdersState>(
        buildWhen: (previous, current) {
      if (current is MultipleOrdersAddOrderDescriptionState ||
          current is MultipleOrdersRemoveOrderDescriptionState) {
        return true;
      }
      return false;
    }, builder: (context, state) {
      return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => OrderDescriptionInputsWidget(
              key: UniqueKey(),
              order:
                  MultipleOrdersCubit.get(context).createRequest.stores[index]),
          itemCount:
              MultipleOrdersCubit.get(context).createRequest.stores.length);
    });
  }
}
