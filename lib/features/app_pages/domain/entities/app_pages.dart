import 'package:equatable/equatable.dart';

class AppPagesEntities extends Equatable {
  final String slug;
  final String title;
  final String body;
  final int isStatic;

  const AppPagesEntities({
    required this.slug,
    required this.title,
    required this.body,
    required this.isStatic,
  });

  @override
  List<Object?> get props => [slug, title, body];
}
