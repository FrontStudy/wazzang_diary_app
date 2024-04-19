import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../widgets/main/custom_app_bar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double safeTopMargin = MediaQuery.of(context).padding.top;
    double horizontalMargin = screenWidth * 0.025;
    double itemHeight = (screenWidth - horizontalMargin * 2) / 3;
    double contentPadding = 10;
    double contentWidth =
        screenWidth - horizontalMargin * 2 - itemHeight - contentPadding * 2;
    double filterBtnHeight = 40;
    double filterBtnMarin = 24;

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
            child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _filterBtnRow(
                        filterBtnMarin: filterBtnMarin,
                        filterBtnHeight: filterBtnHeight,
                        screenWidth: screenWidth);
                  }
                  return itemWidget(
                      height: itemHeight,
                      horizontalMargin: horizontalMargin,
                      contentPadding: contentPadding,
                      contentWidth: contentWidth);
                }),
          )),
    );
  }

  Widget itemWidget(
      {required double height,
      required double horizontalMargin,
      required double contentPadding,
      required double contentWidth}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: horizontalMargin),
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // 그림자 색상과 투명도
              spreadRadius: 1, // 그림자의 확산 정도
              blurRadius: 5, // 블러 효과의 반경
              offset: const Offset(0, 3), // 수평 및 수직 방향으로의 그림자 오프셋
            )
          ]),
      child: Row(
        children: [
          SizedBox(
            width: height,
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0)),
                child: Image.asset(
                  'assets/images/article_profile_sample.jpg',
                  fit: BoxFit.cover,
                  height: height,
                )),
          ),
          Padding(
            padding: EdgeInsets.all(contentPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: contentWidth,
                  child: const Text("제목입니다다아아아아아아아아아아",
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 20,
                        overflow: TextOverflow.ellipsis,
                      )),
                ),
                SizedBox(
                  width: contentWidth,
                  child: const Text(
                      "내용다아아아아아아아아아아아앙내용다아아아아아아아아아아아앙내용다아아아아아아아아아아아앙내용다아아아아아아아아아아아앙내용다아아아아아아아아아아아앙내용다아아아아아아아아아아아앙내용다아아아아아아아아아아아앙내용다아아아아아아아아아아아앙",
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _filterBtnRow(
      {required double filterBtnMarin,
      required double filterBtnHeight,
      required double screenWidth}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: filterBtnMarin / 2),
      height: filterBtnHeight,
      width: screenWidth,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const SizedBox(width: 10);
          }
          return Container(
            width: 80,
            margin: const EdgeInsets.only(right: 5),
            child: OutlinedButton(
              onPressed: () {},
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                side: MaterialStateProperty.all(
                    const BorderSide(color: Colors.grey)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              child: const Text(
                '최신순',
                style: TextStyle(color: Colors.black87),
              ),
            ),
          );
        },
      ),
    );
  }
}
