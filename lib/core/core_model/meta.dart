class Meta {
  Meta({
    this.path,
    this.currentPage,
    this.from,
    this.perPage,
    this.to,
    this.total,
    this.lastPage,
  });

  String? path;
  int? currentPage;
  int? from;
  int? perPage;
  int? to;
  int? total;
  int? lastPage;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    path: json["path"],
    currentPage: json["current_page"],
    from: json["from"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
    lastPage: json["last_page"],
  );

  Map<String, dynamic> toJson() => {
    "path": path,
    "current_page": currentPage,
    "from": from,
    "per_page": perPage,
    "to": to,
    "total": total,
    "last_page": lastPage,
  };
}