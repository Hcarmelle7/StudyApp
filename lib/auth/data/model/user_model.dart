class UserModel {
  final int? id;
  final String email;
  final String firstname;
  final String lastname;
  final String phone;
  DateTime? birthday;
  final String? profilePicture;
  // final String? country;
  final String? password;
  final String? roles;

  UserModel({
    this.id,
    this.profilePicture,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.phone,
    this.birthday,

    // required this.country,
    required this.password,
    required this.roles,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      phone: json['phone'],
      email: json['email'],
      birthday: DateTime.parse(json['birthday']),
      profilePicture: json['profilePicture'],

      // country: json['country'],
      password: json['password'],
      roles: json['roles'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstname': firstname,
      'lastname': lastname,
      'phone': phone,
      'birthday': birthday?.toIso8601String(),
      'profilePicture': profilePicture,
      // 'country': country,
      'password': password,
      'roles': roles,
    };
  }
}
