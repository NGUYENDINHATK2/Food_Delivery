import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

    var getCartHistoryList=Get.find<CartController>()
        .getCartHistoryList.reversed.toList();

    Map<String,int> cartItemsOrder=Map();

    for(int i=0;i<getCartHistoryList.length;i++){
      if(cartItemsOrder.containsKey(getCartHistoryList[i].time)){
        cartItemsOrder.update(getCartHistoryList[i].time!,(value)=>++value);
      }else{
        cartItemsOrder.putIfAbsent(getCartHistoryList[i].time!,()=>1);
      }
    }
    List<int> cartOrderTimeToList(){
      return cartItemsOrder.entries.map((e)=>e.value).toList();
    }
    List<int> itemsPerOrder=cartOrderTimeToList();
    var listCouter=0;

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
               const AppIcon(icon: Icons.shopping_cart_outlined,backgroundColor: AppColors.yellowColor,iconColor: Colors.white,)
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
                  for(int i=1;i<itemsPerOrder.length;i++)
                    Container(
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
                                    height: 80,
                                    width: 80,
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
                                height: 80,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SmallText(text: "Total",color: AppColors.titleColor,),
                                    BigText(text: itemsPerOrder[i].toString()+" Items",color: AppColors.titleColor,),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: Dimensions.widtht10,vertical: Dimensions.height10/2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(Dimensions.borderRadius15/3),
                                        border: Border.all(color: AppColors.mainColor,width: 1),
                                      ),
                                      child: SmallText(text:"one more",color: AppColors.mainColor,),
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
