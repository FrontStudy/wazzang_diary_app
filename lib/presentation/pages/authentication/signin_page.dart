import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          child: Column(
            children: [
              const Spacer(),
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
                      alignment: Alignment.center,
                      fixedSize: MaterialStatePropertyAll(
                          Size(MediaQuery.of(context).size.width - 20, 40))),
                  child: const Text('로그인')),
              const Spacer(),
            ],
          ),
        ),
      )),
    );
  }
}
