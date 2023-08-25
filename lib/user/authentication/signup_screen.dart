import 'dart:convert';

import 'package:fashionshop/api_connection/api_connection.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/user.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var formKey = GlobalKey<FormState>();
  var userNameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var isObsecure = true.obs;

  validatePhoneNumber() async {
    try {
      var res = await http.post(
        Uri.parse(API.validatePhone),
        body: {
          'user_phone': phoneController.text.trim().toString(),
        },
      );
      if (res.statusCode == 200) {
        var resBodyOfValidatePhone = jsonDecode(res.body);

        if (resBodyOfValidatePhone['phoneFound'] == true) {
          Fluttertoast.showToast(
              msg: 'This phone number is use by someone. Try another one!');
        } else {
          registeredAndSavedUserRevord();
          // Fluttertoast.showToast(msg: 'Your acount is created successfully!');
        }
      }
    } catch (e) {
      //print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  registeredAndSavedUserRevord() async {
    User userModel = User(
      1,
      userNameController.text,
      phoneController.text,
      passwordController.text,
    );
    try {
      var res = await http.post(
        Uri.parse(API.signUp),
        body: userModel.toJson(),
      );

      if (res.statusCode == 200) {
        var resBodyOfSignUp = jsonDecode(res.body);

        if (resBodyOfSignUp['success'] == true) {
          Fluttertoast.showToast(
              msg: 'Congratulation, you are SignUp Successfully.');

          setState(() {
            // clear text field
            userNameController.clear();
            phoneController.clear();
            passwordController.clear();
          });

          // push user to dashboard
          Future.delayed(const Duration(milliseconds: 2000), () {
            Get.to(const LoginScreen());
          });
        } else {
          Fluttertoast.showToast(msg: 'Error Occured. Try Again.');
        }
      }
    } catch (e) {
      // print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  void dispose() {
    userNameController.dispose();
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
                  // Signup screen header
                  SizedBox(
                    height: 285,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset('assets/Signup.jpg'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
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
                                  //username
                                  TextFormField(
                                    controller: userNameController,
                                    validator: (value) => value == ""
                                        ? "Please enter your username"
                                        : null,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.person,
                                        color: Colors.blue,
                                      ),
                                      hintText: 'Username',
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
                                  //phone
                                  TextFormField(
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
                                          validatePhoneNumber();
                                        }
                                      },
                                      borderRadius: BorderRadius.circular(25),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 10,
                                        ),
                                        child: Text(
                                          'Signup',
                                          style: TextStyle(
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
                                const Text("Already have an account?"),
                                TextButton(
                                  onPressed: () {
                                    Get.to(const LoginScreen());
                                  },
                                  child: const Text(
                                    'Login Here',
                                    style: TextStyle(
                                      color: Colors.purpleAccent,
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
