import 'dart:ui';

import 'package:flutter/material.dart';

class CustomGlassEffect extends StatelessWidget {
  final double blur;
  final double opacity;
  final Widget child;
  final double bottomRight;
  final double bottomLeft;
  final double topRight;
  final double topLeft;
  final double width;
  final double height;
  // ignore: use_super_parameters
  const CustomGlassEffect({
    Key? key,
    required this.blur,
    required this.opacity,
    required this.child,
    required this.bottomRight,
    required this.bottomLeft,
    required this.topRight,
    required this.topLeft,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(bottomLeft),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blur,
          sigmaY: blur,
        ),
        child: AnimatedContainer(
          width: width,
          height: height,
          duration: const Duration(microseconds: 150),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.secondary.withOpacity(0.7),
              Theme.of(context).colorScheme.secondary.withOpacity(0.7)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(bottomRight),
                bottomRight: Radius.circular(bottomRight),
                topLeft: Radius.circular(topLeft),
                topRight: Radius.circular(topRight)),
          ),
          child: child,
        ),
      ),
    );
  }
}
