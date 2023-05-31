import 'package:food_delivery/models/products_model.dart';
import 'package:get/get.dart';

import '../data/repository/cart_repo.dart';
import '../models/cart_model.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  final Map<int, CartModel> _cartList = {};
  Map<int, CartModel> get cartList => _cartList;

  void addItem(ProductElement product, int quantity) {
    if (_cartList.containsKey(product.id)) {
      _cartList.update(product.id, (value) {
        return CartModel(
          id: product.id,
          name: product.name,
          img: product.img,
          price: product.price,
          quantity: value.quantity! + quantity,
          isExist: true,
          time: DateTime.now().toString(),
        );
      });
    } else {
      if (quantity > 0) {
        _cartList.putIfAbsent(product.id, () {
          return CartModel(
            id: product.id,
            name: product.name,
            img: product.img,
            price: product.price,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
          );
        });
      } else {
        Get.snackbar("Error", "Quantity can't be less than 0");
      }
    }
  }

  bool existInCart(ProductElement product) {
    if (_cartList.containsKey(product.id)) {
      return true;
    } else {
      return false;
    }
  }

  getQuantily(ProductElement product) {
    var quantity = 0;
    if (_cartList.containsKey(product.id)) {
      _cartList.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
      return quantity;
    } else {
      return 0;
    }
  }
}
