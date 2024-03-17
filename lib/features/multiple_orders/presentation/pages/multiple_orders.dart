import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/core/routes/app_routes.dart';
import 'package:shoplo_client/features/addresses/domain/entities/city.dart';
import 'package:shoplo_client/features/addresses/domain/entities/country.dart';
import 'package:shoplo_client/features/addresses/domain/entities/state.dart';
import 'package:shoplo_client/features/multiple_orders/presentation/widgets/choose_address.dart';
import 'package:shoplo_client/features/network/presentation/pages/network_sensitive.dart';
import 'package:shoplo_client/resources/colors/colors.dart';
import 'package:shoplo_client/widgets/form_field/autocomplate.dart';

import '../../../../resources/styles/app_text_style.dart';
import '../../../../widgets/app_snack_bar.dart';
import '../../../../widgets/form_field/date_time_picker.dart';
import '../../../../widgets/shoplo/app_app_bar.dart';
import '../cubit/multiple_orders_cubit.dart';
import '../cubit/multiple_orders_review_cubit.dart';
import '../widgets/add_new_order_widget.dart';
import '../widgets/list_of_order_description.dart';

class MultipleOrdersScreen extends HookWidget {
  const MultipleOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //text controllers
    final formKey = useState(GlobalKey<FormState>());
    final stateText = useTextEditingController();
    final cityFrom = useTextEditingController();
    return BlocProvider(
      create: (context) => MultipleOrdersCubit()..initRequest(context),
      child: BlocConsumer<MultipleOrdersCubit, MultipleOrdersState>(listener: (context, state) {
        //error
        if (state is MultipleOrdersErrorState) {
          AppSnackBar.showError(state.error);
        }
        //preview order
        else if (state is MultipleOrdersPreviewOrderSuccessState) {
          Navigator.of(context).pushNamed(
            AppRoutes.multipleOrdersReview,
            arguments: state.request,
          );
        }
      }, builder: (context, state) {
        final cubit = MultipleOrdersCubit.get(context);

        return Scaffold(
          appBar: appAppBar(context, context.tr.order_your_shipment, leading: false),
          body: NetworkSensitive(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Form(
                key: formKey.value,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    AppAutoCompleteDropDown<Country>(
                      label: context.tr.country,
                      searchInApi: false,
                      showSufix: true,
                      onChanged: (p0) {
                        cubit.createRequest.setCountry(p0);
                        cubit.refreshFields('country');
                        cityFrom.text = '';
                        stateText.text = '';
                      },
                      itemAsString: (s) => s.name,
                      function: (p0) async => (await cubit.geCountry()) ?? [],
                    ),
                    const SizedBox(height: 20),
                    IgnorePointer(
                      ignoring: cubit.createRequest.country == null,
                      child: AppAutoCompleteDropDown<StateEntity>(
                        label: context.tr.state,
                        controller: stateText,
                        showSufix: true,
                        refreshOnTap: true,
                        searchInApi: false,
                        onChanged: (p0) {
                          cubit.createRequest.setState(p0);
                          cubit.refreshFields('state');
                          cityFrom.text = '';
                        },
                        itemAsString: (s) => s.name,
                        function: (p0) async => (await cubit.getStates(cubit.createRequest.country!.id)) ?? [],
                      ),
                    ),
                    const SizedBox(height: 20),
                    IgnorePointer(
                      ignoring: cubit.createRequest.state == null,
                      child: AppAutoCompleteDropDown<City>(
                        label: context.tr.from_city,
                        controller: cityFrom,
                        searchInApi: false,
                        refreshOnTap: true,
                        showSufix: true,
                        onChanged: (p0) {
                          cubit.createRequest.fromCity = p0;
                          cubit.refreshFields('fromCity');
                        },
                        itemAsString: (s) => s.name,
                        function: (p0) async => (await cubit.getCity(cubit.createRequest.state!.id)) ?? [],
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomDateAndTimePicker(
                      label: context.tr.from,
                      onChanged: (p0) {
                        cubit.createRequest.from = p0;
                      },
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return context.tr.required;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomDateAndTimePicker(
                      label: context.tr.to,
                      onChanged: (p0) {
                        cubit.createRequest.to = p0;
                      },
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return context.tr.required;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ChooseAddress(
                        address: cubit.createRequest.toAddress,
                        onAddressChanged: (p0) {
                          cubit.createRequest.toAddress = p0;
                        }),
                    const SizedBox(height: 20),
                    AddNewOrderWidget(
                      onTap: () {
                        cubit.addOrderDescription();
                      },
                    ),
                    const SizedBox(height: 10),
                    const OrderDescriptionList(),
                    const SizedBox(height: 20),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text(
                        "${context.tr.total_expected_price} : ${cubit.createRequest.orderTotal}",
                        style: AppTextStyle.textStyleBoldBlack,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryL,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: state is MultipleOrdersReviewLoading
                              ? null
                              : () {
                                  if (formKey.value.currentState!.validate()) {
                                    if (cubit.validateTime(context)) {
                                      cubit.previewOrder();
                                    }
                                  }
                                },
                          child: state is MultipleOrdersPreviewOrderLoadingState
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: AppColors.white,
                                  ),
                                )
                              : Text(context.tr.confirm)),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          )),
        );
      }),
    );
  }
}
