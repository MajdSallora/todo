import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF4458DD);
  static const Color secondary = Color(0xFFFF8800);
  static const Color grey = Color(0xFF767982);
  static Color lightGrey = Colors.grey.shade200;
  static const Color red = Colors.red;
  static const Color green = Colors.green;
  static const Color black = Colors.black;


  static Color fromHex(String hexString) {
    try{
      final buffer = StringBuffer();
      if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
      buffer.write(hexString.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    }catch(_){
      return Colors.white;
    }
  }
}