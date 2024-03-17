import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../widgets/app_list.dart';
import '../../../../widgets/shoplo/app_app_bar.dart';
import '../../../network/presentation/pages/network_sensitive.dart';
import '../cubit/notifications_count_cubit.dart';
import '../cubit/notifications_cubit.dart';
import '../widgets/notification_card.dart';

enum Menu { itemOne, itemTwo, itemThree, itemFour }

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String selectedMenu = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationsCubit(),
      child: Scaffold(
        appBar: appAppBar(
          context,
          context.tr.notification,
          actions: [
            Theme(
              data: Theme.of(context).copyWith(
                cardColor: Colors.white,
                iconTheme: const IconThemeData(
                  color: Colors.black,
                ),
              ),
              child: PopupMenuButton<Menu>(
                onSelected: (Menu item) {
                  setState(() {
                    selectedMenu = item.name;
                  });
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                  PopupMenuItem<Menu>(
                    value: Menu.itemOne,
                    child: Text(context.tr.mark_all_read),
                    onTap: () {
                      NotificationsCubit.get(context).getNotifications({"is_read": "1"});
                      NotificationsCountCubit.get(context).getNotificationsCount();
                    },
                  ),
                  // PopupMenuItem<Menu>(
                  //   value: Menu.itemTwo,
                  //   child: Text(context.tr.remove_all),
                  // ),
                ],
              ),
            ),
          ],
        ),
        body: NetworkSensitive(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(color: AppColors.backgroundGrey, borderRadius: BorderRadius.circular(10)),
            child: BlocBuilder<NotificationsCubit, NotificationsState>(
              builder: (context, state) {
                NotificationsCubit cubit = NotificationsCubit.get(context);
                return AppList(
                  key: const Key('NotificationsList'),
                  loadingMoreResults: cubit.loadingMoreResults,
                  fetchPageData: (query) => cubit.getNotifications(query),
                  loadingListItems: state is NotificationsLoadingState,
                  hasReachedEndOfResults: cubit.hasReachedEndOfResults,
                  endLoadingFirstTime: cubit.endLoadingFirstTime,
                  itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        if (cubit.notifications[index].data.type == "delivery" || cubit.notifications[index].data.type == "order") {
                          if (cubit.notifications[index].data.orderType == "shipping") {
                            Navigator.of(context).pushNamed(
                              AppRoutes.shipByGlobalView,
                              arguments: cubit.notifications[index].data.modelId,
                            );
                          } else {
                            Navigator.of(context).pushNamed(AppRoutes.orderDetails, arguments: {
                              "orderId": cubit.notifications[index].data.modelId,
                              "requestId": 0,
                            });
                          }
                        }
                        if (cubit.notifications[index].data.type == "chat") {
                          // MessageEntity message =  cubit.notifications[index].message;
                          Navigator.of(context).pushNamed(
                            AppRoutes.chatScreen,
                            arguments: {
                              "orderId": cubit.notifications[index].data.modelId,
                              "deliveryName": cubit.notifications[index].data.senderName,
                            },
                          );
                        }
                      },
                      child: NotificationCard(notificationModel: cubit.notifications[index])),
                  listItems: cubit.notifications,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
