import 'dart:math';

import 'package:get/get.dart';
import 'package:food_delivery/models/products_model.dart';

import '../data/repository/recommeneded_product_repo.dart';

class RecommenededProductController extends GetxController {
  final RecommenededProductRepo recommenededProductRepo;
  RecommenededProductController({required this.recommenededProductRepo});
  List<dynamic> _recommenededProductList = [];
  List<dynamic> get recommenededProductList => _recommenededProductList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommenededProductList() async {
    Response response = await recommenededProductRepo.getRecommenededProductList();
    if (response.statusCode == 200) {
      print("got popular product list");
      _recommenededProductList = [];
      _recommenededProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {
      print("error");
      log(e);
    }
  }
}
