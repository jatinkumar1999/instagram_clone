import 'package:flutter/material.dart';

class LikeAnimation extends StatefulWidget {
  final Widget? child;
  const LikeAnimation({super.key, this.child});

  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<LikeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isShowLikeAnimation = false;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..addListener(() {})
          ..addStatusListener((status) {
            if (status == AnimationStatus.forward) {
              isShowLikeAnimation = true;
              setState(() {});
            } else if (status == AnimationStatus.completed) {
              _controller.reverse();

              isShowLikeAnimation = false;

              setState(() {});
            }
          });
    _animation = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isShowLikeAnimation
          ? ScaleTransition(
              scale: _animation,
              child: widget.child ??
                  const Icon(
                    Icons.favorite,
                    size: 120,
                    color: Colors.red,
                  ))
          : const SizedBox(),
    );
  }
}
