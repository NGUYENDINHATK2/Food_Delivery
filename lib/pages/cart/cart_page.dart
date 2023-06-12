import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommeneded_product_controller.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/routers/router_helper.dart';
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
                              Get.toNamed(RouterHelper.getInitial());
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
                      var _cartList=cartController.getItems;
                      return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: _cartList.length,
                          itemBuilder: (_, index) {
                            return Container(
                              height: Dimensions.height20 * 5,
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      var popularIndex=Get.find<PopularProductController>()
                                          .popularProductList
                                          .indexWhere((element) => element.id==_cartList[index].id);
                                      if(popularIndex>=0){
                                          Get.toNamed(RouterHelper.getPopularFood(popularIndex,"cartPage"));
                                      }else{
                                        var recommendedIndex=Get.find<RecommenededProductController>()
                                            .recommenededProductList
                                            .indexWhere((element) => element.id==_cartList[index].id);
                                        if(recommendedIndex>=0){
                                          Get.toNamed(RouterHelper.getRecommendedFood(recommendedIndex,"cartPage"));
                                        }
                                      }
                                    },
                                    child: Container(
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
                                                      onTap: () {
                                                        cartController.addItem(_cartList[index].product!,-1);
                                                      },
                                                        child: const Icon(Icons.remove,
                                                            color: AppColors.signColor)),
                                                    SizedBox(width: Dimensions.widtht10 / 2),
                                                    BigText(text: _cartList[index].quantity.toString()),
                                                    SizedBox(width: Dimensions.widtht10 / 2),
                                                    GestureDetector(
                                                      onTap: () {
                                                        cartController.addItem(_cartList[index].product!,1);
                                                      },
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
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (cartController) {
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
                    SizedBox(width: Dimensions.widtht10 / 2),
                    BigText(text:"\$ "+ cartController.totalAmount.toString(),color: Colors.black54,),
                    SizedBox(width: Dimensions.widtht10 / 2),
                  ]),
                ),
                GestureDetector(
                  onTap: () {
                    cartController.addToHistory();
                  },
                  child: Container(
                    padding: EdgeInsets.all(Dimensions.height20),
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(Dimensions.borderRadius20),
                      color: AppColors.mainColor,
                    ),
                    child: BigText(
                      text: "Check out",
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
