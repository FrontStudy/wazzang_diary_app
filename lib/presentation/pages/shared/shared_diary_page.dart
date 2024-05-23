import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../widgets/main/custom_app_bar.dart';
import '../../widgets/shared/shared_diary_list_view.dart';

class SharedDiaryPage extends StatelessWidget {
  const SharedDiaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double safeTopMargin = MediaQuery.of(context).padding.top;

    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: const CustomAppBar(),
        body: SizedBox(
            height: screenHeight -
                safeTopMargin -
                firstBottombarHeight -
                pipHeight -
                appBarHeight,
            child: const SharedDiaryListView()
        ));
  }
}
