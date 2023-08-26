import 'dart:convert';
import 'package:fashionshop/presentation/resource/color_manager.dart';
import 'package:fashionshop/presentation/resource/style_manager.dart';
import 'package:fashionshop/presentation/resource/textbox_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
                  Item eachItemData = dataSnapShot.data![index];
                  return GestureDetector(
                    child: Container(
                      height: 300,
                      width: 170,
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      margin: EdgeInsets.fromLTRB(
                        index == 0 ? 16 : 8,
                        10,
                        index == dataSnapShot.data!.length - 1 ? 16 : 8,
                        10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue[100],
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 3),
                            blurRadius: 6,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          //item image
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                            child: FadeInImage(
                              height: 160,
                              width: 200,
                              placeholder:
                                  const AssetImage('assets/placeholder.jpeg'),
                              image: NetworkImage(eachItemData.image!),
                              imageErrorBuilder:
                                  (context, error, stackTraceError) {
                                return const Center(
                                  child: Icon(
                                    Icons.broken_image_outlined,
                                  ),
                                );
                              },
                            ),
                          ),
                          //item name & price
                          //rating stars & rating numbers
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //item name & price
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        eachItemData.name!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      eachItemData.price.toString(),
                                      style: const TextStyle(
                                        color: Colors.purpleAccent,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(
                                  height: 8,
                                ),

                                //rating stars & rating numbers
                                Row(
                                  children: [
                                    RatingBar.builder(
                                      initialRating: eachItemData.rating!,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemBuilder: (context, c) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (updateRating) {},
                                      ignoreGestures: true,
                                      unratedColor: Colors.grey,
                                      itemSize: 20,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "(${eachItemData.rating.toString()})",
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
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
        Padding(
          padding: const EdgeInsets.only(
            left: 10,
          ),
          child: Text(
            text,
            style: getBoldStyle(fontSize: AppSize.s16, color: Colors.black),
          ),
        ),
        const SizedBox(
          height: AppSize.s16,
        ),
      ],
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
