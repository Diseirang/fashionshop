import 'package:fashionshop/user/fragments/dashboard_screen.dart';
import 'package:fashionshop/user/userPrefereences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../user/authentication/login_screen.dart';

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
      home: FutureBuilder(
        future: RememberUserPrefs.readUserInfo(),
        builder: (context, dataSnapShot) {
          if(dataSnapShot.data==null)
          {
            return const LoginScreen();
          }
          else
          {
            return const DashboardScreen();
          }
        },
      ),
    );
  }
}