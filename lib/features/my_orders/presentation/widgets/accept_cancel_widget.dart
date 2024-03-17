import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/features/my_orders/presentation/cubit/order_cubit.dart';
import 'package:shoplo_client/features/my_orders/presentation/widgets/reason_schadule_order_dialog.dart';
import 'package:shoplo_client/widgets/index.dart';

import '../../../../resources/colors/colors.dart';
import '../../../../resources/styles/app_sized_box.dart';
import '../cubit/cubit/order_details_cubit.dart';
import '../cubit/scheduled_order_state.dart';
import '../cubit/scheduleds_cubit.dart';

class AcceptOurCancelWidget extends StatelessWidget {
  const AcceptOurCancelWidget({
    super.key,
    required this.orderId,
  });

  final int orderId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScheduledOrderCubit(),
      child: BlocConsumer<ScheduledOrderCubit, ScheduledOrderState>(
          listener: (context, state) {
        if (state is AcceptRejectScheduledErrorState) {
          AppSnackBar.showError(state.error);
        }
        if (state is AcceptRejectScheduledSuccessState) {
          if (state.status == "canceled") {
            context.read<OrderCubit>().refreshOrderDetails = true;
            Navigator.of(context).pop();
          } else {
            context.read<OrderDetailsCubit>().getOrderDetails(orderId);
          }
        }
      }, builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryL,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: state is AcceptRejectScheduledLoadingState
                      ? null
                      : () {
                          context
                              .read<ScheduledOrderCubit>()
                              .acceptRejectScheduled(orderId, {
                            "status": "approve",
                          });
                        },
                  child: state is AcceptRejectScheduledLoadingState
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Text(context.tr.confirm)),
            ),
            AppSizedBox.sizedH10,
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ReasonScheduleOrderDialog(orderId: orderId);
                      },
                    );
                  },
                  child: Text(context.tr.cancel)),
            ),
            AppSizedBox.sizedH10,
          ],
        );
      }),
    );
  }
}
