import 'dart:convert';

import 'package:fashionshop/presentation/resource/style_manager.dart';
import 'package:fashionshop/user/model/cart.dart';
import 'package:fashionshop/user/model/item.dart';
import 'package:fashionshop/user/userPrefereences/current_user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../api_connection/api_connection.dart';
import '../controllers/cart_list_controller.dart';

class CartListScreen extends StatefulWidget {
  const CartListScreen({super.key});

  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  final currentOnlineUser = Get.put(CurrentUser());
  final cartListController = Get.put(CartListController());

  getCurrenUserCartList() async {
    List<Cart> cartListOfCurrentUser = [];
    try {
      var res = await http.post(
        Uri.parse(API.fetchCart),
        body: {
          'currenOnlineUserID': currentOnlineUser.user.userid.toString(),
        },
      );
      if (res.statusCode == 200) {
        var responeBodyOfGetCurrenOnlineUserCartItems = jsonDecode(res.body);
        if (responeBodyOfGetCurrenOnlineUserCartItems['success'] == true) {
          for (var eachCurrentUserCartItem
              in (responeBodyOfGetCurrenOnlineUserCartItems[
                  'currentOnlineUserID'] as List)) {
            cartListOfCurrentUser.add(Cart.fromJson(eachCurrentUserCartItem));
          }
        } else {
          Fluttertoast.showToast(msg: "Error occured while executing query.");
        }
        cartListController.setList(cartListOfCurrentUser);
      } else {
        Fluttertoast.showToast(msg: "Status code is not 200.");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error, ${e.toString()}");
    }
    calculateTotalAmoung();
  }

  calculateTotalAmoung() {
    cartListController.setTotal(0);
    if (cartListController.selectedItemList.isEmpty) {
      for (var itemInCart in cartListController.cartList) {
        if (cartListController.selectedItemList.contains(itemInCart.itemid)) {
          double eachItemTotalAmoung = itemInCart.price * itemInCart.quantity;
          cartListController
              .setTotal(cartListController.totalprice + eachItemTotalAmoung);
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrenUserCartList();
  }

@override
void initState() {
  super.initState();
  getCurrenUserCartList();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
          ),
          // actions: [
          //   IconButton(
          //     onPressed: () {},
          //     icon: const Icon(
          //       Icons.paid_rounded,
          //       color: Colors.white,
          //     ),
          //   ),
          // ],
          automaticallyImplyLeading: false,
          title: const Text(
            'Cart List',
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
        ),
        body: Obx(
          () => cartListController.cartList.isEmpty
              ? ListView.builder(
                  itemCount: cartListController.cartList.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    Cart cartModel = cartListController.cartList[index];

                    Item itemModel = Item(
                        cartModel.itemid,
                        cartModel.name,
                        cartModel.rating,
                        cartModel.tags,
                        cartModel.price,
                        cartModel.sizes,
                        cartModel.colors,
                        cartModel.description,
                        cartModel.image);
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          GetBuilder(
                            builder: (controller) {
                              return IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  cartListController.selectedItemList
                                          .contains(cartModel.itemid)
                                      ? Icons.check_box
                                      : Icons.check_box_outline_blank,
                                  color: cartListController.isselectedall
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                              );
                            },
                            init: CartListController(),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    0,
                                    index == 0 ? 16 : 8,
                                    16,
                                    index ==
                                            cartListController.cartList.length -
                                                1
                                        ? 16
                                        : 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.black,
                                  boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(0, 0),
                                      blurRadius: 6,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            itemModel.name.toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Color: ${cartModel.color.replaceAll('[', '').replaceAll(']', '')} \n Size: ${cartModel.size.replaceAll('[', '').replaceAll(']', '')}",
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    color: Colors.white60,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 12.0,
                                                  right: 12.0,
                                                ),
                                                child: Text(
                                                  '\$ ${itemModel.price.toString()}',
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.purpleAccent,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              : const Center(
                  child: Text('Cart is empty!'),
                ),
        ));
  }
}
