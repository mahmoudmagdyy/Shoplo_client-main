import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';

import '../../../../resources/colors/colors.dart';
import '../../../../resources/styles/app_text_style.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_toast.dart';
import '../../../../widgets/form_field/text_form_field.dart';
import '../cubit/order_cubit.dart';

class ReasonDialog extends StatefulWidget {
  final int orderId;

  const ReasonDialog({Key? key, required this.orderId}) : super(key: key);

  @override
  State<ReasonDialog> createState() => _ReasonDialogState();
}

class _ReasonDialogState extends State<ReasonDialog> {
  final TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: context.width,
        height: context.height * .4,
        padding: EdgeInsets.all(context.width * .05),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
            bottom: Radius.circular(25.0),
          ),
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
                    label: context.tr.message, controller: message, maxLine: 7),
              ],
            )),
            BlocConsumer<OrderCubit, OrderState>(
              listener: (context, state) {
                if (state is ChangeOrderStatusSuccessState) {
                  AppToast.showToastSuccess(context.tr.order_canceled);
                  Navigator.of(context).pop();
                }
                if (state is ChangeOrderStatusErrorState) {
                  AppToast.showToastError(state.error);
                }
              },
              builder: (context, state) {
                return AppButton(
                  loading: state is ChangeOrderStatusLoadingState,
                  onPressed: () {
                    context
                        .read<OrderCubit>()
                        .changeOrderStatus(widget.orderId, {
                      "status": "canceled",
                      "reason": message.text,
                    });
                  },
                  title: context.tr.cancel_order,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
