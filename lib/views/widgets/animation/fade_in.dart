import 'package:flutter/material.dart';

enum FadeInDirection { ltr, rtl, btt, ttb }

class FadeInAnimation extends StatefulWidget {
  const FadeInAnimation(
      {super.key,
      required this.child,
      required this.delay,
      required this.direction,
      required this.fadeOffset});
  final Widget child;
  final double delay;
  final FadeInDirection direction;
  final double fadeOffset;
  @override
  State<FadeInAnimation> createState() => _FadeInAnimationState();
}

class _FadeInAnimationState extends State<FadeInAnimation>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> opacityAnimation;
  late Animation<double> inAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: (500 * widget.delay).round()));
    inAnimation = Tween<double>(begin: -widget.fadeOffset, end: 0)
        .animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    opacityAnimation =
        Tween<double>(begin: 0, end: 1).animate(_animationController)
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();
    return Transform.translate(
      offset: switch (widget.direction) {
        FadeInDirection.ltr => Offset(inAnimation.value, 0),
        FadeInDirection.rtl => Offset(-inAnimation.value, 0),
        FadeInDirection.btt => Offset(0, 0 - inAnimation.value),
        FadeInDirection.ttb => Offset(0, inAnimation.value),
      },
      child: Opacity(
        opacity: opacityAnimation.value,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
