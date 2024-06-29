import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/routes/main_router.dart';
import '../../../core/themes/theme.dart';
import '../../blocs/member/member_bloc.dart';

class MenuItem {
  final IconData icon;
  final String title;
  final void Function() callback;

  MenuItem({
    required this.icon,
    required this.title,
    required this.callback,
  });
}

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    void logoutCallback() {
      context.read<MemberBloc>().add(SignOutMember());
      Navigator.of(context)
          .pushNamedAndRemoveUntil(AppRouter.signOut, ModalRoute.withName(''));
    }

    return Scaffold(
      backgroundColor: darkblueColor,
      appBar: AppBar(
        backgroundColor: darkblueColor,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close, color: Colors.white70),
        ),
        title: const Text('계정', style: TextStyle(color: Colors.white70)),
        centerTitle: false,
      ),
      body: SafeArea(
          child: Column(
        children: [
          _accountContainerWidget(),
          _menuListView(menu: [
            MenuItem(
                icon: Icons.logout, title: '로그 아웃', callback: logoutCallback)
          ]),
        ],
      )),
    );
  }

  Widget _accountContainerWidget() {
    return BlocBuilder<MemberBloc, MemberState>(builder: (context, state) {
      return Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        height: 90,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: ClipOval(
                  child: SizedBox(
                      width: 40,
                      height: 40,
                      child: state is MemberLogged &&
                              state.member.profilePicture != null
                          ? Image.network(
                              state.member.profilePicture!,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/person_placeholder.png',
                              fit: BoxFit.cover,
                            ))),
            ),
            const SizedBox(width: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state is MemberLogged ? "${state.member.name} 님" : "",
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  state is MemberLogged ? state.member.nickname : "",
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                )
              ],
            )
          ],
        ),
      );
    });
  }

  Widget _menuListView({required List<MenuItem> menu}) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: menu.length,
        itemBuilder: (context, index) {
          return ListTile(
            iconColor: Colors.white,
            onTap: menu[index].callback,
            leading: Icon(menu[index].icon),
            title: Text(menu[index].title,
                style: const TextStyle(color: Colors.white)),
          );
        },
      ),
    );
  }
}
