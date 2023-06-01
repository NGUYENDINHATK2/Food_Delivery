import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
                left: Dimensions.widtht20,
                right: Dimensions.widtht20,
                top: Dimensions.height10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: AppIcon(
                        icon: Icons.arrow_back_ios,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconSize: Dimensions.iconSize24,
                      ),
                    ),
                    // ignore: avoid_unnecessary_containers
                    Container(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const MainFoodPage());
                            },
                            child: AppIcon(
                              icon: Icons.home_outlined,
                              iconColor: Colors.white,
                              backgroundColor: AppColors.mainColor,
                              iconSize: Dimensions.iconSize24,
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          AppIcon(
                            icon: Icons.shopping_cart,
                            iconColor: Colors.white,
                            backgroundColor: AppColors.mainColor,
                            iconSize: Dimensions.iconSize24,
                          ),
                        ],
                      ),
                    )
                  ],
                )),
            Positioned(
                top: Dimensions.height20 * 3,
                left: Dimensions.widtht20,
                right: Dimensions.widtht20,
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.only(top: Dimensions.height15),
                  // color: Colors.redAccent,
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GetBuilder<CartController>(builder: (cartController){
                      return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: cartController.getItems.length,
                          itemBuilder: (_, index) {
                            return Container(
                              height: Dimensions.height20 * 5,
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  Container(
                                    height: Dimensions.height20 * 5,
                                    width: Dimensions.height20 * 5,
                                    margin: EdgeInsets.only(bottom: Dimensions.height10),
                                    decoration: BoxDecoration(
                                        image: const DecorationImage(
                                            image: NetworkImage(
                                                'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg'),
                                            fit: BoxFit.cover),
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(Dimensions.borderRadius20)
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.widtht10,),
                                  Expanded(child: Container(
                                    height: Dimensions.height20 * 5,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        BigText(text: cartController.getItems[index].name!,color: Colors.black54,),
                                        SmallText(text: "gun",),
                                        Row(
                                          children: [
                                            BigText(text:"\$ "+ cartController.getItems[index]!.price.toString(),color: Colors.black54,),
                                            Expanded(
                                              child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    GestureDetector(
                                                      // onTap: () {
                                                      //   popularProduct.setQuantity(false);
                                                      // },
                                                        child: const Icon(Icons.remove,
                                                            color: AppColors.signColor)),
                                                    SizedBox(width: Dimensions.widtht10 / 2),
                                                    BigText(text: "1"),
                                                    SizedBox(width: Dimensions.widtht10 / 2),
                                                    GestureDetector(
                                                      // onTap: () {
                                                      //   popularProduct.setQuantity(true);
                                                      // },
                                                        child:
                                                        const Icon(Icons.add, color: AppColors.signColor)),
                                                  ]),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                                ],
                              ),
                            );
                          });
                    },),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
