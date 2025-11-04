// ignore_for_file: file_names
import "package:flutter/material.dart";

class CustomMorphisum extends StatelessWidget {
  final double radius;
  final double width;
  final double height;
  final Widget child;
  // ignore: use_super_parameters
  const CustomMorphisum(
      {Key? key,
      required this.radius,
      required this.height,
      required this.width,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: Theme.of(context).colorScheme.secondary,
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).colorScheme.tertiary,
                offset: const Offset(-5, -5),
                blurRadius: 10,
                spreadRadius: 1),
            BoxShadow(
                color: Theme.of(context).colorScheme.primary,
                offset: const Offset(5, 5),
                blurRadius: 10,
                spreadRadius: 1)
          ]),
      child: child,
    );
  }
}
