import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../widgets/main/custom_app_bar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenheight =
        MediaQuery.of(context).size.height - firstBottombarHeight;
    var paddingTop = MediaQuery.of(context).padding.top;
    double screenWidth = MediaQuery.of(context).size.width;
    double horizontalMargin = screenWidth * 0.025;
    double itemHeight = (screenWidth - horizontalMargin * 2) / 3;
    double contentPadding = 10;
    double contentWidth =
        screenWidth - horizontalMargin * 2 - itemHeight - contentPadding * 2;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
          color: Colors.grey[50],
          child: Column(
            children: [
              SizedBox(
                height: screenheight - paddingTop - 50,
                // padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return itemWidget(
                          height: itemHeight,
                          horizontalMargin: horizontalMargin,
                          contentPadding: contentPadding,
                          contentWidth: contentWidth);
                    }),
              ),
            ],
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
                child: Image.asset('assets/images/user_profile_sample.jpg')),
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
}
