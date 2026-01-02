import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  final Widget child;
  final bool safeAreaTop;
  final EdgeInsets padding;
  final AppBar? appBar;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  const BasePage({
    super.key,
    this.appBar,
    required this.child,
    this.safeAreaTop = true,
    this.padding = const .all(16),
    this.floatingActionButtonLocation,
    this.floatingActionButton,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        top: safeAreaTop,
        child: Padding(padding: padding, child: child),
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
