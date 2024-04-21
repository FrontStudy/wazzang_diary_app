import 'package:flutter/material.dart';

import '../../../core/themes/theme.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          child: Column(
            children: [
              const Spacer(flex: 1),
              const Center(
                child: Text(
                  "모두의 일기",
                  style: TextStyle(fontSize: 30),
                ),
              ),
              const Spacer(flex: 1),
              TextFormField(
                  decoration: const InputDecoration(
                label: Text('이메일'),
                // hintText: '이메일 주소',
              )),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  label: Text('비밀번호'),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => darkblueColor),
                      foregroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white),
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white12),
                      textStyle: MaterialStateTextStyle.resolveWith((states) =>
                          const TextStyle(fontWeight: FontWeight.bold)),
                      fixedSize: MaterialStatePropertyAll(
                          Size(MediaQuery.of(context).size.width - 20, 45))),
                  child: const Text('로그인')),
              const Spacer(
                flex: 3,
              ),
              ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white),
                      foregroundColor: MaterialStateColor.resolveWith(
                          (states) => darkblueColor),
                      textStyle: MaterialStateTextStyle.resolveWith((states) =>
                          const TextStyle(fontWeight: FontWeight.bold)),
                      fixedSize: MaterialStatePropertyAll(
                          Size(MediaQuery.of(context).size.width - 20, 45))),
                  child: const Text('새 계정 만들기')),
              const SizedBox(height: 20)
            ],
          ),
        ),
      )),
    );
  }
}
