import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.height,
    required this.pressed,
    required this.child,
    this.elevation,
    required this.color,
    required this.width,
    required this.borderRadius,
  });

  final double height;
  final double width;
  final Function() pressed;
  final Widget child;
  final Color color;
  final double? elevation;
  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: pressed,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double?>(elevation),
        minimumSize: MaterialStateProperty.all<Size>(Size(width, height)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: borderRadius,
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(color),
      ),
      child: child,
    );
  }
}
