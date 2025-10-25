class Space {
  final int id;
  final String localName;
  final String descriptionMessage;
  final String address;
  final String country;
  final String city;
  final String district;
  final String street;
  final int capacity;
  final double price;
  final List<String> photoUrls;
  final String features;
  final int localCategoryId;
  int? userId;

  Space({
    required this.id,
    required this.localName,
    required this.descriptionMessage,
    this.address = ' ',
    this.country = ' ',
    this.city = ' ',
    this.district = ' ',
    this.street = ' ',
    required this.capacity,
    required this.price,
    required this.photoUrls,
    required this.features,
    required this.localCategoryId,
    required this.userId,
  });

  factory Space.fromJson(Map<String, dynamic> json) {
    return Space(
      id: json['id'],
      localName: json['localName'],
      descriptionMessage: json['descriptionMessage'],
      address: json['address'],
      capacity: json['capacity'],
      price: json['price'].toDouble(),
      photoUrls: List<String>.from(json['photoUrls']),
      features: json['features'],
      localCategoryId: json['localCategoryId'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'localName': localName,
      'descriptionMessage': descriptionMessage,
      'country': country,
      'city': city,
      'district': district,
      'street': street,
      'price': price.toInt(),
      'capacity': capacity,
      'photoUrls': photoUrls,
      'features': features,
      'localCategoryId': localCategoryId,
      'userId': userId,
    };
  }

  factory Space.fromMap(Map<String, dynamic>map ) {
    return Space(
      id: map['id'],
      localName: map['localName'],
      descriptionMessage: map['descriptionMessage'],
      address: map['address'],
      price: map['price'].toDouble(),
      capacity: map['capacity'],
      photoUrls: List<String>.from(map['photoUrls']),
      features: map['features'],
      localCategoryId: map['localCategoryId'],
      userId: map['userId']
    );
  }
}