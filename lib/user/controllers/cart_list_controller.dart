import 'package:get/get.dart';

import '../model/cart.dart';

class CartListController extends GetxController {
  RxList<Cart> cartList = <Cart>[].obs;
  RxList<int> selectedItemLists = <int>[].obs;
  RxBool isSelectedAllItem = false.obs;
  RxDouble totalPrice = 0.0.obs;

  List<Cart> get cartlist => cartList;
  List<int> get selectedItemList => selectedItemLists;
  bool get isSelectedAll => isSelectedAllItem.value;
  double get total => totalPrice.value;

  setList(List<Cart> list) {
    cartList.value = list;
  }

  addSelectedItem(int itemSelectID) {
    selectedItemLists.add(itemSelectID);
    update();
  }

  deletedSelectedItem(int itemSelectedID) {
    selectedItemLists.remove(itemSelectedID);
  }

  setIsSelectedAllItems() {
    isSelectedAllItem.value = !isSelectedAllItem.value;
  }

  clearAllSelectedItems() {
    selectedItemLists.clear();
    update();
  }

  setTotal(double overallTotal) {
    totalPrice.value = overallTotal;
  }
}
