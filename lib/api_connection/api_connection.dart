class API {
  // static const hostConnect = "http://10.21.0.18:8080/api_fashionshop/"; //Ubuntu localhost
  static const hostConnect = "http://192.168.0.109:8080/api_fashionshop";  //Windows localhost

  static const hostConnectUser = "$hostConnect/user";
  static const hostConnectAdmin = "$hostConnect/admin";

  //signup user
  static const signUp = "$hostConnectUser/signup.php";
  
  //login user
  static const userlogin = "$hostConnectUser/login.php";

  // validate data
  static const validateUsername = "$hostConnect/user/validate_username.php";
  static const validatePassword = "$hostConnect/user/validate_password.php";
  static const validatePhone = "$hostConnect/user/validate_phone.php";


  //login admin
  static const adminlogin = "$hostConnectAdmin/login.php";

  //upload Item
  static const uploadItem = "$hostConnect/item/upload.php";

}
