import 'package:flutter/material.dart';

import '../../../core/routes/main_router.dart';
import '../../../core/themes/theme.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
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
              "이메일 주소 입력",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            const Text(
                "회원님에게 연락할 후 있는 이메일 주소를 입력하세요. 이 이메일 주소는 프로필에서 다른 사람에게 공개되지 않습니다."),
            const SizedBox(height: 15),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      textInputAction: TextInputAction.go,
                      decoration: const InputDecoration(
                        label: Text('이메일 주소'),
                      ),
                      validator: (String? val) {
                        if (val == null || val.isEmpty) {
                          return '이메일을 입력해주세요';
                        }
                        return null;
                      },
                      onFieldSubmitted: (input) {
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context)
                              .pushNamed(AppRouter.signUpPw, arguments: input);
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.of(context).pushNamed(AppRouter.signUpPw,
                                arguments: {"email": emailController.text});
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
