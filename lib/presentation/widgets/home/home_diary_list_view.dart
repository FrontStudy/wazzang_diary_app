import 'package:flutter/material.dart';
import 'package:wazzang_diary/domain/entities/diary/diary_with_member.dart';

import '../../pages/common/gradient_widget.dart';

class HomeDiaryListView extends StatelessWidget {
  final List<DiaryWithMember> data;
  const HomeDiaryListView({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemCount: data.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return _diaryItemWidget(
            screenWidth: screenWidth, diaryWithMember: data[index]);
      },
    );
  }

  Widget _diaryItemWidget(
      {required double screenWidth, required DiaryWithMember diaryWithMember}) {
    return SizedBox(
      width: screenWidth,
      height: screenWidth + 110,
      child: Column(
        children: [
          Stack(
            children: [
              diaryWithMember.diary.imgUrl != null
                  ? Image.network(diaryWithMember.diary.imgUrl!)
                  : Image.asset(
                      'assets/images/article_image_placeholder.jpg',
                      fit: BoxFit.cover,
                      height: screenWidth,
                      width: screenWidth,
                    ),
              GradientMaskWidget(
                isUpward: true,
                child: SizedBox(
                  width: screenWidth,
                  child: Container(
                      color: const Color.fromARGB(1, 0, 0, 0), height: 80),
                ),
              ),
              Positioned(
                bottom: 0,
                child: GradientMaskWidget(
                  isUpward: false,
                  child: SizedBox(
                    width: screenWidth,
                    child: Container(
                        color: const Color.fromARGB(1, 0, 0, 0), height: 130),
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
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      diaryWithMember.diary.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 35,
                          width: 35,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(1000),
                              child: diaryWithMember.author.profilePicture !=
                                      null
                                  ? Image.network(
                                      diaryWithMember.author.profilePicture!)
                                  : Image.asset(
                                      'assets/images/person_placeholder.png')),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          children: [
                            SizedBox(
                              height: 18,
                              child: Text(
                                diaryWithMember.author.name,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text('회원님을 위한 추천',
                                    style: TextStyle(color: Colors.white)),
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
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                            side: MaterialStateProperty.all(
                                const BorderSide(color: Colors.white70)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            '팔로우',
                            style: TextStyle(
                                color: Colors.white, fontSize: 12, height: 1),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                              margin: const EdgeInsets.all(5),
                              height: 30,
                              width: 30,
                              child: GestureDetector(
                                child: const Icon(Icons.favorite_border),
                              )),
                          Container(
                              margin: const EdgeInsets.all(5),
                              height: 30,
                              width: 30,
                              child: GestureDetector(
                                child: const Icon(Icons.textsms_outlined),
                              )),
                        ],
                      ),
                      Container(
                          margin: const EdgeInsets.fromLTRB(5, 5, 10, 5),
                          height: 30,
                          width: 30,
                          child: GestureDetector(
                            child: const Icon(Icons.bookmark_outline),
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                        child: FittedBox(
                            child: Text(
                          '좋아요 268,457개',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        )),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 18,
                            child: FittedBox(
                              child: Text(diaryWithMember.author.nickname,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                          const SizedBox(width: 5),
                          const SizedBox(
                            height: 18,
                            child: FittedBox(
                              child: Text(
                                '2주 ・ ',
                                style: TextStyle(color: Colors.black54),
                              ),
                            ),
                          ),
                          const SizedBox(width: 3),
                          const SizedBox(
                            height: 18,
                            child: FittedBox(
                              child: Text(
                                '와우우우',
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 2),
                      const SizedBox(
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
  }
}
