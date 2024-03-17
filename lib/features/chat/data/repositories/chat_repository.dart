import '../../../../core/core_model/app_response.dart';
import '../../domain/repositories/chat_interface.dart';
import '../data_sources/chat_data_provider.dart';

class ChatRepository implements ChatInterface {
  final ChatDataProvider chatDataProvider;
  const ChatRepository(this.chatDataProvider);

  @override
  Future<AppResponse> getChat(Map<String, dynamic> query, String id) {
    return chatDataProvider.getChat(query, id);
  }

  @override
  Future<AppResponse> getMessages(Map<String, dynamic> query) {
    return chatDataProvider.getMessages(query);
  }

  @override
  Future<AppResponse> sendMessage(Map<String, dynamic> values) {
    return chatDataProvider.sendMessage(values);
  }
}
