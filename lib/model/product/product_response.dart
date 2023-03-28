class ProductResponse {
  ProductResponse({
    this.id,
    this.title,
  });

  ProductResponse.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
  }

  num? id;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    return map;
  }
}
