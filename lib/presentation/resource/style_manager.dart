import 'package:fashionshop/presentation/resource/color_manager.dart';
import 'package:flutter/material.dart';

import 'font_manager.dart';

TextStyle getTextStyle(
    double fontSize, String fontFamily, FontWeight fontWeight, Color color) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    fontWeight: fontWeight,
    color: color,
  );
}

// regular style

TextStyle hintStyle() {
  return getTextStyle(FontSize.s14, FontConstants.fontFamily,
      FontWeightManager.regular, ColorManager.lightBlue);
}

// regular style

TextStyle getRegularStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return getTextStyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.regular, color);
}

// light text style

TextStyle getLightStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return getTextStyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.light, color);
}

// bold text style

TextStyle getBoldStyle({required double fontSize, required Color color}) {
  return getTextStyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.bold, color);
}
// semiBold text style

TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return getTextStyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.semiBold, color);
}

// medium text style

TextStyle getMediumStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return getTextStyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.medium, color);
}
