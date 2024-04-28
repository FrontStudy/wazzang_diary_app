import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../domain/usecases/signup/set_profile_image_usecase.dart';
import '../../blocs/signup/profile_image_bloc.dart';

class SignUpProfilePage extends StatefulWidget {
  final Map<String, dynamic> info;

  const SignUpProfilePage({required this.info, super.key});

  @override
  State<SignUpProfilePage> createState() => _SignUpProfilePageState();
}

class _SignUpProfilePageState extends State<SignUpProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
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
                      backgroundImage:
                          AssetImage("assets/images/person_placeholder.png"),
                    );
                  }
                }),
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                    onPressed: () async {
                      try {
                        final imagePicker = ImagePicker();
                        final imageFile = await imagePicker.pickImage(
                            source: ImageSource.gallery);
                        if (imageFile != null && mounted) {
                          context.read<ProfileImageBloc>().add(SetProfileImage(
                              SetProfileImageParams(imageFile: imageFile)));
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => darkblueColor),
                        foregroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.white),
                        overlayColor: MaterialStateColor.resolveWith(
                            (states) => Colors.white12),
                        textStyle: MaterialStateTextStyle.resolveWith(
                            (states) =>
                                const TextStyle(fontWeight: FontWeight.bold)),
                        fixedSize: MaterialStatePropertyAll(
                            Size(MediaQuery.of(context).size.width - 20, 45))),
                    child: const Text('사진 추가')),
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () {
                      //건너뛰기
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.white),
                        foregroundColor: MaterialStateColor.resolveWith(
                            (states) => darkblueColor),
                        textStyle: MaterialStateTextStyle.resolveWith(
                            (states) =>
                                const TextStyle(fontWeight: FontWeight.bold)),
                        fixedSize: MaterialStatePropertyAll(
                            Size(MediaQuery.of(context).size.width - 20, 45))),
                    child: const Text('건너뛰기')),
                const SizedBox(height: 40)
              ],
            )
          ],
        ),
      ),
    );
  }
}
