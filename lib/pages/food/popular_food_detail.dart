import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/exandable_text_widget.dart';
import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
import '../../routers/router_helper.dart';
import '../../widgets/app_column.dart';
import '../cart/cart_page.dart';

class PopularFoodDetail extends StatelessWidget {
  int pageId;

  PopularFoodDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // box
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: Dimensions.popularFoodDetailImageSize,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://cdn.sforum.vn/sforum/wp-content/uploads/2023/01/Raiden-Shogun-Build-Guide-For-Genshin-Impact.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // icon widgets
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.widtht20,
            right: Dimensions.widtht20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      Get.toNamed(RouterHelper.initial);
                    },
                    child: const AppIcon(icon: Icons.arrow_back_ios)),
                GetBuilder<PopularProductController>(builder: (controller) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => const CartPage());
                    },
                    child: Stack(
                      children: [
                        const AppIcon(icon: Icons.shopping_cart_outlined),
                        Get.find<PopularProductController>().totalItems >= 1
                            ? Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppColors.mainColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: BigText(
                                    text: Get.find<PopularProductController>()
                                        .totalItems
                                        .toString(),
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  );
                })
              ],
            ),
          ),
          // introduction
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularFoodDetailImageSize - 50,
            child: Container(
              padding: EdgeInsets.only(
                left: Dimensions.height20,
                right: Dimensions.height20,
                top: Dimensions.height20,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.borderRadius20),
                    topRight: Radius.circular(Dimensions.borderRadius20),
                  ),
                  color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(text: product.name!),
                  SizedBox(height: Dimensions.height20),
                  BigText(text: "Introduce"),
                  SizedBox(height: Dimensions.height10),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: ExandableTextWidget(text: product.description!),
                    ),
                  )
                ],
              ),
            ),
          ),
          // exandable text widget
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularProduct) {
          return Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.widtht30,
              vertical: Dimensions.height20,
            ),
            decoration: BoxDecoration(
              color: AppColors.buttonBackgroupColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.borderRadius20 * 2),
                topRight: Radius.circular(Dimensions.borderRadius20 * 2),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: Dimensions.widtht10,
                  blurRadius: Dimensions.widtht10,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(Dimensions.height20),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Dimensions.borderRadius20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: Dimensions.widtht10,
                        blurRadius: Dimensions.widtht10,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(children: [
                    GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(false);
                        },
                        child: const Icon(Icons.remove,
                            color: AppColors.signColor)),
                    SizedBox(width: Dimensions.widtht10 / 2),
                    BigText(text: popularProduct.inCartItems.toString()),
                    SizedBox(width: Dimensions.widtht10 / 2),
                    GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(true);
                        },
                        child:
                            const Icon(Icons.add, color: AppColors.signColor)),
                  ]),
                ),
                GestureDetector(
                  onTap: () {
                    popularProduct.addItem(product);
                  },
                  child: Container(
                    padding: EdgeInsets.all(Dimensions.height20),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(Dimensions.borderRadius20),
                      color: AppColors.mainColor,
                    ),
                    child: BigText(
                      text: "\$ ${product.price!} | Add to cart",
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
