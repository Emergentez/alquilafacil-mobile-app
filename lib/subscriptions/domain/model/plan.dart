class Plan {
  int id;
  String name;
  String service;
  int price;

  Plan({
    required this.id,
    required this.name,
    required this.service,
    required this.price
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
        id : json['id'],
        name : json['name'],
        service : json['service'],
        price : json['price']
    );
  }
}
