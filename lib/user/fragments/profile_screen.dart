import 'package:fashionshop/presentation/resource/color_manager.dart';
import 'package:fashionshop/presentation/resource/value_manager.dart';
import 'package:fashionshop/user/authentication/login_screen.dart';
import 'package:fashionshop/user/userPrefereences/current_user.dart';
import 'package:fashionshop/user/userPrefereences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../presentation/resource/style_manager.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final CurrentUser _currentUser = Get.put(CurrentUser());

  signOutUser() async {
    var resultRespone = await Get.dialog(AlertDialog(
      backgroundColor: ColorManager.white,
      title: Text(
        'Logout',
        style: getBoldStyle(fontSize: AppSize.s20, color: Colors.black),
      ),
      content: const Text('Are you sure want to sign out?'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text(
            'No',
            style: TextStyle(color: Colors.black),
          ),
        ),
        TextButton(
          onPressed: () {
            Get.back(result: 'LoggedOut');
          },
          child: const Text(
            'Yes',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    ));
    if (resultRespone == 'LoggedOut') {
      RememberUserPrefs.removeUserInfo().then(
        (value) => Get.off(
          const LoginScreen(),
        ),
      );
    }
  }

  Widget userInfoItem(IconData iconData, String userData) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p12,
        vertical: AppPadding.p8,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s12),
        ),
        color: ColorManager.grey,
      ),
      child: Row(
        children: [
          Icon(
            iconData,
            size: AppSize.s28,
            color: ColorManager.lightBlue,
          ),
          const SizedBox(width: AppSize.s8),
          Text(userData, style: getMediumStyle(color: ColorManager.white)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p18),
      child: ListView(
        children: [
          Center(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(AppMargin.m20),
                  height: 150,
                  child: ClipOval(
                    clipBehavior: Clip.hardEdge,
                    child: Image.asset('assets/Profile.jpg'),
                  ),
                ),
                Text(
                  'Your Info',
                  style: getBoldStyle(
                      color: ColorManager.darkGrey, fontSize: AppSize.s16),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
          userInfoItem(Icons.person, _currentUser.user.username),
          const SizedBox(
            height: AppSize.s8,
          ),
          userInfoItem(Icons.phone, _currentUser.user.phone),
          const SizedBox(
            height: AppSize.s8,
          ),
          userInfoItem(Icons.email, 'Email'),
          const SizedBox(
            height: AppSize.s12,
          ),
          Center(
            child: Material(
              color: ColorManager.primary,
              borderRadius: BorderRadius.circular(AppSize.s20),
              child: InkWell(
                onTap: () => signOutUser(),
                borderRadius: BorderRadius.circular(AppSize.s20),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p20,
                    vertical: AppPadding.p12,
                  ),
                  child: Text(
                    'Sign Out',
                    style: getBoldStyle(
                      fontSize: AppSize.s18,
                      color: ColorManager.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
