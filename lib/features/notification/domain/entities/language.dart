class Lang {
  Lang({
    required this.title,
    required this.body,
  });

  final String title;
  final String body;

  factory Lang.fromJson(Map<String, dynamic> json) => Lang(
    title: json["title"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "body": body,
  };
}