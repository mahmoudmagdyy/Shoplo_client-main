import 'package:equatable/equatable.dart';

class FaqEntities extends Equatable {
  final String question;
  final String answer;

  const FaqEntities({
    required this.question,
    required this.answer,
  });

  @override
  List<Object?> get props => [question, answer];
}
