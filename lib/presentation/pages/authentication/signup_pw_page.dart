import 'package:flutter/material.dart';

import '../../../core/routes/main_router.dart';
import '../../../core/themes/theme.dart';

class SignUpPwPage extends StatefulWidget {
  final Map<String, dynamic> info;

  const SignUpPwPage({required this.info, super.key});

  @override
  State<SignUpPwPage> createState() => _SignUpPwPageState();
}

class _SignUpPwPageState extends State<SignUpPwPage> {
  final TextEditingController passwdController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    passwdController.dispose();
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
              "비밀번호 만들기",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            const Text("다른 사람이 추측할 수 없는 6자 이상의 문자 또는 숫자로 비밀번호를 만드세요."),
            const SizedBox(height: 15),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: passwdController,
                      obscureText: true,
                      textInputAction: TextInputAction.go,
                      decoration: const InputDecoration(
                        label: Text('비밀번호'),
                      ),
                      validator: (String? val) {
                        if (val == null || val.isEmpty) {
                          return '비밀번호를 입력해주세요';
                        }
                        if (val.length < 6) {
                          return '6글자 이상의 비밀번호를 입력해주세요.';
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
                                .pushNamed(AppRouter.signUpBirth, arguments: {
                              ...widget.info,
                              'passwd': passwdController.text
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
