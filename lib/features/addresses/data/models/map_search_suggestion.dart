import 'package:equatable/equatable.dart';

class SuggestionPlace extends Equatable {
  final String id;
  final String description;
  final String mainText;
  final String secondaryText;

  const SuggestionPlace({
    required this.id,
    required this.description,
    required this.mainText,
    required this.secondaryText,
  });

  factory SuggestionPlace.fromJson(Map<String, dynamic> json) {
    return SuggestionPlace(
      id: json['place_id'],
      description: json['description'],
      mainText: json['structured_formatting']['main_text'],
      secondaryText: json['structured_formatting']['secondary_text'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
      };

  @override
  String toString() => 'id: $id description: $description';

  @override
  List<Object?> get props => [id, description];
}
