import 'package:flutter/material.dart';
import 'package:travelmatex/utils/constants/constants.dart';

class FadeTextAnimation extends StatefulWidget {
  const FadeTextAnimation({super.key});

  @override
  FadeTextAnimationState createState() => FadeTextAnimationState();
}

class FadeTextAnimationState extends State<FadeTextAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    final fadeTween = Tween<double>(begin: 0.0, end: 1.0);
    final delayTween = Tween<double>(begin: 1.0, end: 1.0);
    final fadeCurve =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _animation = TweenSequence([
      TweenSequenceItem<double>(
        tween: fadeTween,
        weight: 1,
      ),
      TweenSequenceItem<double>(
        tween: delayTween,
        weight: 5,
      ),
    ]).animate(fadeCurve);

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (BuildContext context, Widget? child) {
            return Opacity(
              opacity: _animation.value,
              child: Text('TRAVELMATE',
                  style: googleFontStyle(
                      color: Colors.white,
                      fontsize: 50,
                      fontweight: FontWeight.bold)),
            );
          },
        ),
      ),
    );
  }
}
