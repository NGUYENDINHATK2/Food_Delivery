import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../controllers/recommeneded_product_controller.dart';
import '../../routers/router_helper.dart';
import '../../widgets/exandable_text_widget.dart';

class RecommenedFoodDetail extends StatelessWidget {
  final int pageId;

  const RecommenedFoodDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommenededProductController>()
        .recommenededProductList[pageId];
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
                  const AppIcon(icon: Icons.shopping_cart_outlined),
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
      bottomNavigationBar: Column(mainAxisSize: MainAxisSize.min, children: [
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
              AppIcon(
                icon: Icons.remove,
                backgroundColor: AppColors.mainColor,
                iconColor: Colors.white,
                iconSize: Dimensions.iconSize24,
              ),
              BigText(
                text: "\$ ${product.price} X  0 ",
                color: AppColors.mainBlackColor,
                size: Dimensions.fontSize20,
              ),
              AppIcon(
                icon: Icons.add,
                backgroundColor: AppColors.mainColor,
                iconColor: Colors.white,
                iconSize: Dimensions.iconSize24,
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
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: AppColors.mainColor,
                  )),
              Container(
                padding: EdgeInsets.all(Dimensions.height20),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(Dimensions.borderRadius20),
                  color: AppColors.mainColor,
                ),
                child: BigText(
                  text: "\$10 | Add to cart",
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
