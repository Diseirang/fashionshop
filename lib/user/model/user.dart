class User{
 int id;
 String username;
 String phone;
 String password;

 User(this.id, this.username, this.phone, this.password);

Map<String, dynamic> toJson() =>{
  'id': id.toString(),
  'username': username,
  'phone': phone,
  'password': password,
};


}
