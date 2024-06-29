import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazzang_diary/presentation/blocs/main/bottom_navigation_bar_cubit.dart';

import '../../../core/routes/main_router.dart';
import '../../../core/themes/theme.dart';
import '../../blocs/member/member_bloc.dart';
import '../../blocs/profile/profile_bloc.dart';

class FirstBottomNaviBar extends StatelessWidget {
  const FirstBottomNaviBar({required this.height, super.key});
  final double height;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final tabBarItemWidth = screenWidth / 5;
    return Container(
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
                width: tabBarItemWidth,
                index: 0,
                icon: Icons.home,
                label: '홈',
                link: '/',
                color: state == 0 ? activeIconColor : iconColor),
            _tabBarItem(
                context: context,
                height: height,
                width: tabBarItemWidth,
                index: 1,
                icon: Icons.search,
                label: '돌아보기',
                link: '/Search',
                color: state == 1 ? activeIconColor : iconColor),
            _tabBarItemForAdd(
                context: context,
                height: height,
                width: tabBarItemWidth,
                color: ivoryColor),
            _tabBarItem(
                context: context,
                height: height,
                width: tabBarItemWidth,
                index: 2,
                icon: Icons.people_alt_outlined,
                label: '공유일기',
                link: '/Search',
                color: state == 2 ? activeIconColor : iconColor),
            _tabBarItemWithOnlyImage(
                context: context,
                height: height,
                width: tabBarItemWidth,
                index: 3,
                icon: Icons.person,
                link: '/Search',
                color: state == 3 ? activeIconColor : iconColor,
                onTap: () {
                  context
                      .read<ProfileBloc>()
                      .add(FetchOwnMemberInfoAndFirstDiaries());
                }),
          ],
        );
      }),
    );
  }

  Widget _tabBarItem(
      {required BuildContext context,
      required double height,
      required double width,
      required int index,
      required IconData icon,
      required String label,
      required String link,
      required Color color}) {
    return InkWell(
      onTap: () {
        // context.read<NavigatorKeyCubit>().state.currentState!.pushNamed(link);
        context.read<BottomNavigationBarCubit>().changeIndex(index);
      },
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        width: width,
        child: Column(
          children: [
            Flexible(
                child: Icon(
              icon,
              color: color,
              size: 25,
            )),
            Flexible(
                child:
                    Text(label, style: TextStyle(color: color, fontSize: 10))),
          ],
        ),
      ),
    );
  }

  Widget _tabBarItemForAdd(
      {required BuildContext context,
      required double height,
      required double width,
      required Color color}) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(AppRouter.selectDiaryImage);
      },
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        width: width,
        child: Column(
          children: [
            Flexible(
                child: Icon(
              Icons.add_circle_outline_rounded,
              color: color,
              size: 35,
            )),
          ],
        ),
      ),
    );
  }

  Widget _tabBarItemWithOnlyImage(
      {required BuildContext context,
      required double height,
      required double width,
      required int index,
      required IconData icon,
      required String link,
      required Color color,
      VoidCallback? onTap}) {
    return InkWell(
      onTap: () {
        if (onTap != null) onTap();
        context.read<BottomNavigationBarCubit>().changeIndex(index);
      },
      child: Container(
        padding: const EdgeInsets.only(top: 12),
        width: width,
        child: Column(
          children: [
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: color, width: 3),
                    borderRadius: BorderRadius.circular(999)),
                child: ClipOval(
                  child: Container(
                      width: 26,
                      height: 26,
                      color: Colors.blue,
                      child: BlocBuilder<MemberBloc, MemberState>(
                          builder: (context, state) {
                        if (state is MemberLogged &&
                            state.member.profilePicture != null) {
                          return Image.network(
                            state.member.profilePicture!,
                            fit: BoxFit.cover,
                          );
                        } else {
                          return Image.asset(
                            'assets/images/person_placeholder.png',
                            fit: BoxFit.cover,
                          );
                        }
                      })),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
