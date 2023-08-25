class API {
  // static const hostConnect = "http://10.21.0.18:8080/api_fashionshop/";
  static const hostConnect = "http://192.168.0.109:80/api_fashionshop";

  static const hostConnectUser = "$hostConnect/user";

  //signup user

  static const signUp = "$hostConnect/user/signup.php";

  //login user

  static const login = "$hostConnect/user/login.php";

  // validate data

  static const validateUsername = "$hostConnect/user/validate_username.php";
  static const validatePassword = "$hostConnect/user/validate_password.php";
  static const validatePhone = "$hostConnect/user/validate_phone.php";
}
