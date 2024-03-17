import 'package:flutter/material.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/features/notification/data/models/notification_model.dart';

import '../../../../resources/styles/app_text_style.dart';
import '../../../../widgets/app_image.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notificationModel;
  const NotificationCard({Key? key, required this.notificationModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: context.width * .5,
                      child: Text(
                        notificationModel.data.title,
                        style: AppTextStyle.textStyleRegularGold,
                      ),
                    ),
                  ],
                ),
                Text(
                  notificationModel.createdAt,
                  style: AppTextStyle.textStyleRegularGray,
                )
              ],
            ),
            Row(
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: context.width * .75,
                      child: notificationModel.data.body.contains('https://')
                          ? AppImage(
                              imageURL: notificationModel.data.body,
                              height: 150,
                            )
                          : Text(
                              notificationModel.data.body,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyle.textStyleRegularGray,
                            ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
