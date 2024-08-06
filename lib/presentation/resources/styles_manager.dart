import 'package:flutter/material.dart';
import 'package:initial/presentation/resources/font_manager.dart';

TextStyle _getTextstyle(
    double fontSize, String fontFamily, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      color: color);
}

//Regular style

TextStyle getRegularStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextstyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.regular, color);
}

//Light Text style

TextStyle getLightStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextstyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.light, color);
}

//Bold Text style

TextStyle getBoldStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextstyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.bold, color);
}

//SemiBold Text style

TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextstyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.semiBold, color);
}

//Medium Text style

TextStyle getMediumStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextstyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.medium, color);
}
