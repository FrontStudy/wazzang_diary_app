import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey[50],
      elevation: 0,
      scrolledUnderElevation: 0,
      leadingWidth: 100,
      leading: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 10),
          Text(
            '우리의 일기',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ],
      ),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(1000),
          child: ClipOval(
            child: Container(
              width: 30, // 이미지의 너비
              height: 30, // 이미지의 높이
              color: Colors.blue, // 원의 배경색
              child: Image.asset(
                'assets/images/user_profile_sample.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(appBarHeight);
}
