import 'package:flutter/material.dart';

TextStyle _getTextStyle(
        {required double fontSize,
        required FontWeight fontWeight,
        required Color color}) =>
    TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
    );

// regular style
TextStyle getRegularStyle({double fontSize = 12, Color color = Colors.black}) =>
    _getTextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      color: color,
    );

// medium style
TextStyle getMediumStyle(
        {double fontSize = 12, required Color color}) =>
    _getTextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      color: color,
    );

// light style
TextStyle getLightStyle(
        {double fontSize = 12, Color color = Colors.black}) =>
    _getTextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w300,
      color: color,
    );
// bold style
TextStyle getBoldStyle(
        {double fontSize = 12, Color color = Colors.black}) =>
    _getTextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      color: color,
    );
