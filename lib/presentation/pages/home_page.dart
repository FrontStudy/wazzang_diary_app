import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Container(
                color: Colors.white,
                child: const Center(child: Text('HomePage')))),
      ],
    );
  }
}
