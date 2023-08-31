import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import '../../api_connection/api_connection.dart';
import '../../user/model/item.dart';
import '../resource/color_manager.dart';
import '../../user/item/item_detail.dart';

Future<List<Item>> getAllItems() async {
  List<Item> getAllItemList = [];
  try {
    var response = await http.get(Uri.parse(API.fetchAllItem));
    if (response.statusCode == 200) {
      var resBodyOfAllItem = jsonDecode(response.body);
      if (resBodyOfAllItem["success"] == true) {
        for (var element in (resBodyOfAllItem["allItemData"] as List)) {
          getAllItemList.add(Item.fromJson(element));
        }
      } else {
        Fluttertoast.showToast(msg: 'Error: Data not fetched');
      }
    } else {
      Fluttertoast.showToast(msg: 'Error, status code is not 200');
    }
  } catch (e) {
    Fluttertoast.showToast(msg: 'Error, ${e.toString()}');
  }
  return getAllItemList;
}

Widget getAllItemWidget(context) {
  // ignore: avoid_types_as_parameter_names
  return FutureBuilder(
    future: getAllItems(),
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
        return ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: dataSnapShot.data!.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            Item eachItemData = dataSnapShot.data![index];
            return GestureDetector(
              onTap: () {
                Get.to(ItemScreen(eachItemData));
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(
                  16,
                  index == 0 ? 8 : 4,
                  16,
                  index == dataSnapShot.data!.length - 1 ? 16 : 8,
                ),
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.amber),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(2, 2),
                      blurRadius: 6,
                      color: ColorManager.lightGrey,
                    ),
                  ],
                ),

                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(16),
                        topRight: Radius.circular(16),
                        topLeft: Radius.circular(17),
                        bottomLeft: Radius.circular(17),
                      ),
                      child: FadeInImage(
                        height: 90,
                        width: 90,
                        fit: BoxFit.cover,
                        placeholder:
                            const AssetImage('assets/placeholder.jpeg'),
                        image: NetworkImage(eachItemData.image!),
                        imageErrorBuilder: (context, error, stackTraceError) {
                          return const Center(
                            child: Icon(
                              Icons.broken_image_outlined,
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Container(
                          padding: const EdgeInsets.only(top: 8),
                          height: 80,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      eachItemData.name!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    'Rating',
                                    style: TextStyle(color: Colors.amber),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 6, bottom: 6),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '\$ ${eachItemData.price.toString()}',
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        RatingBar.builder(
                                          initialRating: eachItemData.rating!,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemBuilder: (context, c) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (updateRating) {},
                                          ignoreGestures: true,
                                          unratedColor: Colors.grey,
                                          itemSize: 14,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          "(${eachItemData.rating.toString()})",
                                          style: const TextStyle(
                                              color: Colors.grey, fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                ' ${eachItemData.tags}'
                                    .toString()
                                    .replaceAll('[', '')
                                    .replaceAll(']', ''),
                                style: TextStyle(
                                  color: ColorManager.grey,
                                  fontSize: 12,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                //item image
              ),
            );
          },
        );
      } else {
        return const Center(
          child: Text('Empty, No Data.'),
        );
      }
    },
  );
}
