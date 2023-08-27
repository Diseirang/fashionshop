import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import '../../api_connection/api_connection.dart';
import '../../user/model/item.dart';
import '../resource/color_manager.dart';
import '../screen/item_screen.dart';

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
                Get.to(ItemScreen(eachItemData.id));
              },
              child: Container(
                
                margin: EdgeInsets.fromLTRB(
                  16,
                  index == 0 ? 16 : 8,
                  16,
                  index == dataSnapShot.data!.length - 1 ? 16 : 8,
                ),
                decoration: BoxDecoration(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            eachItemData.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6, bottom: 6),
                            child: Text(
                              '\$ ${eachItemData.price.toString()}',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            eachItemData.tags
                                .toString()
                                .replaceAll('[', '')
                                .replaceAll(']', ''),
                            style: TextStyle(
                              color: ColorManager.grey,
                              fontSize: 14,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //item image
                    ClipRRect(
                      
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      child: FadeInImage(
                        
                        height: 100.0,
                        width: 100.0,
                        fit: BoxFit.cover,
                        placeholder:
                            const AssetImage('assets/placeholder.jpeg'),
                        image: NetworkImage(eachItemData.image),
                        imageErrorBuilder: (context, error, stackTraceError) {
                          return const Center(
                            child: Icon(
                              Icons.broken_image_outlined,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
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
