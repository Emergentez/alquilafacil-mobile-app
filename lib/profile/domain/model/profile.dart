class Profile {
  final int id;
  late final String name;
  late final String fatherName;
  late final String motherName;
  late final String documentNumber;
  late final String dateOfBirth;
  late final String phoneNumber;
  String bankAccount;
  String interbankAccount;
  Profile({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.fatherName,
    required this.motherName,
    required this.documentNumber,
    required this.dateOfBirth,
    required this.bankAccount,
    required this.interbankAccount,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'fatherName': fatherName,
      'motherName': motherName,
      'phone': phoneNumber,
      'documentNumber': documentNumber,
      'dateOfBirth': dateOfBirth,
      'bankAccount': bankAccount,
      'interbankAccount': interbankAccount,
    };
  }

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      phoneNumber: json['phone'],
      name: json['fullName'].split(" ")[0],
      fatherName: json['fullName'].split(" ")[1],
      motherName: json['fullName'].split(" ")[2],
      documentNumber: json['documentNumber'],
      dateOfBirth: json['dateOfBirth'],
      bankAccount: "",
      interbankAccount: "",
    );
  }
}