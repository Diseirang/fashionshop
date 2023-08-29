import 'package:get/get.dart';

import '../model/cart.dart';

class CartListController extends GetxController {
  RxList<Cart> cartList = <Cart>[].obs;
  RxList<int> selectedItemList = <int>[].obs;
  RxBool isSelectedAll = false.obs;
  RxDouble totalPrice = 0.0.obs;

  List<Cart> get cartlist => cartList;
  List<int> get selecteditemlist => selectedItemList;
  bool get isselectedall => isSelectedAll.value;
  double get totalprice => totalPrice.value;

  setList(List<Cart> list) {
    cartList.value = list;
  }

  addSelectedItem(int itemSelectID) {
    selectedItemList.add(itemSelectID);
    update();
  }

  deletedSelectedItem(int itemSelectedID) {
    selectedItemList.remove(itemSelectedID);
  }

  setIsSelectedAllItems() {
    isSelectedAll.value = !isSelectedAll.value;
  }

  clearAllSelectedItems() {
    selectedItemList.clear();
    update();
  }

  setTotal(double overallTotal) {
    totalPrice.value = overallTotal;
  }
}
