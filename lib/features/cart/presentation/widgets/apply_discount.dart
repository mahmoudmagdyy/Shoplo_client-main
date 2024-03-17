import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/features/cart/presentation/cubit/payment_cubit.dart';
import 'package:shoplo_client/widgets/form_field/text_form_field.dart';

import '../../../../widgets/app_toast.dart';

class ApplyDiscount extends StatefulWidget {
  const ApplyDiscount({
    Key? key,
    required this.onApply,
    required this.onDelete,
    required this.storeID,
    this.isSelected,
    this.code,
  }) : super(key: key);
  final Function(String) onApply;
  final Function(String) onDelete;
  final String storeID;
  final bool? isSelected;
  final String? code;
  @override
  State<ApplyDiscount> createState() => _ApplyDiscountState();
}

class _ApplyDiscountState extends State<ApplyDiscount> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    controller.text = widget.code ?? "";
    isSelected = widget.isSelected ?? false;
    super.initState();
  }

  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit(),
      child:
          BlocConsumer<PaymentCubit, PaymentState>(listener: (context, state) {
        if (state is CheckCouponSuccessState) {
          widget.onApply(controller.text);
          isSelected = true;
          AppToast.showToastSuccess(context.tr.added_successfully);
        } else if (state is CheckCouponErrorState) {
          AppToast.showToastError(state.error);
        }
      }, builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                      child: AppTextFormField(
                    label: context.tr.coupon_discount,
                    readOnly: isSelected,
                    controller: controller,
                    required: false,
                    onChanged: (s) {},
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      onPressed: state is CheckCouponLoadingState
                          ? null
                          : () {
                              if (isSelected) {
                                widget.onDelete(controller.text);
                                controller.clear();
                                isSelected = false;
                                setState(() {});
                              } else {
                                if (controller.text.isEmpty) {
                                  return;
                                }
                                context.read<PaymentCubit>().checkCoupon({
                                  "promo_code": controller.text,
                                  "store_id": widget.storeID
                                });
                              }
                            },
                      child: state is CheckCouponLoadingState
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 8),
                              child: Text(isSelected
                                  ? context.tr.cancel
                                  : context.tr.apply)))
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
