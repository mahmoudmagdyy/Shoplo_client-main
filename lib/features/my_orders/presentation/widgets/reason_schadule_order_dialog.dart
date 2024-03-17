import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/features/my_orders/presentation/cubit/order_cubit.dart';

import '../../../../resources/colors/colors.dart';
import '../../../../resources/styles/app_text_style.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_toast.dart';
import '../../../../widgets/form_field/text_form_field.dart';
import '../cubit/scheduled_order_state.dart';
import '../cubit/scheduleds_cubit.dart';

class ReasonScheduleOrderDialog extends StatefulWidget {
  final int orderId;

  const ReasonScheduleOrderDialog({Key? key, required this.orderId})
      : super(key: key);

  @override
  State<ReasonScheduleOrderDialog> createState() =>
      _ReasonScheduleOrderDialogState();
}

class _ReasonScheduleOrderDialogState extends State<ReasonScheduleOrderDialog> {
  final TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScheduledOrderCubit(),
      child: Dialog(
        child: Container(
          width: context.width,
          height: context.height * .4,
          padding: EdgeInsets.all(context.width * .05),
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(25.0), bottom: Radius.circular(25.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.tr.reason_for_rejection,
                style: AppTextStyle.textStyleMediumBlack,
              ),
              Form(
                  child: Column(
                children: [
                  AppTextFormField(
                      label: context.tr.message,
                      controller: message,
                      maxLine: 7),
                ],
              )),
              BlocConsumer<ScheduledOrderCubit, ScheduledOrderState>(
                listener: (context, state) {
                  if (state is AcceptRejectScheduledSuccessState) {
                    AppToast.showToastSuccess(context.tr.update_successfully);
                    OrderCubit.get(context).refreshOrderDetails = true;
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  }
                },
                builder: (context, state) {
                  return AppButton(
                    loading: state is AcceptRejectScheduledLoadingState,
                    onPressed: () {
                      ScheduledOrderCubit.get(context)
                          .acceptRejectScheduled(widget.orderId, {
                        "reason": message.text,
                        "status": "canceled",
                      });
                      // OrderCubit.get(context).changeOrderStatus(widget.orderId, {
                      //   "status": "canceled",
                      //   "reason": message.text,
                      // });
                    },
                    title: context.tr.cancel,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
