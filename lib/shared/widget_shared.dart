import 'package:flutter/material.dart';
import 'package:income_calculator/shared/color_shared.dart';
import 'package:income_calculator/shared/sized_shared.dart';
import 'package:sizer/sizer.dart';
import 'package:group_button/group_button.dart';
Widget rowtitlevalue({required String title, required String value}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Align(
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
          Text(
            value,
            style:
                const TextStyle(letterSpacing: 0.8, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    ),
  );
}


Widget primaryButton(
        {required Color color,
        required String text,
        required Function() onCliked}) =>
    InkWell(
      onTap: onCliked,
      child: Container(
        height: 5.33.h,
        decoration:
            BoxDecoration(border: Border.all(color: color), color: color),
        padding: EdgeInsets.symmetric(vertical: 0.7.h),
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.1.w),
          child: Text(
            text,
            style: AppText.px15.bold.customColor(blackColors),
          ),
        ),
      ),
    );


    Widget groupButton(
        {required BuildContext context,
        required List<String> frameList,
        required GroupButtonController controller,
        required Function(String data, int index, bool isSelected) onCliked}) =>
    Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.8.h),
        child: GroupButton(
            options: GroupButtonOptions(
                alignment: Alignment.center,
                buttonHeight: (MediaQuery.of(context).size.height * 0.04),
                buttonWidth: (MediaQuery.of(context).size.width / 4) - 16,
                spacing: 10,
                runSpacing: 10,
                mainGroupAlignment: MainGroupAlignment.start,
                crossGroupAlignment: CrossGroupAlignment.start,
                groupRunAlignment: GroupRunAlignment.start,
                textAlign: TextAlign.center,
                textPadding: EdgeInsets.zero,
                elevation: 0,
                groupingType: GroupingType.wrap,
                borderRadius: BorderRadius.circular(5),
                direction: Axis.horizontal,
                selectedColor: primaryColor,
                unselectedColor: grey,
                selectedTextStyle: const TextStyle(color: whiteColor),
                unselectedTextStyle: const TextStyle(color: whiteColor)),
            isRadio: true,
       controller:  controller,
            onSelected: onCliked,
            buttons: frameList),
      ),
    );

