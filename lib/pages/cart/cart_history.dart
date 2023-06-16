import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: AppColors.mainColor,
            width: double.infinity,
            height: 100,
            padding: EdgeInsets.only(top: 45,left: 10,right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                 BigText(
                  text: "Cart History",
                  color: Colors.white,
                ),
               const AppIcon(icon: Icons.shopping_cart_outlined,backgroundColor: AppColors.yellowColor,)
              ],
            ),
          ),
        ],
      )
    );
  }
}
