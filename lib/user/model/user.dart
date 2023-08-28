class User {
  int userid;
  String username;
  String phone;
  String password;

  User(this.userid, this.username, this.phone, this.password);

  factory User.fromJson(Map<String, dynamic> json) => User(
        int.parse(json['user_id']),
        json['user_name'],
        json['user_phone'],
        json['user_password'],
      );

  Map<String, dynamic> toJson() => {
        'user_id': userid.toString(),
        'user_name': username,
        'user_phone': phone,
        'user_password': password,
      };
}
