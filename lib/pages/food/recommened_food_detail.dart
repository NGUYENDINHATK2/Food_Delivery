import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/recommeneded_product_controller.dart';
import '../../routers/router_helper.dart';
import '../../widgets/exandable_text_widget.dart';
import '../cart/cart_page.dart';

class RecommenedFoodDetail extends StatelessWidget {
  final int pageId;

  const RecommenedFoodDetail({Key? key, required this.pageId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommenededProductController>()
        .recommenededProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 100,
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          Get.toNamed(RouterHelper.getInitial());
                        },
                        child: const AppIcon(icon: Icons.clear)),
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
                  ]),
              pinned: true,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(20),
                child: Container(
                  width: double.maxFinite,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Center(
                      child: BigText(
                    text: product.name!,
                    size: Dimensions.fontSize26,
                  )),
                ),
              ),
              backgroundColor: AppColors.yellowColor,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  'https://cdn.sforum.vn/sforum/wp-content/uploads/2023/01/Raiden-Shogun-Build-Guide-For-Genshin-Impact.jpg',
                  fit: BoxFit.cover,
                  width: double.maxFinite,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        left: Dimensions.widtht20, right: Dimensions.widtht20),
                    child: ExandableTextWidget(text: product.description!),
                  )
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (controller) {
            return Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                padding: EdgeInsets.only(
                  left: Dimensions.widtht20 * 2.5,
                  right: Dimensions.widtht20 * 2.5,
                  top: Dimensions.widtht10,
                  bottom: Dimensions.widtht10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.setQuantity(false);
                      },
                      child: AppIcon(
                        icon: Icons.remove,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                        iconSize: Dimensions.iconSize24,
                      ),
                    ),
                    BigText(
                      text: "\$ ${product.price} X  ${controller.inCartItems} ",
                      color: AppColors.mainBlackColor,
                      size: Dimensions.fontSize20,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.setQuantity(true);
                      },
                      child: AppIcon(
                        icon: Icons.add,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                        iconSize: Dimensions.iconSize24,
                      ),
                    )
                  ],
                ),
              ),
              Container(
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
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.favorite,
                          color: AppColors.mainColor,
                        )),
                    GestureDetector(
                      onTap: () {
                        controller.addItem(product);
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
              ),
            ]);
          },
        ));
  }
}
