import 'package:food_delivery/pages/food/popular_food_detail.dart';
import 'package:food_delivery/pages/food/recommened_food_detail.dart';
import 'package:get/get.dart';

import '../pages/home/main_food_page.dart';

class RouterHelper {
  static const String initial = '/';
  static const String popularFood = '/popular-food';
  static const String recommendedFood = '/recommended-food';

  static String getInitial() => initial;
  static String getPopularFood(int pageId) => '$popularFood?pageId=$pageId';
  static String getRecommendedFood(int pageId) =>
      '$recommendedFood?pageId=$pageId';

  static List<GetPage> route = [
    GetPage(
      name: initial,
      page: () => const MainFoodPage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: popularFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        return PopularFoodDetail(
          pageId: int.parse(pageId!),
        );
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: recommendedFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        return RecommenedFoodDetail(pageId: int.parse(pageId!));
      },
      transition: Transition.cupertino,
    ),
  ];
}
