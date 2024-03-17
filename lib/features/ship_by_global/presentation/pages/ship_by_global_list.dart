import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/features/my_orders/data/models/order.dart';
import 'package:shoplo_client/features/network/presentation/pages/network_sensitive.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../resources/images/images.dart';
import '../../../../resources/styles/app_text_style.dart';
import '../../../../widgets/app_list.dart';
import '../cubit/ship_by_global_list_cubit.dart';

class ShipByGlobalScreenList extends HookWidget {
  const ShipByGlobalScreenList({super.key});
  @override
  Widget build(BuildContext context) {
    //form

    return Builder(builder: (context) {
      return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                context.tr.my_order,
                style: AppTextStyle.textStyleAppBar,
              ),
              elevation: 3,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: AppColors.white,
                // for Android
                statusBarIconBrightness: Brightness.dark,
                // for IOS
                statusBarBrightness: Brightness.light,
              ),
              centerTitle: true,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.all(context.width * .045),
                  child: SvgPicture.asset(
                    AppImages.back,
                    matchTextDirection: true,
                  ),
                ),
              ),
              bottom: TabBar(
                indicatorColor: AppColors.textBlack,
                tabs: <Widget>[
                  Tab(
                    text: context.tr.in_progress,
                  ),
                  Tab(
                    text: context.tr.complete,
                  ),
                  Tab(
                    text: context.tr.rejected,
                  ),
                ],
              ),
            ),
            body: NetworkSensitive(
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TabBarView(
                    children: <Widget>[
                      ...["current", "delivered", "canceled"].map((e) {
                        return ShippingOrderListWidget(e);
                      })
                    ],
                  )),
            ),
          ));
    });
  }
}

class ShippingOrderListWidget extends HookWidget {
  const ShippingOrderListWidget(
    this.status, {
    super.key,
  });
  final String status;
  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive(wantKeepAlive: true);
    return BlocProvider(
      create: (context) => ShipByGlobalListCubit(),
      child: BlocBuilder<ShipByGlobalListCubit, ShipByGlobalListState>(
        builder: (context, state) {
          return AppList(
            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            refresh: true,
            key: const Key('OrderListNew'),
            loadingMoreResults: context.watch<ShipByGlobalListCubit>().loadingMoreResults,
            fetchPageData: (query) => context.read<ShipByGlobalListCubit>().getOrders({
              ...query,
              "status": status,
            }),
            loadingListItems: state is ShipByGlobalListLoadingState,
            hasReachedEndOfResults: context.watch<ShipByGlobalListCubit>().hasReachedEndOfResults,
            endLoadingFirstTime: context.watch<ShipByGlobalListCubit>().endLoadingFirstTime,
            itemBuilder: (context, index) {
              return ShippingOrderCard(
                order: context.watch<ShipByGlobalListCubit>().orders[index],
              );
            },
            listItems: context.watch<ShipByGlobalListCubit>().orders,
          );
        },
      ),
    );
  }
}

class ShippingOrderCard extends StatelessWidget {
  const ShippingOrderCard({
    super.key,
    required this.order,
  });
  final OrderModel order;
  Color color() {
    if (order.status.key == "delivered") {
      return Colors.green;
    } else if (order.status.key == "canceled") {
      return Colors.red;
    } else {
      return const Color(0xffFDBA4C);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.shipByGlobalView, arguments: order.id).then((value) {
            ShipByGlobalListCubit.get(context).getOrders({
              "status": order.status.key,
            });
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("${context.tr.order_id} : "),
                  Text(
                    order.id.toString(),
                  ),
                  const SizedBox(width: 30),
                  Text("${context.tr.order_status} : "),
                  Flexible(
                    flex: 1,
                    child: Text(
                      order.shippingProcessStatus?.name ?? "",
                      style: TextStyle(color: order.shippingProcessStatus?.key == "delivered" ? Colors.green : const Color(0xffFDBA4C)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text("${context.tr.delivery_status} : "),
                  Flexible(
                    flex: 2,
                    child: Text(
                      order.status.name,
                      style: TextStyle(color: color()),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Text("${context.tr.order_date} : "),
                  Flexible(
                    child: Text(
                      order.deliveryDateTo.toString(),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
