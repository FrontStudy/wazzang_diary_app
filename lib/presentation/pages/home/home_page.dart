import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../widgets/main/custom_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
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
            child: ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: screenWidth,
                  height: screenWidth + 110,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            'assets/images/article_profile_sample.jpg',
                            fit: BoxFit.cover,
                            height: screenWidth,
                            width: screenWidth,
                          ),
                          GradientMaskWidget(
                            isUpward: true,
                            child: SizedBox(
                              width: screenWidth,
                              child: Container(
                                  color: const Color.fromARGB(1, 0, 0, 0),
                                  height: 80),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: GradientMaskWidget(
                              isUpward: false,
                              child: SizedBox(
                                width: screenWidth,
                                child: Container(
                                    color: const Color.fromARGB(1, 0, 0, 0),
                                    height: 130),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              padding: const EdgeInsets.all(25),
                              height: 80,
                              width: screenWidth,
                              alignment: Alignment.center,
                              child: const FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '만약 내가 이곳을 떠난다면 우짤까?',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Color.fromARGB(225, 255, 255, 255),
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: 35,
                                      width: 35,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(1000),
                                          child: Image.asset(
                                              'assets/images/user_profile_sample.jpg')),
                                    ),
                                    const SizedBox(width: 10),
                                    const Column(
                                      children: [
                                        SizedBox(
                                          height: 18,
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              '닉네임',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 17,
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text('추천',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 28,
                                  width: 60,
                                  child: OutlinedButton(
                                      style: ButtonStyle(
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.zero),
                                        side: MaterialStateProperty.all(
                                            const BorderSide(
                                                color: Colors.white70)),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: const Text(
                                        '팔로우',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            height: 1),
                                      )),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: 110,
                        width: screenWidth,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 40,
                              width: screenWidth,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          margin: const EdgeInsets.all(5),
                                          height: 30,
                                          width: 30,
                                          child: GestureDetector(
                                            child: const Icon(
                                                Icons.favorite_border),
                                          )),
                                      Container(
                                          margin: const EdgeInsets.all(5),
                                          height: 30,
                                          width: 30,
                                          child: GestureDetector(
                                            child: const Icon(
                                                Icons.textsms_outlined),
                                          )),
                                    ],
                                  ),
                                  Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          5, 5, 10, 5),
                                      height: 30,
                                      width: 30,
                                      child: GestureDetector(
                                        child:
                                            const Icon(Icons.bookmark_outline),
                                      )),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    child: FittedBox(
                                        child: Text(
                                      '좋아요 268,457개',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    )),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 18,
                                        child: FittedBox(
                                          child: Text('catluv_seetcat',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      SizedBox(
                                        height: 18,
                                        child: FittedBox(
                                          child: Text(
                                            '2주 ・ ',
                                            style: TextStyle(
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 3),
                                      SizedBox(
                                        height: 18,
                                        child: FittedBox(
                                          child: Text(
                                            '와우우우',
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 2),
                                  SizedBox(
                                    height: 20,
                                    child: FittedBox(
                                        child: Text(
                                      '댓글 828개 모두 보기',
                                      style: TextStyle(color: Colors.black54),
                                    )),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}

class GradientMaskWidget extends StatelessWidget {
  final Widget child;
  final bool isUpward;

  const GradientMaskWidget(
      {super.key, required this.child, required this.isUpward});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: const [Colors.transparent, Color.fromARGB(255, 0, 0, 0)],
          begin: isUpward ? Alignment.bottomCenter : Alignment.topCenter,
          end: isUpward ? Alignment.topCenter : Alignment.bottomCenter,
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcOut,
      child: child,
    );
  }
}
