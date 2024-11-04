import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.height,
    required this.pressed,
    required this.child,
    this.elevation,
    required this.color,
    this.width,
    required this.borderRadius,
  });

  final double? height;
  final double? width;
  final Function()? pressed;
  final Widget child;
  final Color color;
  final double? elevation;
  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: pressed,
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return Colors.white54;
            }
            return Colors.white;
          },
        ),
        backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return color.withOpacity(.5);
            }
            return color;
          },
        ),
        elevation: WidgetStateProperty.all<double?>(elevation),
        minimumSize: WidgetStateProperty.all<Size>(
            width != null && height != null
                ? Size(width!, height!)
                : const Size(double.infinity, 60)),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: borderRadius,
          ),
        ),
      ),
      child: child,
    );
  }
}
