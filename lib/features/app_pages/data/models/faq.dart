import '../../domain/entities/faq.dart';

class FaqModel extends FaqEntities {
  const FaqModel({
    required String question,
    required String answer,
  }) : super(question: question, answer: answer);
  factory FaqModel.fromJson(Map<String, dynamic> json) {
    return FaqModel(
      question: json['question'],
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() => {
        'question': question,
        'answer': answer,
      };

  @override
  String toString() => 'question: $question answer: $answer';
}
