import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/converter.dart';
import '../../blocs/profile/profile_bloc.dart';

class MyProfileHeader extends StatelessWidget {
  const MyProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const double headerHorizontalPadding = 20;
    const double headerVerticalPadding = 8;
    const double profileImageWidth = 90;
    const double gap = 30;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(
          vertical: headerVerticalPadding, horizontal: headerHorizontalPadding),
      height: 150,
      width: screenWidth,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _profileImageWidget(
              height: 150,
              width: profileImageWidth,
              verticalPadding: headerVerticalPadding),
          const SizedBox(width: gap),
          _countingWidget(
            height: profileImageWidth,
            width: screenWidth -
                headerHorizontalPadding * 2 -
                profileImageWidth -
                gap,
            topPadding: headerVerticalPadding,
          ),
        ],
      ),
    );
  }

  Widget _profileImageWidget({
    required double height,
    required double width,
    required double verticalPadding,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      height: height - verticalPadding * 2,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _profileImagePlaceholder(width: width),
          const SizedBox(
              height: 20,
              child: Text(
                'Yuk songmin',
                maxLines: 1,
                style: TextStyle(fontWeight: FontWeight.w500),
              ))
        ],
      ),
    );
  }

  Widget _profileImagePlaceholder({required double width}) {
    return GestureDetector(
      onTap: () {
        debugPrint("Clicked");
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipOval(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5),
                BlendMode.darken,
              ),
              child: Image.asset(
                "assets/images/person_placeholder.png",
                height: width,
                width: width,
              ),
            ),
          ),
          const Icon(
            Icons.camera_alt,
            color: Colors.white,
            size: 35,
          )
        ],
      ),
    );
  }

  Widget _profileImageView({required double width, required String imgUrl}) {
    return GestureDetector(
      onTap: () {
        debugPrint("Clicked");
      },
      child: ClipOval(
        child: Image.network(
          imgUrl,
          height: width,
          width: width,
        ),
      ),
    );
  }

  Widget _countingWidget({
    required double height,
    required double width,
    required double topPadding,
  }) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      String postCnt = "0", followerCnt = "0", followingCnt = "0";
      if (state is ProfileLoaded) {
        postCnt = parseToKorean(state.info.diaryCount);
        followerCnt = parseToKorean(state.info.followerCount);
        followingCnt = parseToKorean(state.info.followingCount);
      }
      return Container(
        margin: EdgeInsets.only(top: topPadding),
        height: height,
        width: width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(postCnt), const Text('posts')],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(followerCnt), const Text('followers')],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(followingCnt), const Text('following')],
            ),
          ],
        ),
      );
    });
  }
}
