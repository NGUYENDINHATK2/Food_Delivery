import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;
  static double pageView = screenHeight / 2.64;
  static double pageViewContainer = screenHeight / 3.84;
  static double pageViewTextContainer = screenHeight / 7.03;

  //?dynamic height padding and margin
  static double height10 = screenHeight / 88.4;
  static double height15 = screenHeight / 56.27;
  static double height20 = screenHeight / 44.2;
  static double height30 = screenHeight / 29.47;
  static double height45 = screenHeight / 19.64;

  //?dynamic width padding and margin
  static double widtht10 = screenHeight / 88.4;
  static double widtht15 = screenHeight / 56.27;
  static double widtht20 = screenHeight / 44.2;
  static double widtht30 = screenHeight / 29.47;

  static double fontSize20 = screenHeight / 44.2;
  static double fontSize16 = screenHeight / 56.27;
  static double fontSize26 = screenHeight / 34.15;

  static double borderRadius15 = screenHeight / 56.27;
  static double borderRadius20 = screenHeight / 44.2;
  static double borderRadius30 = screenHeight / 29.47;
  // icon size
  static double iconSize24 = screenHeight / 37.04;

  // list view 
  static double listViewImageSize=screenWidth/3.25;
  static double listViewTextContentSize=screenWidth/3.9;

  //  popular food detail
  static double popularFoodDetailImageSize=screenHeight/2.14;

  // bottom height
  static double bottomHeightBar=screenHeight/7.03;

//  splash screen dimensions
  static double splashImg=screenHeight/3.38;

}
