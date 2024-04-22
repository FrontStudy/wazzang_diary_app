import 'package:flutter/material.dart';

import '../../../core/routes/main_router.dart';
import '../../../core/themes/theme.dart';

class SignUpNicknamePage extends StatefulWidget {
  final Map<String, dynamic> info;

  const SignUpNicknamePage({required this.info, super.key});

  @override
  State<SignUpNicknamePage> createState() => _SignUpNicknamePageState();
}

class _SignUpNicknamePageState extends State<SignUpNicknamePage> {
  final TextEditingController nicknameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nicknameController.dispose();
    super.dispose();
  }

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "사용자 이름 만들기",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            const Text("사용자 이름을 직접 추가하거나 추천 이름을 사용하세요. 언제든지 변경할 수 있습니다."),
            const SizedBox(height: 15),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nicknameController,
                      textInputAction: TextInputAction.go,
                      decoration: const InputDecoration(
                        label: Text('사용자 이름'),
                      ),
                      validator: (String? val) {
                        if (val == null || val.isEmpty) {
                          return '사용자 이름를 입력해주세요';
                        }
                        return null;
                      },
                      onFieldSubmitted: (input) {
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context).pushNamed(AppRouter.signUpBirth,
                              arguments: input);
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.of(context)
                                .pushNamed(AppRouter.signUpTerms, arguments: {
                              ...widget.info,
                              'nickname': nicknameController.text
                            });
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
                                (states) => const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            fixedSize: MaterialStatePropertyAll(Size(
                                MediaQuery.of(context).size.width - 20, 45))),
                        child: const Text('다음')),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
