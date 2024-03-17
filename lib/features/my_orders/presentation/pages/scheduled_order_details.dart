import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/features/my_orders/presentation/cubit/order_cubit.dart';
import 'package:shoplo_client/features/network/presentation/pages/network_sensitive.dart';
import 'package:shoplo_client/widgets/index.dart';
import 'package:shoplo_client/widgets/shoplo/app_app_bar.dart';

import '../../../../resources/styles/app_text_style.dart';
import '../../../multiple_orders/presentation/pages/multiple_orders_review.dart';
import '../../../multiple_orders/presentation/widgets/country_information.dart';
import '../../../multiple_orders/presentation/widgets/from_to__information_widget.dart';
import '../../../multiple_orders/presentation/widgets/order_address_infromation.dart';
import '../../../multiple_orders/presentation/widgets/order_store_requierments.dart';
import '../cubit/cubit/order_details_cubit.dart';
import '../widgets/accept_cancel_widget.dart';

class ScheduledOrderDetails extends HookWidget {
  final int orderId;

  const ScheduledOrderDetails({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final descriptionController = useTextEditingController();
    final priceController = useTextEditingController();
    final downloadInvoice = useState(false);

    useEffect(() {
      context.read<OrderDetailsCubit>().getOrderDetails(orderId);
      return null;
    }, [orderId, context.watch<OrderCubit>().refreshOrderDetails]);

    return Scaffold(
      appBar: appAppBar(
        context,
        context.tr.order_details,
        actions: [
          // if (downloadInvoice.value)
          //   SvgPicture.asset(AppImages.download, color: AppColors.primaryL),
          // // Padding(
          // //   padding: const EdgeInsets.all(15.0),
          // //   child: Image.asset(AppImages.download),
          // // ),
        ],
      ),
      body: NetworkSensitive(
        child: BlocConsumer<OrderDetailsCubit, OrderDetailsState>(
          listener: (context, state) {
            if (state is GetOrderDetailsErrorState) {
              AppSnackBar.showError(state.error);
            }
          },
          builder: (context, state) {
            if (state is GetOrderDetailsLoadingState) {
              return const AppLoading();
            } else if (state is GetOrderDetailsSuccessState) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      CountryInformation(
                        orderId: state.orderModel.id.toString(),
                        fromCity: state.orderModel.scheduledItems.isNotEmpty ? state.orderModel.scheduledItems.first.storeCity.name : "",
                        toCity: state.orderModel.userAddress?.city.name,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      FromAndToInformation(
                        fromDate: state.orderModel.deliveryDate.split(" ")[0],
                        toDate: state.orderModel.deliveryDateTo.split(" ")[0],
                        fromTime: state.orderModel.deliveryDate.split(" ")[1],
                        toTime: state.orderModel.deliveryDateTo.split(" ")[1],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      OrderAddressInformation(address: state.orderModel.userAddress?.address),
                      const SizedBox(
                        height: 15,
                      ),
                      ...state.orderModel.scheduledItems.map(
                        (e) => OrderStoreRequirements(
                          details: e.notes,
                          location: e.storeAddress,
                          expectedPrice: e.subtotal,
                          actualPrice: e.actualPrice.isEmpty ? null : e.actualPrice,
                          receiptImage: e.receipt.isEmpty ? null : e.receipt,
                          rejectReason: e.reason.isEmpty ? null : e.reason,
                          status: e.status.name.isEmpty ? null : e.status.name,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      OrderTotalInformation(
                        deliveryFees: state.orderModel.deliveryCharge,
                        taxFees: state.orderModel.addedTax,
                        totalExpected: state.orderModel.subtotal,
                        total: state.orderModel.total,
                      ),
                      const SizedBox(height: 20),
                      if (state.orderModel.scheduledProcessStatus?.key == "waiting_admin_approval")
                        Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${context.tr.review_order} : ",
                                    style: AppTextStyle.textStyleBoldBlack,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    context.tr.review_order_tip,
                                    style: AppTextStyle.textStyleMediumGray,
                                  ),
                                ],
                              ),
                            )),
                      if (state.orderModel.scheduledProcessStatus?.key == "waiting_client_approval") AcceptOurCancelWidget(orderId: orderId)
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
