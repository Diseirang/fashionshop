import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'user/authentication/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fashion Shop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(builder: (context, dataSnapShot) {
        return const LoginScreen();
      }),
    );
  }
}
