import 'package:flutter/material.dart';
import 'package:income_calculator/shared/sized_shared.dart';

Widget titleText({required String text}) => Align(
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: AppText.px15.ls1p5.bold,
      ),
    );

    Widget titleLeft({required String text}) => Align(
      alignment: Alignment.topLeft,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: AppText.px15.ls1p5.bold,
      ),
    );