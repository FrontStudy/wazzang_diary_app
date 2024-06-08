import 'package:flutter/material.dart';

import '../../widgets/main/custom_app_bar.dart';
import '../../widgets/profile/my_profile_header.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyProfileHeader(),
            Center(
              child: Text("MyProfilePage"),
            ),
          ],
        ),
      ),
    );
  }
}
