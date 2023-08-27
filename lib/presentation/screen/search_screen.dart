import 'package:fashionshop/presentation/resource/color_manager.dart';
import 'package:fashionshop/presentation/resource/style_manager.dart';
import 'package:fashionshop/presentation/resource/textbox_manager.dart';
import 'package:fashionshop/presentation/resource/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        bottomNavigationBar: showSearchBar(),
        resizeToAvoidBottomInset: true,
      ),
    );
  }

  Widget showSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
      child: TextField(
        style: getRegularStyle(color: ColorManager.grey),
        controller: searchController,
        decoration: InputDecoration(
          prefixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          hintText: 'Search the best product here...',
          hintStyle: const TextStyle(color: Colors.grey, fontSize: AppSize.s16),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.white,
              width: 10,
            ),
          ),
          enabledBorder: enabledBorder,
          disabledBorder: disabledBorder,
          focusedBorder: focuseBorder,
          contentPadding: contentPadding,
        ),
      ),
    );
  }
}
