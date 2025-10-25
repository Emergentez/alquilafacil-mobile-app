class LocalCategory {
  final int id;
  final String name;
  final String photoUrl;

  LocalCategory({
    required this.id,
    required this.name,
    required this.photoUrl,
  });

  factory LocalCategory.fromJson(Map<String, dynamic> json) {
    return LocalCategory(
      id: json['id'],
      name: json['name'],
      photoUrl: json['photoUrl'],
    );
  }
}