import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CreateTaskAnimatedButton extends StatefulWidget {
  final Duration duration;

  final Widget child;

  final ScrollController scrollController;

  const CreateTaskAnimatedButton({
    super.key,
    this.duration = const Duration(milliseconds: 800),
    required this.child,
    required this.scrollController,
  });

  @override
  State<CreateTaskAnimatedButton> createState() =>
      _CreateTaskAnimatedButtonState();
}

class _CreateTaskAnimatedButtonState extends State<CreateTaskAnimatedButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<Offset> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: widget.duration);
    animation = Tween<Offset>(
      begin: const Offset(0, 1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    controller.forward();

    widget.scrollController.addListener(() {
      if (!controller.isAnimating) {
        if (widget.scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          controller.reverse();
        } else if (widget.scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
          controller.reset();
          controller.forward();
        } else if (widget.scrollController.position.userScrollDirection ==
            ScrollDirection.idle) {
          controller.forward();
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(position: animation, child: widget.child);
  }
}
