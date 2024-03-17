// import 'dart:io';
// import 'dart:math';
//
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
//
// import '../../features/notification/presentation/cubit/notifications_count_cubit.dart';
// import '../../widgets/alert_dialogs/custom_alert_dialog.dart';
// import '../extensions/extensions_on_context.dart';
// import '../routes/app_routes.dart';
// import 'navigation_service.dart';
//
// Future<void> initializePushNotificationService(context) async {
//   initializeFirebaseService(context);
//
//   AwesomeNotifications()
//       .actionStream
//       .listen((ReceivedNotification notification) {
//     NotificationsCountCubit.get(context).getNotificationsCount();
//     debugPrint('NOTIFICATION::::::::First $notification}', wrapWidth: 1024);
//
//     debugPrint('NOTIFICATION:::::::secend ${notification.toString()}',
//         wrapWidth: 1024);
//     if (notification.channelKey == 'basic_channel' && Platform.isIOS) {
//       AwesomeNotifications().getGlobalBadgeCounter().then(
//             (value) => AwesomeNotifications().setGlobalBadgeCounter(value - 1),
//           );
//     }
//     debugPrint('notification =========== ----: ${notification.payload}',
//         wrapWidth: 1024);
//
//     if (notification.payload!['type'] == "order") {
//       Navigator.of(context).pushNamed(AppRoutes.orderDetails, arguments: {
//         "orderId": int.parse(notification.payload!['model_id']!),
//         "requestId": 0,
//       });
//     }
//     if (notification.payload!['type'] == "chat") {
//       // MessageEntity message =  cubit.notifications[index].message;
//       Navigator.of(context).pushNamed(
//         AppRoutes.chatScreen,
//         arguments: {
//           "orderId": int.parse(notification.payload!['model_id']!),
//           "deliveryName": notification.payload!['sender_name'],
//         },
//       );
//     } else if (notification.payload!['type'] == 'dashboard') {
//       Navigator.of(NavigationService.navigatorKey.currentContext!).pushNamed(
//         AppRoutes.login,
//       );
//     }
//
//     // if (notification.payload!['type'] == 'order') {
//     //   // Navigator.of(NavigationService.navigatorKey.currentContext!).pushNamed(
//     //   //   AppRoutes.tourDetails,
//     //   //   arguments: notification.payload!['model_id'],
//     //   // );
//     // } else if (notification.payload!['type'] == 'order_request') {
//     //   // debugPrint('notification ===== 1----:');
//     //   // ChatCubit cubit = ChatCubit.get(context);
//     //   // cubit.chatDetails.insertAll(0, [
//     //   //   Message.fromJson(
//     //   //       jsonDecode(notification.payload!['chat_object'] as String))
//     //   // ]);
//     //   // debugPrint('notification ===== 2----:');
//     //
//     //   // Navigator.of(NavigationService.navigatorKey.currentContext!).pushNamed(
//     //   //   AppRoutes.chatScreen,
//     //   //   arguments: Message.fromJson(
//     //   //       jsonDecode(notification.payload!['chat_object'] as String)),
//     //   // );
//     // } else if (notification.payload!['type'] == 'dashboard') {
//     //   Navigator.of(NavigationService.navigatorKey.currentContext!).pushNamed(
//     //     AppRoutes.login,
//     //   );
//     // }
//   });
//
//   AwesomeNotifications().isNotificationAllowed().then((isAllowed) async {
//     if (!isAllowed) {
//       isAllowed = await requestPermissionToSendNotifications(context);
//     }
//   });
// }
//
// // Platform messages are asynchronous, so we initialize in an async method.
// Future<void> initializeFirebaseService(BuildContext context) async {
//   debugPrint('========= inint firebase notification', wrapWidth: 1024);
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     debugPrint(
//         'onMessage: =================================================================',
//         wrapWidth: 1024);
//     debugPrint('Got a message whilst in the foreground!');
//     debugPrint('++ ++ Message : $message');
//
//     debugPrint('Message data: ${message.data}');
//     NotificationsCountCubit cubit = NotificationsCountCubit.get(
//         NavigationService.navigatorKey.currentContext!);
//     final String type = message.data['type'];
//     debugPrint('TYPE: $type', wrapWidth: 1024);
//     cubit.getNotificationsCount();
//     if (Platform.isIOS) {
//       debugPrint('Platform.isIOS', wrapWidth: 1024);
//     } else {
//       if (
//
//         //   AwesomeStringUtils.isNullOrEmpty(message.notification?.title,
//         //           considerWhiteSpaceAsEmpty: true) ||
//         //       !AwesomeStringUtils.isNullOrEmpty(message.notification?.body,
//         //           considerWhiteSpaceAsEmpty: true)) {
//         // debugPrint(
//         //     'Message also contained a notification: ${message.notification}');
//
//         // String? imageUrl;
//         // imageUrl ??= message.notification!.android?.imageUrl;
//         // imageUrl ??= message.notification!.apple?.imageUrl;
//
//
//         // Map<String, dynamic> notificationAdapter = {
//         //   NOTIFICATION_CONTENT: {
//         //     NOTIFICATION_ID: Random().nextInt(2147483647),
//         //     NOTIFICATION_CHANNEL_KEY: 'basic_channel',
//         //     NOTIFICATION_TITLE: message.notification!.title,
//         //     NOTIFICATION_BODY: message.notification!.body,
//         //     NOTIFICATION_PAYLOAD: message.data,
//         //     NOTIFICATION_LAYOUT: AwesomeStringUtils.isNullOrEmpty(imageUrl)
//         //         ? 'Default'
//         //         : 'BigPicture',
//         //     NOTIFICATION_BIG_PICTURE: imageUrl
//         //   }
//         // };
//         if (type == 'chat') {
//           debugPrint('+++++ 1');
//           if (NavigationService.routeName == AppRoutes.chatScreen) {
//             debugPrint('+++++ 2');
//             // ChatCubit cubit = ChatCubit.get(context);
//             // cubit.addNewMessage(Message.fromJson(
//             //     jsonDecode(message.data['chat_object'] as String)));
//           } else {
//             debugPrint('+++++ 3');
//             AwesomeNotifications()
//                 .createNotificationFromJsonData(notificationAdapter);
//           }
//         } else {
//           debugPrint('+++++ 4');
//           AwesomeNotifications()
//               .createNotificationFromJsonData(notificationAdapter);
//         }
//       } else {
//         if (type == 'chat') {
//           debugPrint('++++++= 1');
//           if (NavigationService.routeName == AppRoutes.chatScreen) {
//             debugPrint('++++++= 2');
//             // ChatCubit cubit = ChatCubit.get(context);
//             // cubit.addNewMessage(Message.fromJson(
//             //     jsonDecode(message.data['chat_object'] as String)));
//           } else {
//             debugPrint('++++++= 3');
//             AwesomeNotifications().createNotificationFromJsonData(message.data);
//           }
//         } else {
//           debugPrint('++++++= 4');
//           AwesomeNotifications().createNotificationFromJsonData(message.data);
//         }
//       }
//     }
//   });
//
//   // Get any messages which caused the application to open from
//   // a terminated state.
//   RemoteMessage? initialMessage =
//       await FirebaseMessaging.instance.getInitialMessage();
//
//   // If the message also contains a data property with a "type" of "chat",
//   // navigate to a chat screen
//   if (initialMessage != null) {
//     debugPrint('**************************** INITIAL MESSAGE: $initialMessage}',
//         wrapWidth: 1024);
//     handleMessage(initialMessage);
//   }
//
//   // Also handle any interaction when the app is in the background via a
//   // Stream listener
//   FirebaseMessaging.onMessageOpenedApp
//       .listen((RemoteMessage message) => handleMessage(message));
// }
//
// void handleMessage(RemoteMessage message) {
//   debugPrint('========= handleMessage : $message}', wrapWidth: 1024);
//   debugPrint('========= handleMessage : ${message.data}', wrapWidth: 1024);
//
//   if (message.data['type'] == "order") {
//     Navigator.of(NavigationService.navigatorKey.currentContext!)
//         .pushNamed(AppRoutes.orderDetails, arguments: {
//       "orderId": int.parse(message.data['model_id']),
//       "requestId": 0,
//     });
//   }
//   if (message.data['type'] == "chat") {
//     // MessageEntity message =  cubit.notifications[index].message;
//     Navigator.of(NavigationService.navigatorKey.currentContext!).pushNamed(
//       AppRoutes.chatScreen,
//       arguments: {
//         "orderId": int.parse(message.data['model_id']),
//         "deliveryName": message.data['sender_name'],
//       },
//     );
//   } else if (message.data['type'] == 'dashboard') {
//     Navigator.of(NavigationService.navigatorKey.currentContext!).pushNamed(
//       AppRoutes.login,
//     );
//   }
//
//   // if (message.data['type'] == 'tour_request') {
//   //   // Navigator.of(NavigationService.navigatorKey.currentContext!).pushNamed(
//   //   //   AppRoutes.tourDetails,
//   //   //   arguments: message.data['model_id'],
//   //   // );
//   // } else if (message.data['type'] == 'chat') {
//   //   // Navigator.of(NavigationService.navigatorKey.currentContext!).pushNamed(
//   //   //   AppRoutes.chatScreen,
//   //   //   arguments:
//   //   //       Message.fromJson(jsonDecode(message.data['chat_object'] as String)),
//   //   // );
//   // } else if (message.data['type'] == 'dashboard') {
//   //   Navigator.of(NavigationService.navigatorKey.currentContext!).pushNamed(
//   //     AppRoutes.login,
//   //   );
//   // }
// }
//
// Future<bool> requestPermissionToSendNotifications(BuildContext context) async {
//   bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
//   if (!isAllowed) {
//     await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return CustomDialogBox(
//           title: context.tr.allow_notifications,
//           onPressedYes: () async {
//             isAllowed = await AwesomeNotifications()
//                 .requestPermissionToSendNotifications();
//             Navigator.pop(context, 'Ok');
//           },
//         );
//       },
//     );
//   }
//   return isAllowed;
// }
