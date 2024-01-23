import 'package:flutter/material.dart';

class VerticalSpace extends StatelessWidget {
  const VerticalSpace({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: size);
  }
}

class HorizontalSpace extends StatelessWidget {
  const HorizontalSpace({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: size);
  }
}
