class Language {
  final String id;
  final String name;

  const Language({this.id, this.name});

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(id: json['urlParam'], name: json['name']);
  }
}
