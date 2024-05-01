import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/constants.dart';
import '../../blocs/diary/pub_diary_bloc.dart';
import '../../widgets/home/home_diary_list_view.dart';
import '../../widgets/main/custom_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    context.read<PubDiaryBloc>().add(FetchFirstDiaries());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double safeTopMargin = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: screenHeight -
                safeTopMargin -
                firstBottombarHeight -
                pipHeight -
                appBarHeight,
            child: BlocBuilder<PubDiaryBloc, PubDiaryState>(
                builder: (context, state) {
              if (state is PubDiaryFailed) {
                debugPrint(state.failure.toString());
                return Container();
              } else if (state is PubDiaryLoaded) {
                return HomeDiaryListView(data: state.diariesWithMembers);
              } else {
                return Container();
              }
            }),
          ),
        ],
      )),
    );
  }
}
