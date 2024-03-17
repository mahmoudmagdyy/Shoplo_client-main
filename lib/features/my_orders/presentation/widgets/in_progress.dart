import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shoplo_client/features/my_orders/presentation/cubit/order_cubit.dart';

import '../../../../resources/colors/colors.dart';
import '../../../../widgets/app_list.dart';
import 'order_card.dart';

class InProgress extends HookWidget {
  const InProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // useAutomaticKeepAlive(wantKeepAlive: true);

    useEffect(() {
      context.read<OrderCubit>().getOrders({
        "status": "current",
      });
      return null;
    }, [context.watch<OrderCubit>().refreshOrderDetails]);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        color: AppColors.backgroundGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          return AppList(
            key: const Key('OrderListNew'),
            loadingMoreResults: context.watch<OrderCubit>().loadingMoreResults,
            fetchPageData: (query) => context.read<OrderCubit>().getOrders({
              ...query,
              "status": "current",
            }),
            loadingListItems: state is OrdersLoadingState,
            hasReachedEndOfResults:
                context.watch<OrderCubit>().hasReachedEndOfResults,
            endLoadingFirstTime:
                context.watch<OrderCubit>().endLoadingFirstTime,
            itemBuilder: (context, index) {
              return OrderCard(
                orderModel: context.watch<OrderCubit>().orders[index],
              );
            },
            listItems: context.watch<OrderCubit>().orders,
          );
        },
      ),
    );
  }
}
