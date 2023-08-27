import 'package:fashionshop/user/item/widgets/item_info.dart';
import 'package:fashionshop/user/model/item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ItemScreen extends StatelessWidget {
  final Item itemInfo;
  const ItemScreen(this.itemInfo, {super.key});

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
            image: NetworkImage(itemInfo.image),
            imageErrorBuilder: (context, error, stackTraceError) {
              return const Center(
                child: Icon(
                  Icons.broken_image_outlined,
                ),
              );
            },
          ),
          Positioned(
            top: 30,
            left: 10,
            child: CircleAvatar(
              backgroundColor: Colors.grey.withOpacity(.6),
              child: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
              ),
            ),
          ),
            Align(
            alignment: Alignment.bottomCenter,
            child: ItemInfoWidget(itemName: itemInfo.name,itemPrice:  itemInfo.price,itemRating: itemInfo.rating,),
          )
        ],
      ),
    );
  }
}
