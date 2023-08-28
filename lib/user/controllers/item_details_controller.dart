import 'package:get/get.dart';

class ItemDetailsController extends GetxController {
  RxInt _quantity = 1.obs;
  RxInt _sizeItem = 1.obs;
  RxInt _colorItem = 1.obs;
  RxBool _isFavoraite = false.obs;

  int get quantity => _quantity.value;
  int get size => _sizeItem.value;
  int get color => _colorItem.value;
  bool get favorite => _isFavoraite.value;

  setQuantityItem(int quantityOfItem) {
    _quantity.value = quantityOfItem;
  }

  setSizeItem(int sizeOfItem) {
    _sizeItem.value = sizeOfItem;
  }

  setColorItem(int colorOfItem) {
    _colorItem.value = colorOfItem;
  }

  setIsFavorite(bool isFavorite) {
    _isFavoraite.value = isFavorite;
  }
}
