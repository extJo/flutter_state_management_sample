class Language {
  final String id;
  final String name;

  const Language({this.id, this.name});

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(id: json['urlParam'], name: json['name']);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other))
      return true;
    if (other.runtimeType != runtimeType)
      return false;
    final Language otherLanguage = other;
    return otherLanguage.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
