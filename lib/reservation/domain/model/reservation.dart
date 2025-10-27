class Reservation {
  final int id;
  final int userId;
  final int spaceId;
  final DateTime startDate;
  final DateTime endDate;
  final String voucherImageUrl;
  bool? isSubscribed;

  Reservation({
    required this.id,
    required this.userId,
    required this.spaceId,
    required this.startDate,
    required this.endDate,
    this.voucherImageUrl = "",
    this.isSubscribed,
  });

  // Método para crear un objeto Reservation desde un JSON
  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'] as int,
      userId: json['userId'] as int,
      spaceId: json['localId'] as int,
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate'])
    );
  }

  factory Reservation.fromJsonfromOtherUsers(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'] as int,
      userId: json['userId'] as int,
      spaceId: json['localId'] as int,
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      voucherImageUrl: json['voucherImageUrl'] as String,
      isSubscribed: json['isSubscribe'] as bool,
    );
  }

  // Método para convertir un objeto Reservation a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'localId': spaceId,
      'startDate': startDate,
      'endDate': endDate,
      'voucherImageUrl': voucherImageUrl,
    };
  }
}