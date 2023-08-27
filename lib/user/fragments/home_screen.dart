import 'package:fashionshop/presentation/screen/cart_screen.dart';
import 'package:fashionshop/presentation/screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../presentation/resource/value_manager.dart';
import '../../presentation/widget/new_collection.dart';
import '../../presentation/widget/subtitle.dart';
import '../../presentation/widget/trending_item.dart';

import '../userPrefereences/current_user.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CurrentUser _currentUser = Get.put(CurrentUser());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () => Get.to(const SearchScreen()),
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () => Get.to(const CartScreen()),
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: AppPadding.p14,
            ),
          ],
          automaticallyImplyLeading: false,
          title: Text(
            'Welcome, ${_currentUser.user.username}',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //trending items
              groupTitle('Trending'),
              trendingMostPopularItemWidget(context),
              // new items collection
              groupTitle('New Collections'),
              getAllItemWidget(context),
            ],
          ),
        ),
      ),
    );
  }
}
