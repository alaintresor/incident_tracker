class User {
  final String id;
  final String email;
  final String firstname;
  final String lastname;
  final String phone;
  final String gender;
  final String accountType;
  final String pictureUrl;

  User({
    required this.id,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.gender,
    required this.accountType,
    required this.pictureUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id']?.toString() ?? '',
      email: json['email'] ?? '',
      firstname: json['firstName'] ?? '',
      lastname: json['lastName'] ?? '',
      phone: json['phone'] ?? '',
      gender: json['gender'] ?? '',
      accountType: json['accountType'] ?? '',
      pictureUrl: json['pictureUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstname': firstname,
      'lastname': lastname,
      'phone': phone,
      'gender': gender,
      'accountType': accountType,
      'pictureUrl': pictureUrl,
    };
  }
} 