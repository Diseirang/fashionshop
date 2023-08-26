import 'dart:convert';
import 'package:fashionshop/presentation/resource/color_manager.dart';
import 'package:fashionshop/presentation/resource/style_manager.dart';
import 'package:fashionshop/presentation/resource/textbox_manager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../api_connection/api_connection.dart';
import '../../presentation/resource/value_manager.dart';
import '../model/item.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  List<Item> trendingItemList = [];

  Future<List<Item>> getTrendingItems() async {
    try {
      var response = await http.get(Uri.parse(API.getTrendingMostPopularItems));
      if (response.statusCode == 200) {
        var resBodyOfTrendingItem = jsonDecode(response.body);
        if (resBodyOfTrendingItem["fetched"] == true) {
          for (var element in (resBodyOfTrendingItem["itemData"] as List)) {
            trendingItemList.add(Item.fromJson(element));
          }
        } else {
          Fluttertoast.showToast(msg: 'Error: Data not fetched');
        }
      } else {
        Fluttertoast.showToast(msg: 'Error, status code is not 200');
      }
    } catch (e) {
      // print(e.toString());
      Fluttertoast.showToast(msg: 'Error, ${e.toString()}');
    }
    return trendingItemList;
  }

   
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // search bar
            showSearchBar(),
            //trending items
            groupTitle('Trending'),
            trendingMostPopularItemWidget(context),

            // new items collection
            groupTitle('New Collections'),
          ],
        ),
      ),
    );
  }

  Widget trendingMostPopularItemWidget(context) {
    // ignore: avoid_types_as_parameter_names
    return FutureBuilder(
        future: getTrendingItems(),
        builder: (context, AsyncSnapshot<List<Item>> dataSnapShot) {
          if (dataSnapShot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (dataSnapShot.data == null) {
            return const Center(
              child: Text('No trending items founded'),
            );
          }
          if (dataSnapShot.data!.isNotEmpty) {
            return SizedBox(
              height: 260,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dataSnapShot.data!.length,
                itemBuilder: (context, index) {
                  // Item eachItemData = dataSnapShot.data![index];
                  return GestureDetector(
                    child: Container(
                      width: 200,
                      margin: EdgeInsets.fromLTRB(
                        index == 0 ? 16 : 8,
                        10,
                        index == dataSnapShot.data!.length - 1 ? 16 : 8,
                        10,
                      ),
                      decoration: BoxDecoration(color: Colors.amber[700]),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: Text('Empty, No Data.'),
            );
          }
        });
  }

  Widget groupTitle(String text) {
    return Column(
      children: [
        const SizedBox(
          height: AppSize.s20,
        ),
        Text(
          text,
          style: getBoldStyle(fontSize: AppSize.s16, color: Colors.black),
        ),
        const SizedBox(
          height: AppSize.s16,
        ),
      ],
    );
  }

  Widget showSearchBar() {
    return TextField(
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
    );
  }
}
 