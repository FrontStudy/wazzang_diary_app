import 'package:flutter/material.dart';

import '../../../core/routes/main_router.dart';
import '../../../core/themes/theme.dart';

class SignUpNamePage extends StatefulWidget {
  final Map<String, dynamic> info;
  const SignUpNamePage({required this.info, super.key});

  @override
  State<SignUpNamePage> createState() => _SignUpNamePageState();
}

class _SignUpNamePageState extends State<SignUpNamePage> {
  final TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
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
              "이름 입력",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            const Text("친구들이 회원님을 찾을 수 있도록 이름을 추가하세요."),
            const SizedBox(height: 15),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      textInputAction: TextInputAction.go,
                      decoration: const InputDecoration(
                        label: Text('성명'),
                      ),
                      validator: (String? val) {
                        if (val == null || val.isEmpty) {
                          return '이름을 입력해주세요';
                        }
                        return null;
                      },
                      onFieldSubmitted: (input) {
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context).pushNamed(
                              AppRouter.signUpNickName,
                              arguments: input);
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.of(context).pushNamed(
                                AppRouter.signUpNickName,
                                arguments: {
                                  ...widget.info,
                                  "name": nameController.text
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
