import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/services/pusher_service.dart';
import '../../../../resources/styles/app_text_style.dart';
import '../../../../widgets/app_list.dart';
import '../../../../widgets/shoplo/app_app_bar.dart';
import '../../../network/presentation/pages/network_sensitive.dart';
import '../cubit/chat_cubit.dart';
import '../widgets/chat_input_field.dart';
import '../widgets/message_bubble.dart';

class ChatScreen extends HookWidget {
  final int orderId;
  final String deliveryName;

  const ChatScreen({
    required this.orderId,
    required this.deliveryName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      initializeChatPusher(orderId, context);
      return () {
        onDisconnectPusher();
      };
    }, []);

    return WillPopScope(
      onWillPop: () async {
        debugPrint("Chat onWillPop");
        // NavigationService().setRouteName('routeName');
        // Navigator.of(context).pop('refresh');
        return true;
      },
      child: Scaffold(
        appBar: appAppBar(
          context,
          deliveryName,
        ),
        body: NetworkSensitive(
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<ChatCubit, ChatState>(
                  builder: (context, state) {
                    ChatCubit cubit = ChatCubit.get(context);
                    if (state is ChatDetailsErrorState) {
                      return Center(
                          child: Text(
                        state.error,
                        style: AppTextStyle.textStyleMediumAppBlack,
                      ));
                    }
                    return AppList(
                      reverse: true,
                      key: const Key('chatDetailsList'),
                      fetchPageData: (query) =>
                          {cubit.getChats(query, orderId)},
                      loadingListItems: state is ChatDetailsLoadingState,
                      hasReachedEndOfResults: cubit.hasReachedEndOfResultsChat,
                      endLoadingFirstTime: cubit.endLoadingFirstTimeChat,
                      loadingMoreResults: cubit.loadingMoreResultsChat,
                      itemBuilder: (context, index) => MessageBubble(
                        message: cubit.chatDetails[index],
                      ),
                      listItems: cubit.chatDetails,
                    );
                  },
                ),
              ),
              if (context.watch<ChatCubit>().activeChat)
                ChatInputField(orderId: orderId),
            ],
          ),
        ),
      ),
    );
  }
}
