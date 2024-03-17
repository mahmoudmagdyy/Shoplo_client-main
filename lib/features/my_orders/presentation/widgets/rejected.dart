import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../resources/colors/colors.dart';
import '../../../../widgets/app_list.dart';
import '../cubit/order_cubit.dart';
import 'order_card.dart';

class Rejected extends HookWidget {
  const Rejected({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive(wantKeepAlive: true);
    useEffect(() {
      context.read<OrderCubit>().getRejectedOrders({
        "status": "rejected",
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
            key: const Key('OrderListRejected'),
            loadingMoreResults:
                context.watch<OrderCubit>().loadingMoreResultsRejected,
            fetchPageData: (query) =>
                context.read<OrderCubit>().getRejectedOrders({
              ...query,
              "status": "rejected",
            }),
            loadingListItems: state is RejectedOrdersLoadingState,
            hasReachedEndOfResults:
                context.watch<OrderCubit>().hasReachedEndOfResultsRejected,
            endLoadingFirstTime:
                context.watch<OrderCubit>().endLoadingFirstTimeRejected,
            itemBuilder: (context, index) => OrderCard(
              orderModel: context.watch<OrderCubit>().ordersRejected[index],
            ),
            listItems: context.watch<OrderCubit>().ordersRejected,
          );
        },
      ),
    );
  }
}
