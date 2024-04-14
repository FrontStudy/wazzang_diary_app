import 'package:flutter/material.dart';

import '../../widgets/main/custom_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          Expanded(
              child: Container(
                  color: Colors.grey[50],
                  child: const Center(child: Text('HomePage')))),
        ],
      ),
    );
  }
}
