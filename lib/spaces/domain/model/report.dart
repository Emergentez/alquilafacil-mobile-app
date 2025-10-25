class Report {
  int id;
  int localId;
  String title;
  int userId;
  String description;

  Report({
    required this.id,
    required this.localId,
    required this.title,
    required this.userId,
    required this.description
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
        id: json["id"],
        localId  : json["localId"],
        title: json["title"],
        userId: json["userId"],
        description:  json["description"]
    );
  }

  Map<String, dynamic> toJson() {

    return {
      "localId": localId,
      "title": title,
      "userId": userId,
      "description": description
    };
  }
}