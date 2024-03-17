import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/core/extensions/extensions_on_string.dart';
import 'package:shoplo_client/features/categories/data/models/categories_model.dart';
import 'package:shoplo_client/features/ship_by_global/domain/entities/ship_by_global.dart';
import 'package:shoplo_client/resources/colors/colors.dart';
import 'package:shoplo_client/widgets/app_toast.dart';
import 'package:shoplo_client/widgets/form_field/text_form_field.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../resources/styles/app_text_style.dart';
import '../../../../widgets/app_snack_bar.dart';
import '../../../../widgets/form_field/autocomplate.dart';
import '../../../uploader/presentation/attatchments_uploader.dart';
import '../cubit/ship_by_global_cubit.dart';

class ShipByGlobalShippingDetails extends StatefulWidget {
  const ShipByGlobalShippingDetails({
    super.key,
    required this.shipByGlobalEntity,
  });
  final ShipByGlobalEntity shipByGlobalEntity;

  @override
  State<ShipByGlobalShippingDetails> createState() => _ShipByGlobalShippingDetailsState();
}

class _ShipByGlobalShippingDetailsState extends State<ShipByGlobalShippingDetails> {
  final formKey = GlobalKey<FormState>();
  bool isUploading = false;
  @override
  Widget build(BuildContext context) {
    final cubit = ShipByGlobalCubit.get(context);

    //form
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 0),
            title: Text(context.tr.shipping_details),
          ),
          AppAutoCompleteDropDown<Category>(
              label: context.tr.category,
              searchInApi: false,
              showSufix: true,
              onChanged: (p0) {
                widget.shipByGlobalEntity.shipmentDetails.categoryId = p0.id;
              },
              itemAsString: (s) => s.name ?? "",
              function: (p0) async {
                return (await cubit.getCategories()) ?? [];
              },
              validator: (s) {
                if (s == null || s.isEmpty) {
                  return context.tr.required;
                }
                return null;
              }),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                child: AppTextFormField(
                  label: context.tr.height,
                  keyboardType: TextInputType.number,
                  onChanged: (p0) {
                    widget.shipByGlobalEntity.shipmentDetails.height = p0.toDouble;
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: AppTextFormField(
                  label: context.tr.weight,
                  keyboardType: TextInputType.number,
                  onChanged: (p0) {
                    widget.shipByGlobalEntity.shipmentDetails.weight = p0.toDouble;
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: AppTextFormField(
                  label: context.tr.width,
                  keyboardType: TextInputType.number,
                  onChanged: (p0) {
                    widget.shipByGlobalEntity.shipmentDetails.width = p0.toDouble;
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: AppTextFormField(
                  label: context.tr.length,
                  keyboardType: TextInputType.number,
                  onChanged: (p0) {
                    widget.shipByGlobalEntity.shipmentDetails.length = p0.toDouble;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          AppTextFormField(
            label: context.tr.shipment_description,
            onChanged: (p0) {
              widget.shipByGlobalEntity.shipmentDetails.description = p0;
            },
            maxLine: 3,
          ),
          const SizedBox(height: 10),
          CheckboxListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 0),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {
                widget.shipByGlobalEntity.shipmentDetails.isPackage = value ?? false;
                setState(() {});
              },
              value: widget.shipByGlobalEntity.shipmentDetails.isPackage,
              title: Text(context.tr.package_by_global)),
          CheckboxListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 0),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {
                widget.shipByGlobalEntity.shipmentDetails.isBreakable = value ?? false;
                setState(() {});
              },
              value: widget.shipByGlobalEntity.shipmentDetails.isBreakable,
              title: Text(context.tr.breakable)),
          CheckboxListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 0),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {
                widget.shipByGlobalEntity.shipmentDetails.isRefrigeration = value ?? false;
                setState(() {});
              },
              value: widget.shipByGlobalEntity.shipmentDetails.isRefrigeration,
              title: Text(context.tr.refrigeration_required)),
          Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                context.tr.shipping_fees_paid_by,
                style: AppTextStyle.textStyleBoldBlack,
              )),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: RadioListTile<String>(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (value) {
                      widget.shipByGlobalEntity.shipmentDetails.paidBay = value ?? "";
                      setState(() {});
                    },
                    value: "sender",
                    groupValue: widget.shipByGlobalEntity.shipmentDetails.paidBay,
                    title: Text(context.tr.the_sender)),
              ),
              Expanded(
                child: RadioListTile<String>(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (value) {
                      widget.shipByGlobalEntity.shipmentDetails.paidBay = value ?? "";
                      setState(() {});
                    },
                    value: "receiver",
                    groupValue: widget.shipByGlobalEntity.shipmentDetails.paidBay,
                    title: Text(context.tr.the_receiver)),
              ),
            ],
          ),
          AttachMentUploader(
            onSuccessfulUpload: (file) {
              widget.shipByGlobalEntity.shipmentDetails.attachments.add(file);
              isUploading = false;
              print("success");
            },
            onUploadError: (error) {
              AppToast.showToastError(error);
              isUploading = false;
              print("error");
            },
            onUploadStart: () {
              isUploading = true;
              print("uploading");
            },
          ),
          const SizedBox(height: 40),
          BlocConsumer<ShipByGlobalCubit, ShipByGlobalState>(listener: (context, state) {
            if (state is ShipByGlobalErrorState) {
              AppSnackBar.showError(state.errors);
            }

            if (state is ShipByGlobalSuccessState) {
              AppSnackBar.showSuccess(state.message);

              Navigator.of(context).popAndPushNamed(
                AppRoutes.shipByGlobalView,
                arguments: state.model.id,
              );
            }
          }, builder: (context, state) {
            return state is ShipByGlobalLoadingState
                ? const Center(child: CircularProgressIndicator())
                : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryL,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          if (isUploading) {
                            AppSnackBar.showError(context.tr.please_wait_uploading);
                            return;
                          }
                          if (formKey.currentState!.validate()) {
                            cubit.addShipByGlobal(widget.shipByGlobalEntity);
                          }
                        },
                        child: Text(context.tr.confirm)),
                  );
          }),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
