import 'package:fashionshop/presentation/resource/color_manager.dart';
import 'package:fashionshop/user/fragments/favorites_screen.dart';
import 'package:fashionshop/user/fragments/home_screen.dart';
import 'package:fashionshop/user/fragments/order_screen.dart';
import 'package:fashionshop/user/fragments/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../userPrefereences/current_user.dart';

// ignore: must_be_immutable
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final CurrentUser _remeberCurrentUser = Get.put(CurrentUser());

  final List<Widget> _fragmentScreen = [
    const HomeScreen(),
    const FavoritesScreen(),
    const OrderScreen(),
      ProfileScreen(),
  ];

  final List _navigationButtonsProperties = [
    {
      "active_icon": Icons.home,
      "non_active_icon": Icons.home_outlined,
      "label": "Home",
    },
    {
      "active_icon": Icons.favorite,
      "non_active_icon": Icons.favorite_border,
      "label": "Favorites",
    },
    {
      "active_icon": FontAwesomeIcons.boxOpen,
      "non_active_icon": FontAwesomeIcons.box,
      "label": "Orders",
    },
    {
      "active_icon": Icons.person,
      "non_active_icon": Icons.person_outline,
      "label": "Profile",
    },
  ];

  final RxInt _indexNumber = 0.obs;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CurrentUser(),
      initState: (currentState) {
        _remeberCurrentUser.getUserInfo();
      },
      builder: (controller) {
        return Scaffold(
          bottomNavigationBar: Obx(
            () => BottomNavigationBar(
              currentIndex: _indexNumber.value,
              onTap: (value) {
                _indexNumber.value = value;
              },
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white24,
              items: List.generate(4, (index) {
                var navBtnProperty = _navigationButtonsProperties[index];
                return BottomNavigationBarItem(
                    backgroundColor: ColorManager.primary,
                    icon: Icon(navBtnProperty["non_active_icon"]),
                    activeIcon: Icon(navBtnProperty["active_icon"]),
                    label: navBtnProperty["label"]);
              }),
            ),
          ),
          body: SafeArea(child: Obx(() => _fragmentScreen[_indexNumber.value])),
        );
      },
    );
  }
}
