import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/injection.dart';
import '../../data/models/message.dart';
import '../../data/repositories/chat_repository.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  static ChatCubit get(context) => BlocProvider.of(context);

  final repository = serviceLocator.get<ChatRepository>();

  void sendMessage(values) {
    debugPrint("🚀 ~ file:  ~ values");
    debugPrint('VALUES: $values}', wrapWidth: 1024);
    emit(SendMessageLoadingState());
    repository.sendMessage(values).then(
      (value) {
        if (value.errorMessages != null) {
          emit(SendMessageErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(SendMessageErrorState(value.errors!));
        } else {
          emit(const SendMessageSuccessState());
        }
      },
    );
  }

  final List<Message> messages = [];
  bool hasReachedEndOfResults = false;
  bool endLoadingFirstTime = false;
  bool loadingMoreResults = false;
  Map<String, dynamic> query = {
    'page': 1,
    'per_page': 10,
  };

  bool activeChat = true;
  final List<Message> chatDetails = [];
  bool hasReachedEndOfResultsChat = false;
  bool endLoadingFirstTimeChat = false;
  bool loadingMoreResultsChat = false;
  Map<String, dynamic> queryChat = {
    'page': 1,
    'per_page': 10,
  };

  /// getMessages
  void getMessages(Map<String, dynamic> queryData) async {
    debugPrint('QUERY DATA: $queryData}', wrapWidth: 1024);
    if (queryData.isNotEmpty && queryData['loadMore'] != true) {
      query.clear();
      query['page'] = 1;
      query['per_page'] = 10;
      query.addAll(queryData);
    }
    if (!endLoadingFirstTime) {
      messages.clear();
    }

    if (query['page'] == 1) {
      emit(MessagesLoadingState());
    } else {
      loadingMoreResults = true;
      emit(MessagesLoadingNextPageState());
    }
    // repository.getMessages(query).then(
    //   (value) {
    //     loadingMoreResults = false;
    //     if (value.errorMessages != null) {
    //       emit(MessagesErrorState(value.errorMessages!));
    //     } else {
    //       endLoadingFirstTime = true;
    //       List<Message> messages = [];
    //       value.data.forEach((item) {
    //         messages.add(Message.fromJson(item));
    //       });

    //       debugPrint('_messages ${messages.length}');
    //       if (query['page'] != 1) {
    //         debugPrint('----- lode more ');
    //         messages.addAll(messages);
    //       } else {
    //         messages.clear();
    //         messages.addAll(messages);
    //       }
    //       // if (messages.length == value.meta['total']) {
    //       //   debugPrint('============== done request');
    //       //   hasReachedEndOfResults = true;
    //       // } else if (messages.length < value.meta['total']) {
    //       //   hasReachedEndOfResults = false;
    //       // }
    //       // debugPrint('Messages ${messages.length}');
    //       // if (query['page'] < value.meta['last_page']) {
    //       //   debugPrint('load more 2222 page ++ ');
    //       //   query['page'] += 1;
    //       // } else {
    //       //   query['page'] = 1;
    //       // }

    //       emit(MessagesSuccessState(messages));
    //     }
    //   },
    // );
  }

  /// get chats
  void getChats(Map<String, dynamic> queryData, id) async {
    debugPrint('QUERY DATA: $queryData}', wrapWidth: 1024);
    if (queryData['loadMore'] != true) {
      queryChat.clear();
      chatDetails.clear();
      queryChat['page'] = 1;
      queryChat['per_page'] = 10;
      queryChat.addAll(queryData);
    }
    if (!endLoadingFirstTimeChat) {
      chatDetails.clear();
    }

    emit(ChatDetailsLoadingState());
    // if (queryChat['page'] == 1) {
    //   chatDetails.clear();
    //   emit(ChatDetailsLoadingState());
    // } else {
    //   loadingMoreResultsChat = true;
    //   emit(ChatDetailsLoadingNextPageState());
    // }

    debugPrint('QUERY CHAT: $queryChat', wrapWidth: 1024);
    repository.getChat(queryChat, id.toString()).then(
      (value) {
        debugPrint('VALUE xxxxx: $value', wrapWidth: 1024);
        loadingMoreResultsChat = false;
        if (value.errorMessages != null) {
          emit(ChatDetailsErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(ChatDetailsErrorState(value.errors!));
        } else {
          endLoadingFirstTimeChat = true;
          List<Message> chatDetails1 = [];
          value.data['messages'].forEach((item) {
            chatDetails1.add(Message.fromJson(item));
          });
          activeChat = value.data['is_active'];
          debugPrint('_chatDetails ${chatDetails1.length}');
          // debugPrint('QUERY CHAT 22222: $queryChat', wrapWidth: 1024);
          chatDetails.clear();
          chatDetails.addAll(chatDetails1);
          // if (queryChat['page'] != 1) {
          //   debugPrint('----- lode more ');
          //   chatDetails.addAll(chatDetails);
          // } else {
          // chatDetails.clear();
          // chatDetails.addAll(chatDetails);
          // }
          // hasReachedEndOfResultsChat = true;
          // if (chatDetails.length == value.meta['total']) {
          //   debugPrint('============== done request');
          //   hasReachedEndOfResultsChat = true;
          // } else if (chatDetails.length < value.meta['total']) {
          //   hasReachedEndOfResultsChat = false;
          // }
          // debugPrint('chatDetails ${chatDetails.length}');
          // if (queryChat['page'] < value.meta['last_page']) {
          //   debugPrint('load more 2222 page ++ ');
          //   queryChat['page'] += 1;
          // } else {
          //   queryChat['page'] = 1;
          // }

          emit(ChatDetailsSuccessState(chatDetails));
        }
      },
    );
  }

  void addNewMessage(Message message) {
    debugPrint('xxxxxxx: $message', wrapWidth: 1024);
    chatDetails.insertAll(0, [message]);
    emit(const AddChatDetailsSuccessState1());
  }
}
