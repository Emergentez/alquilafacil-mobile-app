class Subscription {
  final int? id;
  final int planId;
  final int userId;
  final voucherImageUrl;

  Subscription({
    this.id,
    required this.planId,
    required this.userId,
    required this.voucherImageUrl,
  });

  Map<String, dynamic> toJson(){
    return {
      "planId": planId,
      "userId": userId,
      "voucherImageUrl": voucherImageUrl
    };
  }

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'],
      planId: json['planId'],
      userId: json['userId'],
      voucherImageUrl: json['voucherImageUrl'],
    );
  }
}
