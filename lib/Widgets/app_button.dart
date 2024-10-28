import 'package:flutter/material.dart';
import '../Utils/app_constants.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color? backColor;
  const AppButton(
      {super.key,
      required this.child,
      required this.onPressed,
      this.backColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              backgroundColor: backColor ?? primaryColor),
          onPressed: onPressed,
          child: child),
    );
  }
}

class AppSmallButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color? backColor;
  const AppSmallButton(
      {super.key,
      required this.child,
      required this.onPressed,
      this.backColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            backgroundColor: backColor ?? primaryColor),
        onPressed: onPressed,
        child: child);
  }
}

class AppSmallButtonBorder extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color? backColor;
  final double? horizontalPadding, verticalPadding, borderRadius;
  const AppSmallButtonBorder(
      {super.key,
      required this.child,
      required this.onPressed,
      this.horizontalPadding,
      this.verticalPadding,
      this.borderRadius,
      this.backColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 12)),
            padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding ?? 50,
                vertical: verticalPadding ?? 10),
            backgroundColor: backColor ?? primaryColor),
        onPressed: onPressed,
        child: child);
  }
}
