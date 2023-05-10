import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/small_text.dart';

class ExandableTextWidget extends StatefulWidget {
  final String text;
  const ExandableTextWidget({
    super.key,
    required this.text,
  });

  @override
  State<ExandableTextWidget> createState() => _ExandableTextWidgetState();
}

class _ExandableTextWidgetState extends State<ExandableTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hideText = true;
  double textHeight = Dimensions.screenHeight / 5.63;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmallText(size: Dimensions.fontSize20, text: firstHalf)
          : Column(
              children: [
                SmallText(
                  text:
                      hideText ? (firstHalf + "...") : (firstHalf + secondHalf),
                  size: Dimensions.fontSize16,
                  color: AppColors.paraColor,
                  height: 1.8,
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SmallText(
                        height: 1.8,
                        text: hideText ? "Show more" : "show less",
                        color: AppColors.mainColor,
                      ),
                      Icon(
                        hideText ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                        color: AppColors.mainColor,
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      hideText = !hideText;
                    });
                  },
                ),
              ],
            ),
    );
  }
}
