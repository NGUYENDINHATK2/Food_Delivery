import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../controllers/cart_controller.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({super.key});

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList=Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String,int> cartItemsOrder=Map();
    for(int i=0;i<getCartHistoryList.length;i++){
      if(cartItemsOrder.containsKey(getCartHistoryList[i].time)){
        cartItemsOrder.update(getCartHistoryList[i].time!,(value)=>++value);
      }else{
        cartItemsOrder.putIfAbsent(getCartHistoryList[i].time!,()=>1);
      }
    }
    List<int> cartItemsPerOrderToList(){
      return cartItemsOrder.entries.map((e)=>e.value).toList();
    }

    List<String> cartOrderTimeToList(){
      return cartItemsOrder.entries.map((e)=>e.key).toList();
    }


    List<int> itemsPerOrder=cartItemsPerOrderToList();

    var listCouter=0;
    return Scaffold(
    body: Column(
        children: [
          Container(
            color: AppColors.mainColor,
            width: double.infinity,
            height: Dimensions.height10*10,
            padding: EdgeInsets.only(top: Dimensions.height45,left: 10,right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                 BigText(
                  text: "Cart History",
                  color: Colors.white,
                ),
               GestureDetector(onTap: (){
                  var test=Get.find<CartController>()
                      .getCartHistoryList();
                  for(int i=0;i<test.length;i++){
                    print(test[i].time);
                  }
               },child: const AppIcon(icon: Icons.shopping_cart_outlined,backgroundColor: AppColors.yellowColor,iconColor: Colors.white,))
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: Dimensions.widtht20,vertical: Dimensions.height20),
              child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView(
                physics:const BouncingScrollPhysics(),
                children: [
                  for(int i=0;i<itemsPerOrder.length;i++)
                    Container(
                      height: Dimensions.height30*4,
                      margin: EdgeInsets.only(bottom: Dimensions.height20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ((){
                            DateTime parseDate=  DateFormat("yyyy-MM-dd hh:mm:ss").parse(getCartHistoryList[i].time!);
                            var inputDate = DateTime.parse(parseDate.toString());
                            var outputFormat =  DateFormat("MM/dd/yyyy hh:mm a");
                            var date = outputFormat.format(inputDate);
                            return BigText(text: date,color: AppColors.titleColor);
                          }()),
                          SizedBox(height: Dimensions.height10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Wrap(
                                direction: Axis.horizontal,
                                children:List.generate(itemsPerOrder[i], (index){
                                  if(listCouter<getCartHistoryList.length){
                                    listCouter++;
                                  }
                                  return index<=2?Container(
                                    height: Dimensions.height20*4,
                                    width: Dimensions.height20*4,
                                    margin: EdgeInsets.only(right: Dimensions.widtht10/2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image:const DecorationImage(
                                        image: NetworkImage("https://wallpapercave.com/wp/wp11137323.jpg"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ):Container();
                                }),
                              ),
                              Container(
                                height: Dimensions.height20*4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SmallText(text: "Total",color: AppColors.titleColor,),
                                    BigText(text: itemsPerOrder[i].toString()+" Items",color: AppColors.titleColor,),
                                    GestureDetector(
                                      onTap: (){
                                        var orderTime=cartOrderTimeToList();
                                        Map<int,CartModel> moreOrder={};
                                        for(int j=0;j<getCartHistoryList.length;j++){
                                            if(getCartHistoryList[j].time==orderTime[i]){
                                            moreOrder.putIfAbsent(getCartHistoryList[j].id!,()=>
                                              CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j])))
                                            );
                                          }
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: Dimensions.widtht10,vertical: Dimensions.height10/2),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(Dimensions.borderRadius15/3),
                                          border: Border.all(color: AppColors.mainColor,width: 1),
                                        ),
                                        child: SmallText(text:"one more",color: AppColors.mainColor,),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                ],
              )
              ),
            ),
          ),
        ],
      )
    );
  }
}
