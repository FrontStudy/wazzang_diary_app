import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../core/routes/main_router.dart';
import '../../../core/themes/theme.dart';
import '../../../domain/usecases/signup/set_profile_image_usecase.dart';
import '../../blocs/signup/profile_image_bloc.dart';
import '../../../domain/entities/member/image/image.dart' as profile_img;

class SelectDiaryImagePage extends StatefulWidget {
  const SelectDiaryImagePage({super.key});

  @override
  State<SelectDiaryImagePage> createState() => _SelectDiaryImagePageState();
}

class _SelectDiaryImagePageState extends State<SelectDiaryImagePage> {
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
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close, color: Colors.white),
        ),
        title: const Text('새 일기',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                profile_img.Image? image;
                final currentState = context.read<ProfileImageBloc>().state;
                if (currentState is ProfileImageAdded) {
                  image = currentState.image;
                }
                Navigator.of(context).pushNamed(AppRouter.writeDiary,
                    arguments: {"image": image});
              },
              child: const Text(
                "다음",
                style: TextStyle(color: Colors.blue),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                const SizedBox(height: 30),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "커버 이미지 선택",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(height: 30),
                BlocBuilder<ProfileImageBloc, ProfileImageState>(
                    builder: (context, state) {
                  final screenWidth = MediaQuery.of(context).size.width;
                  if (state is ProfileImageAdded) {
                    return Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.network(
                          state.image.storagePath,
                          width: screenWidth - 40,
                          height: screenWidth - 40,
                          fit: BoxFit.cover,
                        ),
                        IconButton(
                            onPressed: () {
                              context
                                  .read<ProfileImageBloc>()
                                  .add(DeleteProfileImage());
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ))
                      ],
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
                    return GestureDetector(
                      onTap: () => _pickProfileImage(),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.5),
                              BlendMode.darken,
                            ),
                            child: Image.asset(
                              "assets/images/article_image_placeholder.jpg",
                              width: screenWidth - 40,
                              height: screenWidth - 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 50,
                          )
                        ],
                      ),
                    );
                  }
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
