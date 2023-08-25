class User {
  int id;
  String username;
  String phone;
  String password;

  User(this.id, this.username, this.phone, this.password);

  Map<String, dynamic> toJson() => {
        'user_id': id.toString(),
        'user_name': username,
        'user_phone': phone,
        'user_password': password,
      };
}
