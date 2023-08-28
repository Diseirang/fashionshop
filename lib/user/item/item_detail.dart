import 'dart:convert';

import 'package:fashionshop/user/model/item.dart';
import 'package:fashionshop/user/userPrefereences/current_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../api_connection/api_connection.dart';
import '../../presentation/resource/style_manager.dart';
import '../controllers/item_details_controller.dart';
import 'package:http/http.dart' as http;
// ignore: must_be_immutable
class ItemScreen extends StatefulWidget {
  final Item itemInfo;
  const ItemScreen(this.itemInfo, {super.key});

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  final itemDetailsController = Get.put(ItemDetailsController());
  final currentOnlineUser = Get.put(CurrentUser());
insertCart () async {
  try {
      var res = await http.post(
        Uri.parse(API.insertCart),
        body: {
          'user_id':currentOnlineUser.user.userid.toString(),
                 'item_id':widget.itemInfo.id.toString(),
          'quantity':itemDetailsController.quantity.toString(),
          'color':widget.itemInfo.colors[itemDetailsController.color],
          'size':widget.itemInfo.sizes[itemDetailsController.size],

        },
      );
      if (res.statusCode == 200) {
        var resBodyOfInCart = jsonDecode(res.body);

        if (resBodyOfInCart['success'] == true) {
          Fluttertoast.showToast(
              msg: 'Cart added!');
        } else {
          
          Fluttertoast.showToast(msg: 'Error occur. Cart not added!');
        }
      }
      else{
        Fluttertoast.showToast(msg: 'Status is mot 200!');
      }
    } catch (e) {
      // print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
}
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //image
          FadeInImage(
            height: MediaQuery.of(context).size.height * .5,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            placeholder: const AssetImage('assets/placeholder.jpeg'),
            image: NetworkImage(widget.itemInfo.image),
            imageErrorBuilder: (context, error, stackTraceError) {
              return const Center(
                child: Icon(
                  Icons.broken_image_outlined,
                ),
              );
            },
          ),
          Positioned(
            top: 35,
            right: 10,
            child: GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 2,
                    color: Colors.white,
                  ),
                ),
                child: IconButton(
                  onPressed: () {
                    //favorite
                  },
                  icon: const Icon(
                    CupertinoIcons.suit_heart,
                    color: Colors.orange,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 45,
            left: 15,
            child: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * .6,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(2, -3),
                      blurRadius: 6,
                    ),
                  ]),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(
                          top: 15,
                          bottom: 5,
                        ),
                        height: 5,
                        width: 100,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                widget.itemInfo.name.toUpperCase(),
                                style: getBoldStyle(
                                    fontSize: 26, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    RatingBar.builder(
                                      initialRating: widget.itemInfo.rating,
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
                                      width: 10,
                                    ),
                                    Text(
                                      "(${widget.itemInfo.rating.toString()})",
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 14),
                                    ),
                                  ],
                                ),
                                Text(
                                  ' ${widget.itemInfo.tags}'
                                      .toString()
                                      .replaceAll('[', '')
                                      .replaceAll(']', ''),
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$ ${widget.itemInfo.price.toString()}',
                              style: getBoldStyle(
                                fontSize: 26,
                                color: Colors.blue,
                              ),
                            ),
                            Obx(
                              () => Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          if (itemDetailsController.quantity >
                                              1) {
                                            itemDetailsController
                                                .setQuantityItem(
                                                    itemDetailsController
                                                            .quantity -
                                                        1);
                                          } else {
                                            itemDetailsController.quantity == 0;
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Item quantity can not low than 1.");
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.remove_circle_outline,
                                          color: Colors.red,
                                          size: 25,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        height: 40,
                                        decoration: const BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        child: Text(
                                          itemDetailsController.quantity
                                              .toString(),
                                          style: getBoldStyle(
                                              fontSize: 30,
                                              color: Colors.white),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          itemDetailsController.setQuantityItem(
                                              itemDetailsController.quantity +
                                                  1);
                                        },
                                        icon: const Icon(
                                          Icons.add_circle_outline,
                                          color: Colors.blue,
                                          size: 25,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Size',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          runSpacing: 8,
                          spacing: 8,
                          children: List.generate(widget.itemInfo.sizes.length,
                              (index) {
                            return Obx(
                              () => GestureDetector(
                                onTap: () {
                                  itemDetailsController.setSizeItem(index);
                                },
                                child: Container(
                                  height: 40,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      width: 2,
                                      color: itemDetailsController.size == index
                                          ? Colors.blueAccent
                                          : Colors.grey,
                                    ),
                                    color: itemDetailsController.size == index
                                        ? Colors.blue
                                        : Colors.white,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    widget.itemInfo.sizes[index]
                                        .replaceAll("[", "")
                                        .replaceAll("]", ""),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),

                        const SizedBox(height: 20),

                        //colors
                        const Text(
                          "Color",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Wrap(
                          runSpacing: 8,
                          spacing: 8,
                          children: List.generate(widget.itemInfo.colors.length,
                              (index) {
                            return Obx(
                              () => GestureDetector(
                                onTap: () {
                                  itemDetailsController.setColorItem(index);
                                },
                                child: Container(
                                  height: 40,
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    border: Border.all(
                                      width: 2,
                                      color:
                                          itemDetailsController.color == index
                                              ? Colors.transparent
                                              : Colors.grey,
                                    ),
                                    color: itemDetailsController.color == index
                                        ? Colors.blue
                                        : Colors.white,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    widget.itemInfo.colors[index]
                                        .replaceAll("[", "")
                                        .replaceAll("]", ""),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Description',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          widget.itemInfo.description,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Material(
                            child: InkWell(
                              onTap: () => insertCart(),
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Text(
                                  'Add to Cart',
                                  style: TextStyle(
                                     fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
