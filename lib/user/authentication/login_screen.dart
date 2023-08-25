import 'dart:convert';

import 'package:fashionshop/api_connection/api_connection.dart';
import 'package:fashionshop/user/userPrefereences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/user.dart';
import '../fragments/dashboard_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var isObsecure = true.obs;

  loginUser() async {
    try {
      var resUserData = await http.post(
        Uri.parse(API.login),
        body: {
          'user_phone': phoneController.text.trim(),
          'user_password': phoneController.text.trim(),
        },
      );

      if (resUserData.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(resUserData.body);

        if (resBodyOfLogin['login'] == true) {
          Fluttertoast.showToast(msg: 'Login successfully.\n Have a nice day!');

          User userInfo = User.fromJson(resBodyOfLogin['userData']);

          await RememberUserPrefs.storeUserInfo(userInfo);

          setState(() {
            //clear text field
            phoneController.clear();
            passwordController.clear();
          });

          Future.delayed(const Duration(milliseconds: 1000), () {
            Get.to(DashboardScreen());
          });
        } else {
          Fluttertoast.showToast(
              msg: 'Invalid phone number or password. Try Again.');
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // login screen header
                  SizedBox(
                    height: 285,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset('assets/Login.jpg'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 8,
                              color: Colors.black87,
                              offset: Offset(5, 5),
                            ),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
                        child: Column(
                          children: [
                            Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  //phone
                                  TextFormField(
                                    keyboardType: TextInputType.phone,
                                    controller: phoneController,
                                    validator: (value) => value == ""
                                        ? "Please enter your phone number"
                                        : null,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.phone,
                                        color: Colors.blue,
                                      ),
                                      hintText: 'Phone Number',
                                      hintStyle:
                                          const TextStyle(color: Colors.blue),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          25,
                                        ),
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          25,
                                        ),
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          25,
                                        ),
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          25,
                                        ),
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 6),
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  // password
                                  Obx(
                                    () => TextFormField(
                                    keyboardType: TextInputType.text,

                                      obscureText: isObsecure.value,
                                      controller: passwordController,
                                      validator: (value) => value == ""
                                          ? "Please enter your password"
                                          : null,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.vpn_key_sharp,
                                          color: Colors.blue,
                                        ),
                                        suffixIcon: Obx(
                                          () => GestureDetector(
                                            onTap: () {
                                              isObsecure.value =
                                                  !isObsecure.value;
                                            },
                                            child: Icon(
                                              isObsecure.value
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        hintText: 'Password',
                                        hintStyle:
                                            const TextStyle(color: Colors.blue),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            25,
                                          ),
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            25,
                                          ),
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            25,
                                          ),
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            25,
                                          ),
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 6),
                                        fillColor: Colors.white,
                                        filled: true,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  //button
                                  Material(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(25),
                                    child: InkWell(
                                      onTap: () {
                                        if (formKey.currentState!.validate()) {
                                          loginUser();
                                        }
                                      },
                                      borderRadius: BorderRadius.circular(25),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 10,
                                        ),
                                        child: Text(
                                          'Login',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Don't have an account?"),
                                TextButton(
                                  onPressed: () {
                                    Get.to(const SignupScreen());
                                  },
                                  child: const Text(
                                    'Register Here',
                                    style: TextStyle(
                                      color: Colors.purpleAccent,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // const Text(
                            //   'OR',
                            //   style: TextStyle(color: Colors.white),
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     const Text("Are you admin?"),
                            //     TextButton(
                            //       onPressed: () {},
                            //       child: const Text(
                            //         'Click Here',
                            //         style: TextStyle(
                            //           color: Colors.purpleAccent,
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
