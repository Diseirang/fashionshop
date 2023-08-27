import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';

import '../../user/model/item.dart';
import 'package:http/http.dart' as http;

Future<List<Item>> fetchingItems(
    dynamic apiPhrase, String resBodyText1, String resBodyText2) async {
  List<Item> trendingItemList = [];
  try {
    var response = await http.get(Uri.parse(apiPhrase));
    if (response.statusCode == 200) {
      var resBodyOfTrendingItem = jsonDecode(response.body);
      if (resBodyOfTrendingItem[resBodyText1] == true) {
        for (var element in (resBodyOfTrendingItem[resBodyText2] as List)) {
          trendingItemList.add(Item.fromJson(element));
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
  return trendingItemList;
}
