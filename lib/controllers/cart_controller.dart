import 'package:flutter/material.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:get/get.dart';

import '../data/repository/cart_repo.dart';
import '../models/cart_model.dart';
import '../utils/colors.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  final Map<int, CartModel> _cartList = {};
  Map<int, CartModel> get cartList => _cartList;
  List<CartModel> storageItems = [];

  void addItem(ProductElement product, int quantity) {
    var totalQuantity = 0;
    if (_cartList.containsKey(product.id)) {
      _cartList.update(product.id, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
          id: product.id,
          name: product.name,
          img: product.img,
          price: product.price,
          quantity: value.quantity! + quantity,
          isExist: true,
          time: DateTime.now().toString(),
          product: product,
        );
      });
      if (totalQuantity <= 0) {
        _cartList.remove(product.id);
      }
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
            product: product,
          );
        });
        Get.snackbar("Success", "Item added to cart",backgroundColor: AppColors.mainColor, colorText: Colors.white);
      } else {
        Get.snackbar("Error", "Quantity can't be less than 0");
      }
    }
    cartRepo.addToCartList(getItems);
    update();
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
  int get totalItems {
    var total = 0;
    _cartList.forEach((key, value) {
      total += value.quantity!;
    });
    return total;
  }
  int get totalAmount {
    var total = 0;
    _cartList.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }
  List<CartModel> get getItems {
    return _cartList.entries.map((e) => e.value).toList();
  }

  List<CartModel> getCartData(){
    setCart=cartRepo.getCartList();
    return storageItems;
  }
  set setCart(List<CartModel> items){
    storageItems = items;
    // print("storage items are "+storageItems.length.toString());
    for(int i=0;i<storageItems.length;i++){
      _cartList.putIfAbsent(storageItems[i].product!.id!!, ()=>storageItems[i]);
    }
  }
  void addToHistory(){
    cartRepo.addToCartHistoryList();
    clear();
  }
  void clear() {
    _cartList.clear();
    update();
  }
}
