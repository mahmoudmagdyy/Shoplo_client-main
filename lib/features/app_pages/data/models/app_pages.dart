import '../../domain/entities/app_pages.dart';

class AppPagesModel extends AppPagesEntities {
  const AppPagesModel({
    required String slug,
    required String title,
    required String body,
    required int isStatic,
  }) : super(slug: slug, title: title, body: body,isStatic: isStatic);
  factory AppPagesModel.fromJson(Map<String, dynamic> json) {
    return AppPagesModel(
      slug: json['slug'],
      title: json['title'],
      body: json['body'],
      isStatic: json['is_static'],
    );
  }

  Map<String, dynamic> toJson() => {
        'slug': slug,
        'title': title,
        'body': body,
        'is_static':isStatic,
      };

  @override
  String toString() => 'slug: $slug title: $title body: $body';
}
