import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../widgets/main/custom_app_bar.dart';
import '../../widgets/search/search_diary_list_view.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double safeTopMargin = MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
          color: Colors.grey[50],
          child: SizedBox(
            height: screenHeight -
                safeTopMargin -
                firstBottombarHeight -
                pipHeight -
                appBarHeight,
            child: const SearchDiaryListView(),
          )),
    );
  }
}
