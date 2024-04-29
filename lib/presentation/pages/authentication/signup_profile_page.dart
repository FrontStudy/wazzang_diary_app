import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../core/error/failures.dart';
import '../../../core/themes/theme.dart';
import '../../../domain/usecases/member/sign_up_usecase.dart';
import '../../../domain/usecases/signup/set_profile_image_usecase.dart';
import '../../blocs/member/member_bloc.dart';
import '../../blocs/signup/profile_image_bloc.dart';

class SignUpProfilePage extends StatefulWidget {
  final Map<String, dynamic> info;

  const SignUpProfilePage({required this.info, super.key});

  @override
  State<SignUpProfilePage> createState() => _SignUpProfilePageState();
}

class _SignUpProfilePageState extends State<SignUpProfilePage> {
  void _pickProfileImage() async {
    try {
      final imagePicker = ImagePicker();
      final imageFile =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (imageFile != null && mounted) {
        context
            .read<ProfileImageBloc>()
            .add(SetProfileImage(SetProfileImageParams(imageFile: imageFile)));
      }
    } catch (e) {
      print(e);
    }
  }

  void _signUpSummit() async {
    final profileState = context.read<ProfileImageBloc>().state;
    String? profileUrl;
    if (profileState is ProfileImageAdded) {
      profileUrl = profileState.image.storagePath;
    }

    context.read<MemberBloc>().add(SignUpMember(SignUpParams(
        email: widget.info['email'],
        passwd: widget.info['passwd'],
        birthDate: widget.info['birthDate'],
        gender: widget.info['gender'],
        name: widget.info['name'],
        nickname: widget.info['nickname'],
        profilePicture: profileUrl)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MemberBloc, MemberState>(
        listener: (context, state) {
          EasyLoading.dismiss();
          if (state is MemberLoading) {
            EasyLoading.show(status: 'Loading...');
          } else if (state is MemberLogged) {
            EasyLoading.showSuccess('로그인 성공');
          } else if (state is MemberLoggedFail) {
            if (state.failure is DuplicateFailure) {
              EasyLoading.showError("중복된 이메일입니다.");
            } else {
              EasyLoading.showError("Error");
            }
          }
        },
        child: Scaffold(
          backgroundColor: ivoryColor,
          appBar: AppBar(
            backgroundColor: ivoryColor,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "프로필 사진 추가",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                        "친구들이 회원님을 알아볼 수 있도록 프로필 사진을 추가하세요. 프로필 사진은 모든 사람에게 공개됩니다."),
                    const SizedBox(height: 40),
                    BlocBuilder<ProfileImageBloc, ProfileImageState>(
                        builder: (context, state) {
                      if (state is ProfileImageAdded) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: Image.network(
                            state.image.storagePath,
                            width: 250,
                            height: 250,
                            fit: BoxFit.cover,
                          ),
                        );
                      } else if (state is ProfileImageLoading) {
                        return SizedBox(
                          width: 250,
                          height: 250,
                          child: Center(
                            child: LoadingAnimationWidget.threeArchedCircle(
                                color: darkblueColor, size: 200),
                          ),
                        );
                      } else {
                        return const CircleAvatar(
                          maxRadius: 100,
                          backgroundImage: AssetImage(
                              "assets/images/person_placeholder.png"),
                        );
                      }
                    }),
                  ],
                ),
                BlocBuilder<ProfileImageBloc, ProfileImageState>(
                    builder: (context, state) {
                  return Column(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            state is ProfileImageAdded
                                ? _signUpSummit()
                                : _pickProfileImage();
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => darkblueColor),
                              foregroundColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.white),
                              overlayColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.white12),
                              textStyle: MaterialStateTextStyle.resolveWith(
                                  (states) => const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              fixedSize: MaterialStatePropertyAll(Size(
                                  MediaQuery.of(context).size.width - 20, 45))),
                          child: Text(
                              state is ProfileImageAdded ? '완료' : '사진 추가')),
                      const SizedBox(height: 10),
                      ElevatedButton(
                          onPressed: () {
                            state is ProfileImageAdded
                                ? _pickProfileImage()
                                : _signUpSummit();
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.white),
                              foregroundColor: MaterialStateColor.resolveWith(
                                  (states) => darkblueColor),
                              textStyle: MaterialStateTextStyle.resolveWith(
                                  (states) => const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              fixedSize: MaterialStatePropertyAll(Size(
                                  MediaQuery.of(context).size.width - 20, 45))),
                          child: Text(
                              state is ProfileImageAdded ? '사진 변경' : '건너뛰기')),
                      const SizedBox(height: 40)
                    ],
                  );
                })
              ],
            ),
          ),
        ));
  }
}
