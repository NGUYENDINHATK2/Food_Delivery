import 'dart:math';

import 'package:flutter/material.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';
import 'package:food_delivery/models/products_model.dart';
import '../data/repository/popular_product_repo.dart';
import 'cart_controller.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;

  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      print("got popular product list");
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {
      print("error");
      log(e);
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(quantity + 1);
    } else {
      _quantity = checkQuantity(quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar("Error", "Quantity can't be less than 0",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }

      return 0;
    } else if ((_inCartItems + quantity) > 20) {
      Get.snackbar("Error", "Quantity can't be more than 20",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductElement product, CartController cartController) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cartController;
    var exist = false;
    exist = _cart.existInCart(product);
    print("exist is $exist");
    if (exist) {
      _inCartItems = _cart.getQuantily(product);
    }
  }

  void addItem(ProductElement productElement) {
    _cart.addItem(productElement, _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuantily(productElement);
    _cart.cartList.forEach((key, value) {
    });
    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
