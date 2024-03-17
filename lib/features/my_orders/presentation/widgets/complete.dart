import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../resources/colors/colors.dart';
import '../../../../widgets/app_list.dart';
import '../cubit/order_cubit.dart';
import 'order_card.dart';

class Complete extends HookWidget {
  const Complete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive(wantKeepAlive: true);
    useEffect(() {
      context.read<OrderCubit>().getFinishedOrders({
        "status": "delivery_done",
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
            key: const Key('OrderListCompleted'),
            loadingMoreResults:
                context.watch<OrderCubit>().loadingMoreResultsFinished,
            fetchPageData: (query) =>
                context.read<OrderCubit>().getFinishedOrders({
              ...query,
              "status": "delivery_done",
            }),
            loadingListItems: state is FinishedOrdersLoadingState,
            hasReachedEndOfResults:
                context.watch<OrderCubit>().hasReachedEndOfResultsFinished,
            endLoadingFirstTime:
                context.watch<OrderCubit>().endLoadingFirstTimeFinished,
            itemBuilder: (context, index) => OrderCard(
              orderModel: context.watch<OrderCubit>().ordersFinished[index],
            ),
            listItems: context.watch<OrderCubit>().ordersFinished,
          );
        },
      ),
    );
  }
}
