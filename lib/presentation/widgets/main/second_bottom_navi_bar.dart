import 'package:flutter/material.dart';

class SecondBottomNaviBar extends StatelessWidget {
  final double height;

  const SecondBottomNaviBar({required this.height, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
          color: Colors.green,
        ),
        height: height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Flexible(
              child: SizedBox(
                height: 8,
              ),
            ),
            Flexible(
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
              ),
            )
          ],
        ));
  }
}
