import 'package:flutter/material.dart';

extension CustomDouble on double {
  int toAlpha() {
    return (this * 255).round();
  }
}

extension CustomInt on int {
  Widget heightBox() {
    return SizedBox(height: this.toDouble());
  }

  Widget widthBox() {
    return SizedBox(height: this.toDouble());
  }
}
