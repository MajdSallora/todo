

  import 'package:flutter/material.dart';

double? _screenWidth;
  double? _screenHeight;

extension Context on BuildContext {

  double _getWidth() {
    _screenWidth ??= MediaQuery.of(this).size.width;
    return _screenWidth!;
  }

  double _getHeight() {
    _screenHeight ??= MediaQuery.of(this).size.height;
    return _screenHeight!;
  }
  TextTheme _getStyle(){
    return Theme.of(this).textTheme;
  }

  double get screenWidth => _getWidth();

  double get screenHeight => _getHeight();

  TextTheme get textTheme => _getStyle();
}
