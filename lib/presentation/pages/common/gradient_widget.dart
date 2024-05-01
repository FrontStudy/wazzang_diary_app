import 'package:flutter/material.dart';

class GradientMaskWidget extends StatelessWidget {
  final Widget child;
  final bool isUpward;

  const GradientMaskWidget(
      {super.key, required this.child, required this.isUpward});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: const [Colors.transparent, Color.fromARGB(255, 0, 0, 0)],
          begin: isUpward ? Alignment.bottomCenter : Alignment.topCenter,
          end: isUpward ? Alignment.topCenter : Alignment.bottomCenter,
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcOut,
      child: child,
    );
  }
}
