import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/constants.dart';
import '../../../core/routes/main_router.dart';
import '../../../core/themes/theme.dart';
import '../../blocs/member/member_bloc.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: lightBlueColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      leadingWidth: 200,
      leading: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 10),
          Text(
            '우리의 일기',
            style: GoogleFonts.gamjaFlower(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 28,
              ),
            ),
          ),
        ],
      ),
      actions: [
        // IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(AppRouter.account);
          },
          borderRadius: BorderRadius.circular(1000),
            child: const Icon(
              Icons.settings,
              color: Colors.white,
            )
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(appBarHeight);
}
