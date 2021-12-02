import 'package:flutter/material.dart';

class ViewHelper {
  static ColorFilter filterNone = 
    ColorFilter.mode(Colors.transparent.withOpacity(0.0), BlendMode.srcOver);

  static ColorFilter filterGreyscale = 
    ColorFilter.matrix(<double>[
    0.2126 , 0.7152 , 0.0722 , 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0,      0,      0,      1, 0,]);
}