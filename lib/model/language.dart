class Language {
  final String id;

  const Language(this.id);

  factory Language.fromJson(String id) {
    return Language(id);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    final Language otherLanguage = other;
    return otherLanguage.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
