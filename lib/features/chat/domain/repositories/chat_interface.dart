import '../../../../core/core_model/app_response.dart';

abstract class ChatInterface {
  Future<AppResponse> sendMessage(Map<String, dynamic> values);
  Future<AppResponse> getMessages(Map<String, dynamic> query);
  Future<AppResponse> getChat(Map<String, dynamic> query, String id);
}
