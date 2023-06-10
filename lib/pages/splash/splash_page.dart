import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/routers/router_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommeneded_product_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {

  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResources() async {
   await Get.find<PopularProductController>().getPopularProductList();
   await Get.find<RecommenededProductController>().getRecommenededProductList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadResources();
    controller = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this)..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    Timer(
      Duration(seconds: 4), () => Get.offNamed(RouterHelper.getInitial())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
              scale: animation,
              child: Center(
                  child: Lottie.network("https://mocki.io/v1/6aea7fbe-1235-4b17-b883-3b7330d418e4",
                      width: Dimensions.splashImg,
                      height: Dimensions.splashImg,
                      repeat: true,
                      animate: true,
                      frameRate: FrameRate(60)))
          ),
          ScaleTransition(
              scale: animation,
              child: BigText(text: "The Best Food",
                color: AppColors.mainColor,
                size: 45,)
          ),
        ],
      ),
    );
  }
}
