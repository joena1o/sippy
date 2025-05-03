import 'package:flutter/material.dart';
import 'package:sippy_ca/core/app_colors.dart';

class FontClass {
  static TextStyle navFontBlackNoSpace =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

  static TextStyle navFontBlack =
      const TextStyle(fontSize: 14, fontWeight: FontWeight.normal);

  static TextStyle headerStyleBlackNormal =
      const TextStyle(fontSize: 22, fontWeight: FontWeight.w500);

  static TextStyle headerStyleMediumBlack = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static TextStyle headerStyleBlack =
      const TextStyle(fontSize: 23, fontWeight: FontWeight.w600);

  static TextStyle priceFontRegular = const TextStyle(
    fontSize: 14,
    fontFamily: "Poppins",
    fontWeight: FontWeight.w600,
  );

  static TextStyle priceFontMedium = const TextStyle(
    fontSize: 16,
    fontFamily: "Poppins",
    fontWeight: FontWeight.w600,
  );

  static TextStyle priceFontLarge = const TextStyle(
    fontSize: 20,
    fontFamily: "Poppins",
    fontWeight: FontWeight.w700,
  );

  static TextStyle tertiarySmall = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.tertiaryColor);
}
