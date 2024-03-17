import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/features/my_orders/presentation/cubit/rate_cubit.dart';

import '../../../../core/config/constants.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../resources/styles/app_text_style.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_snack_bar.dart';
import '../../../../widgets/form_field/text_form_field.dart';

class RateDialog extends StatefulWidget {
  final int orderId;
  const RateDialog({Key? key, required this.orderId}) : super(key: key);

  @override
  State<RateDialog> createState() => _RateDialogState();
}

class _RateDialogState extends State<RateDialog> {
  final TextEditingController comment = TextEditingController();
  final _form = GlobalKey<FormState>();
  double rate = 3.5;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: context.width,
        height: context.height * .5,
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
              context.tr.rate,
              style: AppTextStyle.textStyleMediumBlack,
            ),
          RatingBar.builder(
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            glowColor: AppColors.white,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              setState(() {
                rate =rating;
              });
            },
          ),
            Form(
              key:_form ,
                child: Column(
              children: [
                AppTextFormField(
                    label: context.tr.comment, controller: comment, maxLine: 7),
              ],
            )),
            BlocConsumer<RateCubit, RateState>(
              listener: (context, state) async{
                if (state is RateErrorState) {
                  AppSnackBar.showError(state.error);
                }
                if (state is RateSuccessState)  {
                  AppSnackBar.showSuccess(context.tr.sent_successfully);
                  Future.delayed(const Duration(seconds: 1)).then((value) {
                    Navigator.of(context).pop();
                  });
                  // _formKey.currentState!.reset();
                }
              },
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Constants.padding15),
                  child: AppButton(
                    loading: state is RateLoadingState,
                    onPressed: () {
                      if (_form.currentState!.validate()) {
                          RateCubit.get(context).sendRate({
                            'comment':comment.text,
                            'order_id': widget.orderId,
                            'rate': rate,
                          });
                      }
                    },
                    title: context.tr.send,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
