part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

/// send message
class SendMessageLoadingState extends ChatState {}

class SendMessageSuccessState extends ChatState {
  // final String message;
  const SendMessageSuccessState();
}

class SendMessageErrorState extends ChatState {
  final String error;
  const SendMessageErrorState(this.error);
}

/// get messages
class MessagesLoadingState extends ChatState {}

class MessagesLoadingNextPageState extends ChatState {}

class MessagesSuccessState extends ChatState {
  final List<Message> messages;
  const MessagesSuccessState(this.messages);
}

class MessagesErrorState extends ChatState {
  final String error;
  const MessagesErrorState(this.error);
}

/// get chat details
class ChatDetailsLoadingState extends ChatState {}

class ChatDetailsLoadingNextPageState extends ChatState {}

class ChatDetailsSuccessState extends ChatState {
  final List<Message> chats;
  const ChatDetailsSuccessState(this.chats);
}

class AddChatDetailsSuccessState extends ChatState {
  final List<Message> chats;
  const AddChatDetailsSuccessState(this.chats);
}

class AddChatDetailsSuccessState1 extends ChatState {
  const AddChatDetailsSuccessState1();
}

class ChatDetailsErrorState extends ChatState {
  final String error;
  const ChatDetailsErrorState(this.error);
}
