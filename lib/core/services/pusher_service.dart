import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:pusher_client/pusher_client.dart';

import '../../features/chat/data/models/message.dart';
import '../../features/chat/presentation/cubit/chat_cubit.dart';
import '../../features/wallet/presentation/cubit/wallet_cubit.dart';

PusherClient pusher = PusherClient(
  "0d25afd538bb0b0066e1",
  PusherOptions(
    cluster: 'eu',
  ),
  autoConnect: false,
);

Future<void> initializeChatPusher(int chatId, context) async {
  try {
// connect at a later time than at instantiation.
    pusher.connect();

    pusher.onConnectionStateChange((state) {
      debugPrint(
          "Pusher ==>  previousState: ${state?.previousState}, currentState: ${state?.currentState}");
    });

    pusher.onConnectionError((error) {
      debugPrint("Pusher ==>  error: ${error?.message}");
    });

// Subscribe to a private channel
    Channel channel = pusher.subscribe("chat");

// Bind to listen for events called "order-status-updated" sent to "private-orders" channel
    channel.bind("chat$chatId", (data) {
      debugPrint("Pusher ==>  data: ${data?.data}");
      Map<String, dynamic> chat = jsonDecode(data?.data! as String);
      debugPrint("Pusher ==>  chat: $chat");
      debugPrint("Pusher ==>  chat1: ${(chat['message'])}");
      ChatCubit cubit = ChatCubit.get(context);
      debugPrint("Pusher ==>  chat2: ${cubit.chatDetails.length}");
      Message message = Message.fromJson(chat['message']);

      debugPrint("Pusher ==>§  message: $message");
      cubit.addNewMessage(message);
    });
  } catch (e) {
    debugPrint("Pusher ==>   ERROR in init pusher: $e");
  }
}

Future<void> initializeWalletPusher(context) async {
  try {
// connect at a later time than at instantiation.
    pusher.connect();

    pusher.onConnectionStateChange((state) {
      debugPrint(
          "Pusher ==>  previousState: ${state?.previousState}, currentState: ${state?.currentState}");
    });

    pusher.onConnectionError((error) {
      debugPrint("Pusher ==>  error: ${error?.message}");
    });

// Subscribe to a private channel
    Channel channel = pusher.subscribe("wallet");

// Bind to listen for events called "order-status-updated" sent to "private-orders" channel
    channel.bind("wallet-change", (data) {
      debugPrint("Pusher ==>  data: ${data?.data}");
      WalletCubit.get(context).getWallet({'page': 1});
    });
  } catch (e) {
    debugPrint("Pusher ==>   ERROR in init pusher: $e");
  }
}

Future<void> initializeOrderPusher(String orderId, context) async {
  try {
// connect at a later time than at instantiation.
    pusher.connect();

    pusher.onConnectionStateChange((state) {
      debugPrint(
          "Pusher ==>  previousState: ${state?.previousState}, currentState: ${state?.currentState}");
    });

    pusher.onConnectionError((error) {
      debugPrint("Pusher ==>  error: ${error?.message}");
    });

// Subscribe to a private channel
    Channel channel = pusher.subscribe("order");

// Bind to listen for events called "order-status-updated" sent to "private-orders" channel
    channel.bind("order$orderId", (data) {
      debugPrint("Pusher ==>  data: ${data?.data}");
    });
  } catch (e) {
    debugPrint("Pusher ==>   ERROR in init pusher: $e");
  }
}

Future<void> onDisconnectPusher() async {
  debugPrint("Pusher ==>   onDisconnectPusher");
  await pusher.unsubscribe('chat');
  await pusher.disconnect();
}

Future<void> onDisconnectWalletPusher() async {
  debugPrint("Pusher ==>   onDisconnectPusher");
  await pusher.unsubscribe('wallet');
  await pusher.disconnect();
}
