class API {
  // static const hostConnect = "http://10.21.0.18:8080/api_fashionshop/"; //Ubuntu localhost
  static const hostConnect =
      "http://192.168.0.107:8080/api_fashionshop"; //Windows localhost
  // static const hostConnect = "http://10.15.54.21:8080/api_fashionshop/"; //Ubuntu localhost

  static const hostConnectUser = "$hostConnect/user";
  static const hostConnectAdmin = "$hostConnect/admin";
  static const hostUploadItem = "$hostConnect/item";
  static const hostUploadCart = "$hostConnect/cart";

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
  static const uploadItem = "$hostUploadItem/upload.php";
  //fetch all Item
  static const fetchAllItem = "$hostUploadItem/fetchdata.php";
  //get trending Item
  static const getTrendingMostPopularItems = "$hostUploadItem/trending.php";

  // fetch user
  static const fetchUserData = "$hostConnectUser/fetchUser.php";

  //insert cart
  static const insertCart = "$hostUploadCart/insertcart.php";
}
