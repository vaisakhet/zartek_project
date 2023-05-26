import 'package:flutter/material.dart';

class App {
  BuildContext? _context;
  double? _height;
  double? _width;
  double? _heightPadding;
  double? _widthPadding;

  App(_context) {
    this._context = _context;

    MediaQueryData _quaryData = MediaQuery.of(this._context!);
    _height = _quaryData.size.height / 100.0;
    _width = _quaryData.size.width / 100.0;
    _heightPadding = _height! -
        ((_quaryData.padding.top + _quaryData.padding.bottom) / 100.0);
    _widthPadding = _width! -
        ((_quaryData.padding.left + _quaryData.padding.right) / 100.0);
  }

  double appHeight(double d) {
    return _height! * d;
  }

  double appWidth(double d) {
    return _width! * d;
  }

  double appVerticalPadding(double d) {
    return _heightPadding! * d;
  }

  double appHorizotalPadding(double d) {
    return _widthPadding! * d;
  }
}
