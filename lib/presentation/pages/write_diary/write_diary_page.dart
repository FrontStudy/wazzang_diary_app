import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../core/themes/theme.dart';
import '../../../domain/entities/member/image/image.dart' as profile_img;
import '../../../domain/usecases/signup/check_email_usecase.dart';
import '../../blocs/email_check/email_check_bloc.dart';

class WriteDiaryPage extends StatefulWidget {
  final profile_img.Image? image;

  const WriteDiaryPage({super.key, required image})
      : image = image is profile_img.Image ? image : null;

  @override
  State<WriteDiaryPage> createState() => _WriteDiaryPageState();
}

class _WriteDiaryPageState extends State<WriteDiaryPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final List<bool> _sharingSelection = [true, false];

  InputDecoration _inputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(color: Colors.grey[600]),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey[400]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey[400]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: darkblueColor, width: 2.0),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding:
          const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
    );
  }

  _verifyAndAddEmail(BuildContext context, String email) {
    context
        .read<EmailCheckBloc>()
        .add(VerifyEmail(CheckEmailParams(email: email)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios, color: darkblueColor),
        ),
        title: const Text('새 일기',
            style: TextStyle(color: darkblueColor, fontSize: 20)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: widget.image != null
                                ? Image.network(
                                    widget.image!.storagePath,
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    "assets/images/article_image_placeholder.jpg",
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: _titleController,
                            decoration: _inputDecoration('제목'),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: _contentController,
                            maxLines: 6,
                            decoration: _inputDecoration('내용'),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: _descriptionController,
                            maxLines: 2,
                            decoration: _inputDecoration('설명'),
                          ),
                          const SizedBox(height: 20),
                          ToggleButtons(
                            isSelected: _sharingSelection,
                            onPressed: (int index) {
                              setState(() {
                                for (int i = 0;
                                    i < _sharingSelection.length;
                                    i++) {
                                  _sharingSelection[i] = i == index;
                                }
                              });
                            },
                            borderRadius: BorderRadius.circular(10),
                            selectedBorderColor: darkblueColor,
                            selectedColor: Colors.white,
                            fillColor: darkblueColor,
                            color: Colors.black,
                            constraints: const BoxConstraints(
                              minHeight: 40.0,
                              minWidth: 100.0,
                            ),
                            children: const [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text('전체 공개'),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text('친구 공유'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          if (_sharingSelection[1])
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Stack(
                                        alignment: Alignment.centerRight,
                                        children: [
                                          TextField(
                                            controller: _emailController,
                                            decoration:
                                                _inputDecoration('친구 이메일 입력'),
                                            onSubmitted: (value) =>
                                                _verifyAndAddEmail(
                                                    context, value),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                _verifyAndAddEmail(context,
                                                    _emailController.text);
                                              },
                                              child: const Text('추가'),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                BlocBuilder<EmailCheckBloc, EmailCheckState>(
                                  builder: (context, state) {
                                    EasyLoading.dismiss();
                                    if (state is EmailCheckLoading) {
                                      EasyLoading.show(status: 'Loading...');
                                    } else if (state is EmailCheckSuccess) {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        _emailController.clear();
                                      });
                                    } else if (state is EmailCheckFailure) {
                                      EasyLoading.showError("존재하지 않는 아이디 입니다.");
                                    }
                                    return Wrap(
                                      spacing: 8.0,
                                      runSpacing: 4.0,
                                      children: state.emails
                                          .map((friend) => Chip(
                                                label: Text(friend),
                                                onDeleted: () {
                                                  context
                                                      .read<EmailCheckBloc>()
                                                      .add(RemoveEmail(friend));
                                                },
                                              ))
                                          .toList(),
                                    );
                                  },
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[200],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(lightBlueColor)),
                      child: Text(
                        '저장',
                        style: TextStyle(
                            color: Colors.grey[100],
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _descriptionController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
