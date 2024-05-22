import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/themes/theme.dart';
import '../../widgets/main/custom_app_bar.dart';

class SharedDiaryPage extends StatelessWidget {
  const SharedDiaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    const double articleImageSize = 90;
    const double listViewHorizontalMargin = 25;
    const double listItemPadding = 15;
    final double titleWidth = screenWidth -
        articleImageSize -
        listViewHorizontalMargin * 2 -
        listItemPadding * 2 -
        5;
    const double profileWidth = 20;
    const double profileGap = 5;
    final double nicknameWidth = titleWidth - profileWidth - profileGap - 5;

    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: const CustomAppBar(),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "친구들의 마음 속 이야기",
                        style: GoogleFonts.gamjaFlower(
                          textStyle: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
              return Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(listItemPadding),
                decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey[200]!, width: 0.5)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: articleImageSize,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ClipOval(
                                    child: Container(
                                      width: profileWidth,
                                      height: profileWidth,
                                      color: Colors.blue,
                                      child: Image.asset(
                                        'assets/images/person_placeholder.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: profileGap),
                                  SizedBox(
                                      width: nicknameWidth,
                                      child: const Text(
                                        "닉네임을 넣을까 이름을 넣을까 넣을까 말까아아아아",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ))
                                ],
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: titleWidth,
                                child: const Text(
                                    "일기 제목은 몇 글자까지 가능??? 일기 제목은 몇 글자까지 가능??? 일기 제목은 몇 글자까지 가능??? ",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)),
                              )
                            ],
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/images/article_image_placeholder.jpg',
                            width: articleImageSize,
                            height: articleImageSize,
                            fit: BoxFit.cover,
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 70,
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "18 hours ago",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          SizedBox(
                              height: 30,
                              child: CustomButtonWithShadow(
                                child: const Text("♡ Liked"),
                                onPressed: () {},
                              ))
                        ],
                      ),
                    ),
                    const Text(
                      '오늘 난 눈물을 흘린다. 배고프다. 춥다. 하지만 나는 괜찮다. 왜냐하면 난 젊으니까...........sldfjlskdjflksjdflksjdflksjdflkjflsdkjflskdjflskdjfsdlfkjsdlkfjsldkfjsldkfjsldkfjlskdfjsldfkjsldkfj',
                      maxLines: 3,
                      overflow: TextOverflow.fade,
                      style: TextStyle(),
                    )
                  ],
                ),
              );
            },
          ),
        ));
  }
}

class CustomButtonWithShadow extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const CustomButtonWithShadow(
      {super.key, required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 80,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: darkIvoryColor,
          border: Border.all(color: darkblueColor, width: 1.5),
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
              color: darkblueColor,
              spreadRadius: 1,
              offset: Offset(3, 3),
            ),
          ],
        ),
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.white),
          child: child,
        ),
      ),
    );
  }
}
