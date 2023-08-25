import 'package:fashionshop/user/fragments/favorites_screen.dart';
import 'package:fashionshop/user/fragments/home.dart';
import 'package:fashionshop/user/fragments/order_screen.dart';
import 'package:fashionshop/user/fragments/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../presentation/resource/color_manager.dart';
import '../../presentation/resource/value_manager.dart';
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
    const ProfileScreen(),
  ];

  final List<Widget> _destinationScreen = [
    const NavigationDestination(
      selectedIcon: Icon(Icons.home),
      icon: Icon(Icons.home_outlined),
      label: 'Home',
    ),
    const NavigationDestination(
      selectedIcon: Icon(Icons.favorite),
      icon: Icon(Icons.favorite_outline),
      label: 'Favorite',
    ),
    const NavigationDestination(
      selectedIcon: Icon(FontAwesomeIcons.boxOpen),
      icon: Icon(FontAwesomeIcons.box),
      label: 'Order',
    ),
    const NavigationDestination(
      selectedIcon: Icon(Icons.person),
      icon: Icon(Icons.person_outlined),
      label: 'Profile',
    ),
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
          bottomNavigationBar: SafeArea(
            child: Obx(
              () => NavigationBar(
                height: AppSize.s60,
                selectedIndex: _indexNumber.value,
                indicatorColor: ColorManager.primaryOpacity70,
                destinations: _destinationScreen,
                onDestinationSelected: (value) {
                  setState(() {
                    _indexNumber.value = value;
                  });
                },
              ),
            ),
          ),
          body: Obx(() => _fragmentScreen[_indexNumber.value]),
        );
      },
    );
  }
}
