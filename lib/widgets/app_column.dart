import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/small_text.dart';
import '../utils/dimensions.dart';

class AppColumn extends StatelessWidget {
  final String text;

  const AppColumn({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: Dimensions.fontSize26,
        ),
        SizedBox(height: Dimensions.height10),
        Row(
          children: <Widget>[
            Wrap(
              children: List.generate(5, (index) {
                return const Icon(
                  Icons.star,
                  color: AppColors.mainColor,
                );
              }),
            ),
            const SizedBox(
              width: 5,
            ),
            SmallText(text: "4.5"),
            const SizedBox(
              width: 5,
            ),
            SmallText(text: "1560"),
            const SizedBox(
              width: 5,
            ),
            SmallText(text: "c"),
          ],
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            IconAndTextWidget(
                icon: Icons.circle_sharp,
                text: "No",
                iconColor: AppColors.yellowColor),
            IconAndTextWidget(
                icon: Icons.location_on,
                text: "1.7",
                iconColor: AppColors.mainColor),
            IconAndTextWidget(
                icon: Icons.access_time_sharp,
                text: "32",
                iconColor: AppColors.iconColor2),
          ],
        ),
      ],
    );
  }
}
