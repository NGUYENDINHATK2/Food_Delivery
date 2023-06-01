import 'package:food_delivery/pages/food/popular_food_detail.dart';
import 'package:food_delivery/pages/food/recommened_food_detail.dart';
import 'package:get/get.dart';

import '../pages/cart/cart_page.dart';
import '../pages/home/main_food_page.dart';

class RouterHelper {
  static const String initial = '/';
  static const String popularFood = '/popular-food';
  static const String recommendedFood = '/recommended-food';
  static const String cartPage = '/cart-page';

  static String getInitial() => initial;
  static String getPopularFood(int pageId,String page) => '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId,String page) => '$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage() => '$cartPage';

  static List<GetPage> route = [
    GetPage(
      name: initial,
      page: () => const MainFoodPage(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: popularFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return PopularFoodDetail(
          pageId: int.parse(pageId!),
          page: page!,
        );
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: recommendedFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return RecommenedFoodDetail(
            pageId: int.parse(pageId!),
            page: page!
        );
      },
      transition: Transition.cupertino,
    ),
    GetPage(
      name: cartPage,
      page: (){
        return const CartPage();
      },
      transition: Transition.cupertino,
    ),

  ];
}
