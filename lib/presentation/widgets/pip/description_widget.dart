import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/themes/theme.dart';
import '../../bloc/main/drag_route_cubit.dart';
import '../../bloc/pip/segment_toggle/segment_toggle_cubit.dart';

class DescriptionWidget extends StatelessWidget {
  final double top;
  final double leftPadding;
  final double height;
  const DescriptionWidget({
    super.key,
    required this.top,
    required this.leftPadding,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Builder(builder: (context) {
      var dragState = context.select((DragRouteCubit cubit) => cubit.state);
      var toggleState =
          context.select((SegmentToggleCubit cubit) => cubit.state);
      bool visible = toggleState.first == SegmentToggle.image &&
          (dragState.firstScale != 0 || dragState.secondScale != 1);
      double opacity = dragState.secondScale > 0
          ? 1 - dragState.secondScale
          : dragState.firstScale;

      return Positioned(
        top: top * (1 - dragState.secondScale),
        child: Visibility(
          visible: visible,
          maintainState: true,
          child: Opacity(
            opacity: opacity,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: leftPadding),
              height: height,
              width: screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 8),
                    child: Text(
                      '제목입니다',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 45,
                            width: 45,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(1000),
                                child: Image.asset(
                                    'assets/images/user_profile_sample.jpg')),
                          ),
                          const SizedBox(width: 10),
                      Text(
                        '육성민',
                        style: TextStyle(color: Colors.grey[500], fontSize: 16),
                      ),
                          const SizedBox(width: 15),
                          SizedBox(
                            height: 35,
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: lightBlueColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14.0),
                                  // 원하는 여백 값을 EdgeInsets.symmetric을 사용하여 설정합니다.
                                ),
                                child: const Text(
                                  '구독',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 35,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: lightBlueColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14.0, vertical: 0.0),
                                  // 원하는 여백 값을 EdgeInsets.symmetric을 사용하여 설정합니다.
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.thumb_up_off_alt_outlined,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      '5천',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                )),
                            const SizedBox(width: 10),
                            ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: lightBlueColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14.0, vertical: 0.0),
                                  // 원하는 여백 값을 EdgeInsets.symmetric을 사용하여 설정합니다.
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.library_add_outlined,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      '저장',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 90,
                    width: screenWidth,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          alignment: Alignment.topLeft,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          backgroundColor: lightBlueColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14.0, vertical: 15.0),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '댓글',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 90,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          backgroundColor: lightBlueColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14.0, vertical: 15.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '댓글',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                ClipOval(
                                  child: Container(
                                    width: 26,
                                    height: 26,
                                    color: Colors.blue,
                                    child: Image.asset(
                                      'assets/images/user_profile_sample.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: ivoryColor,
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    height: 26,
                                    width: screenWidth -
                                        2 * leftPadding -
                                        26 -
                                        20 -
                                        28,
                                  ),
                                )
                              ],
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
