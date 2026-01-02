import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  Future<T?> push<T>(Widget child) async {
    return Navigator.push(this, MaterialPageRoute(builder: (context) => child));
  }

  Future<void> pushAndRemoveUntil(Widget child) async {
    Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute(builder: (context) => child),
      (context) => false,
    );
  }

  Future<void> pop() async {
    Navigator.pop(this);
  }

  ColorScheme get cs {
    return ColorScheme.of(this);
  }
}
