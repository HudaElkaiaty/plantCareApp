class UserModel {
  final String id;
  final String password;
  final String email;

  UserModel({required this.id, required this.email, required this.password});
  Map<String, dynamic> toMap() {
    return {'id': id, 'email': email, 'password': password};
  }

  //from json
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      password: map['password'],
      email: map['email'],
    );
  }
}
