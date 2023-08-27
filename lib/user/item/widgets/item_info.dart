import 'package:fashionshop/presentation/resource/font_manager.dart';
import 'package:fashionshop/presentation/resource/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ItemInfoWidget extends StatelessWidget {
  final String itemName;
  final double itemPrice, itemRating;

  const ItemInfoWidget(
      {super.key,
      required this.itemName,
      required this.itemPrice,
      required this.itemRating});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    itemName.toUpperCase(),
                    style: getBoldStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      '\$ ${itemPrice.toString()}',
                      style: getBoldStyle(
                        fontSize: 22,
                        color: Colors.blue,
                      ),
                    ),
                    RatingBar.builder(
                      initialRating: itemRating,
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
                      height: 5,
                    ),
                    Text(
                      "(${itemRating.toString()})",
                      style: const TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              'Avaliable Sizes',
              style: getTextStyle(
                FontSize.s22,
                FontConstants.fontFamily,
                FontWeight.normal,
                Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
