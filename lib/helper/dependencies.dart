import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/data/apis/api_client.dart';
import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/data/repository/recommeneded_product_repo.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../controllers/recommeneded_product_controller.dart';
import '../data/repository/cart_repo.dart';

Future<void> init() async {
  //? api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));
  // ? repo
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommenededProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo());
  // ? controller
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommenededProductController(recommenededProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
