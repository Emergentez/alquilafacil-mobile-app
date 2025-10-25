class Comment {
  final int id;
  late int authorId;
  late final int spaceId;
  final String text;
  final int rating;
  String authorName;

  Comment({
    required this.id,
    required this.authorId,
    required this.spaceId,
    required this.text,
    required this.rating,
    this.authorName = ""
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      authorId: json['userId'],
      spaceId: json['localId'],
      text: json['text'],
      rating: json['rating'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': authorId,
      'localId': spaceId,
      'text': text,
      'rating': rating,
    };
  }
}