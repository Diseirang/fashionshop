import 'dart:convert';

import 'package:fashionshop/api_connection/api_connection.dart';
import 'package:fashionshop/user/model/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../resource/color_manager.dart';
import '../../user/item/item_detail.dart';

Future<List<Item>> getTrendingItems() async {
  List<Item> trendingItemList = [];
  try {
    var response = await http.get(Uri.parse(API.getTrendingMostPopularItems));
    if (response.statusCode == 200) {
      var resBodyOfTrendingItem = jsonDecode(response.body);
      if (resBodyOfTrendingItem["fetched"] == true) {
        for (var element in (resBodyOfTrendingItem["itemData"] as List)) {
          trendingItemList.add(Item.fromJson(element));
        }
      } else {
        Fluttertoast.showToast(msg: 'Error! Data not founded');
      }
    } else {
      Fluttertoast.showToast(msg: 'Error! status code is not 200');
    }
  } catch (e) {
    Fluttertoast.showToast(msg: 'Error! ${e.toString()}');
  }
  return trendingItemList;
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
            height: 320,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dataSnapShot.data!.length,
              itemBuilder: (context, index) {
                Item eachItemData = dataSnapShot.data![index];
                return GestureDetector(
                  onTap: () {
                    Get.to(ItemScreen(eachItemData));
                  },
                  child: Container(
                    height: 320,
                    width: 200,
                    margin: EdgeInsets.fromLTRB(
                      index == 0 ? 16 : 8,
                      10,
                      index == dataSnapShot.data!.length - 1 ? 16 : 8,
                      10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      border: Border.all(width: 3, color: Colors.blue),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(2, 2),
                          blurRadius: 6,
                          color: ColorManager.lightGrey,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        //item image
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(18),
                            topRight: Radius.circular(18),
                          ),
                          child: FadeInImage(
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                            placeholder:
                                const AssetImage('assets/placeholder.jpeg'),
                            image: NetworkImage(eachItemData.image),
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
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //item name & price
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      eachItemData.name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '\$ ${eachItemData.price.toString()}',
                                    style: const TextStyle(
                                      color: Colors.blue,
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
                                    initialRating: eachItemData.rating,
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
                                    itemSize: 22,
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
