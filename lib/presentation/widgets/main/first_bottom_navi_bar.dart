import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazzang_diary/presentation/blocs/main/bottom_navigation_bar_cubit.dart';

import '../../../core/themes/theme.dart';

class FirstBottomNaviBar extends StatelessWidget {
  const FirstBottomNaviBar({required this.height, super.key});
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0),
      color: lightBlueColor,
      height: height,
      width: MediaQuery.of(context).size.width,
      child:
          BlocBuilder<BottomNavigationBarCubit, int>(builder: (context, state) {
        Color iconColor = Colors.white;
        Color activeIconColor = lightYellowColor;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _tabBarItem(
                context: context,
                height: height,
                index: 0,
                icon: Icons.home,
                label: '홈',
                link: '/',
                color: state == 0 ? activeIconColor : iconColor),
            _tabBarItem(
                context: context,
                height: height,
                index: 1,
                icon: Icons.search,
                label: '돌아보기',
                link: '/Search',
                color: state == 1 ? activeIconColor : iconColor),
            _tabBarItem(
                context: context,
                height: height,
                index: 2,
                icon: Icons.people_alt_outlined,
                label: '공유일기',
                link: '/Search',
                color: state == 2 ? activeIconColor : iconColor),
            _tabBarItem(
                context: context,
                height: height,
                index: 3,
                icon: Icons.person,
                label: '내 일기',
                link: '/Search',
                color: state == 3 ? activeIconColor : iconColor),
          ],
        );
      }),
    );
  }

  Widget _tabBarItem(
      {required BuildContext context,
      required double height,
      required int index,
      required IconData icon,
      required String label,
      required String link,
      Color? color}) {
    return SizedBox(
      height: height,
      child: GestureDetector(
        onTap: () {
          // context.read<NavigatorKeyCubit>().state.currentState!.pushNamed(link);
          context.read<BottomNavigationBarCubit>().changeIndex(index);
        },
        child: Column(
          children: [
            Flexible(child: Icon(icon, color: color)),
            Flexible(
                child:
                    Text(label, style: TextStyle(color: color, fontSize: 10))),
          ],
        ),
      ),
    );
  }
}
