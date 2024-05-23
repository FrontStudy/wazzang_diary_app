import 'package:flutter/material.dart';

import '../themes/theme.dart';

class CustomButtonWithShadow extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double width;

  const CustomButtonWithShadow(
      {super.key,
      required this.onPressed,
      required this.child,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: darkIvoryColor,
          border: Border.all(color: darkblueColor, width: 1.5),
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
              color: darkblueColor,
              spreadRadius: 1,
              offset: Offset(3, 3),
            ),
          ],
        ),
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.white),
          child: child,
        ),
      ),
    );
  }
}
