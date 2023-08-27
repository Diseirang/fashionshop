import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ItemScreen extends StatelessWidget {
  int itemId;
    ItemScreen (this.itemId,{super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Text(itemId.toString()),
      ),);
  }
}