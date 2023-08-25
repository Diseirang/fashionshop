import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../userPrefereences/current_user.dart';

class DashboardScreen extends StatelessWidget {
  CurrentUser _remeberCurrentUser = Get.put(CurrentUser());

  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (controller) {
        return Scaffold();
      },
      init: CurrentUser(),
      initState: (currentState) {
        _remeberCurrentUser.getUserInfo();
      },
    );
  }
}
