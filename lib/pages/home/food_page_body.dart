import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommeneded_product_controller.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_and_text_widget.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../routers/router_helper.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  final double _scaleFactor = .8;
  final double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
        print(_currentPageValue.toString());
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isLoaded
              ? SizedBox(
                  height: Dimensions.pageView,
                  child: PageView.builder(
                      itemCount: popularProducts.popularProductList.length,
                      physics: const BouncingScrollPhysics(),
                      controller: pageController,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, position) {
                        return _buildPageItem(position,
                            popularProducts.popularProductList[position]);
                      }),
                )
              : SizedBox(
                  height: Dimensions.pageView,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.mainColor,
                    ),
                  ),
                );
        }),
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            position: _currentPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        SizedBox(
          height: Dimensions.height30,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.widtht30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: 'Recommeneded'),
              SizedBox(
                width: Dimensions.widtht10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimensions.widtht10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: "Food pairings"),
              ),
            ],
          ),
        ),
        // list food and images
        SizedBox(
          height: Dimensions.height20,
        ),
        GetBuilder<RecommenededProductController>(
            builder: (recommenededProduct) {
          return recommenededProduct.isLoaded
              ? ListView.builder(
                  itemCount: recommenededProduct.recommenededProductList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouterHelper.getRecommendedFood(index));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.widtht20,
                            bottom: Dimensions.height20,
                            right: Dimensions.height20),
                        child: Row(children: [
                          Container(
                            width: Dimensions.listViewImageSize,
                            height: Dimensions.listViewImageSize,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.borderRadius15),
                              color: Colors.red,
                              image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://cdn.sforum.vn/sforum/wp-content/uploads/2023/01/Raiden-Shogun-Build-Guide-For-Genshin-Impact.jpg'),
                              ),
                            ),
                          ),
                          // text container
                          Expanded(
                            child: Container(
                              height: Dimensions.listViewTextContentSize,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(
                                      Dimensions.borderRadius15),
                                  bottomRight: Radius.circular(
                                      Dimensions.borderRadius15),
                                ),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: Dimensions.widtht10,
                                  right: Dimensions.widtht10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    BigText(
                                        text: recommenededProduct
                                            .recommenededProductList[index]
                                            .name!),
                                    SmallText(
                                        text: recommenededProduct
                                            .recommenededProductList[index]
                                            .location!),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        IconAndTextWidget(
                                            icon: Icons.circle_sharp,
                                            text: "Normal",
                                            iconColor: AppColors.yellowColor),
                                        IconAndTextWidget(
                                            icon: Icons.location_on,
                                            text: "1.7",
                                            iconColor: AppColors.mainColor),
                                        IconAndTextWidget(
                                          icon: Icons.access_time_sharp,
                                          text: "32",
                                          iconColor: AppColors.iconColor2,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    );
                  })
              : SizedBox(
                  height: Dimensions.listViewImageSize,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.mainColor,
                    ),
                  ),
                );
        })
        //
      ],
    );
  }

  Widget _buildPageItem(int index, ProductElement productElement) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTranslation = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTranslation, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currTranslation = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTranslation, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - currScale) / 2, 0);
    } else {
      var currScale = .8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - currScale) / 2, 0);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouterHelper.getPopularFood(index));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.widtht10, right: Dimensions.widtht10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.borderRadius30),
                color: index.isEven
                    ? const Color(0xFF69c5df)
                    : const Color(0xFFf7b7b7),
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://cdn.sforum.vn/sforum/wp-content/uploads/2023/01/Raiden-Shogun-Build-Guide-For-Genshin-Impact.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.widtht30,
                  right: Dimensions.widtht30,
                  bottom: Dimensions.height30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.borderRadius20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, -2),
                  )
                ],
              ),
              child: Container(
                  padding: EdgeInsets.only(
                      left: Dimensions.height15,
                      right: Dimensions.height15,
                      top: Dimensions.height15),
                  child: AppColumn(
                    text: productElement.name,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
