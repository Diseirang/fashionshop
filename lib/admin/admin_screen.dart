import 'dart:convert';
import 'package:fashionshop/api_connection/api_connection.dart';
import 'package:fashionshop/presentation/resource/color_manager.dart';
import 'package:fashionshop/presentation/resource/style_manager.dart';
import 'package:fashionshop/presentation/resource/textbox_manager.dart';
import 'package:fashionshop/user/authentication/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../presentation/resource/value_manager.dart';
import 'admin_upload_item.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  var formKey = GlobalKey<FormState>();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var isObsecure = true.obs;

  loginAdmin() async {
    try {
      var resAdminData = await http.post(
        Uri.parse(API.adminlogin),
        body: {
          'admin_name': usernameController.text.trim(),
          'admin_password': passwordController.text.trim(),
        },
      );

      if (resAdminData.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(resAdminData.body);

        if (resBodyOfLogin['login'] == true) {
          Fluttertoast.showToast(msg: 'Login successful.\n Have a nice day!');

          setState(() {
            //clear text field
            usernameController.clear();
            passwordController.clear();
          });

          Future.delayed(const Duration(milliseconds: 1000), () {
            Get.to(const AdminUploadScreen());
          });
        } else {
          Fluttertoast.showToast(
              msg: 'Incorrect username or password.\nTry Again.');
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
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
                  const SizedBox(
                    height: AppSize.s28,
                  ),
                  Text(
                    'Admin Login',
                    style:
                        getBoldStyle(fontSize: AppSize.s28, color: Colors.blue),
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
                                    keyboardType: TextInputType.text,
                                    controller: usernameController,
                                    validator: (value) => value == ""
                                        ? "Please enter your phone number"
                                        : null,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.person_4_rounded,
                                        color: Colors.blue,
                                      ),
                                      hintText: 'Username',
                                      hintStyle: hintStyle(),
                                      border: outlinedBorder,
                                      enabledBorder: enabledBorder,
                                      focusedBorder: focuseBorder,
                                      disabledBorder: disabledBorder,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 6),
                                      fillColor: ColorManager.white,
                                      filled: true,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
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
                                        hintStyle: hintStyle(),
                                        border: outlinedBorder,
                                        enabledBorder: enabledBorder,
                                        focusedBorder: focuseBorder,
                                        disabledBorder: disabledBorder,
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
                                          loginAdmin();
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
                                            fontSize: 20,
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
                                const Text("I'm not Admin?"),
                                TextButton(
                                  onPressed: () {
                                    Get.to(const LoginScreen());
                                  },
                                  child: const Text(
                                    'Click here',
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
