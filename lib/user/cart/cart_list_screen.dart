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
          'currentOnlineUserID': currentOnlineUser.user.userid.toString(),
        },
      );
      if (res.statusCode == 200) {
        var responeBodyOfGetCurrenOnlineUserCartItems = jsonDecode(res.body);
        if (responeBodyOfGetCurrenOnlineUserCartItems['success'] == true) {
          for (var eachCurrentUserCartItemData
              in ((responeBodyOfGetCurrenOnlineUserCartItems[
                  'currentUserCartData']) as List)) {
            cartListOfCurrentUser
                .add(Cart.fromJson(eachCurrentUserCartItemData));
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
    if (cartListController.selectedItemList.isNotEmpty) {
      for (var itemInCart in cartListController.cartlist) {
        if (cartListController.selectedItemList.contains(itemInCart.itemid)) {
          double eachItemTotalAmoung = itemInCart.price! * itemInCart.quantity!;
          cartListController
              .setTotal(cartListController.total + eachItemTotalAmoung);
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
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.shopping_cart_checkout_rounded,
              color: Colors.white,
              
            ),
            
          ),
        ],
        automaticallyImplyLeading: false,
        title: const Text(
          'Cart List',
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(
        () => cartListController.cartList.isNotEmpty
            ? ListView.builder(
                itemCount: cartListController.cartlist.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  Cart cartModel = cartListController.cartlist[index];
                  Item itemModel = Item(
                      id: cartModel.itemid,
                      name: cartModel.name,
                      rating: cartModel.rating,
                      tags: cartModel.tags,
                      price: cartModel.price,
                      sizes: cartModel.sizes,
                      colors: cartModel.colors,
                      description: cartModel.description,
                      image: cartModel.image);
                  return Container(
                    margin: const EdgeInsets.only(bottom: 5, top: 5),
                    // color: Colors.grey[300],
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        GetBuilder(
                          builder: (controller) {
                            return IconButton(
                              onPressed: () {cartListController.addSelectedItem(cartModel.itemid!);
                              calculateTotalAmoung();
                              },
                              icon: Icon(
                                cartListController.selectedItemList
                                        .contains(cartModel.itemid)
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank,
                                color: cartListController.isSelectedAll
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
                              // color: Colors.amber,
                              margin: EdgeInsets.fromLTRB(
                                0,
                                index == 0 ? 5 : 5,
                                10,
                                index == cartListController.cartlist.length - 1
                                    ? 10
                                    : 5,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                        offset: Offset(0, 0),
                                        blurRadius: 6,
                                        color: Colors.blue),
                                  ]),
                              child: Row(
                                children: [
                                  //name
                                  //color size + price
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            itemModel.name.toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Color: ${cartModel.color!.replaceAll('[', '').replaceAll(']', '')} \nSize: ${cartModel.size!.replaceAll('[', '').replaceAll(']', '')}",
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 8,
                                                  // left: 12.0,
                                                  right: 12.0,
                                                ),
                                                child: Text(
                                                  '\$${itemModel.price.toString()}',
                                                  style: const TextStyle(
                                                    fontSize: 22,
                                                    color: Colors.blue,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              // +
                                              IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                  Icons.add_circle_outline,
                                                  size: 22,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              Text(
                                                cartModel.quantity.toString(),
                                                style: getBoldStyle(
                                                    fontSize: 22,
                                                    color: Colors.black),
                                              ),
                                              // -
                                              IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                  Icons.remove_circle_outline,
                                                  size: 22,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  // image
                                  SizedBox(
                                    height: 150,
                                    width: 150,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(17),
                                        topRight: Radius.circular(17),
                                        topLeft: Radius.circular(17),
                                        bottomLeft: Radius.circular(17),
                                      ),
                                      child: FadeInImage(
                                        height: 180,
                                        width: 180,
                                        fit: BoxFit.cover,
                                        placeholder: const AssetImage(
                                            'assets/placeholder.jpeg'),
                                        image: NetworkImage(itemModel.image!),
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
                child: CircularProgressIndicator(),
              ),
      ),
      bottomNavigationBar: GetBuilder(
        init: CartListController(),
        builder: (controller) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.amber,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, -3),
                  color: Colors.blue,
                  blurRadius: 3,
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                // total amount
                Text(
                  'Total Amount: ',
                  style: getBoldStyle(fontSize: 18, color: Colors.white),
                ),
                Obx(
                  () => Text(
                    '  \$${cartListController.total.toString()}',
                    style: getBoldStyle(
                      fontSize: 22,
                      color: Colors.blue,
                      
                    ),
                    maxLines: 1,

                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
