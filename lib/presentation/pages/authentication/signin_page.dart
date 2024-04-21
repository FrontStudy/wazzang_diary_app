import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/routes/main_router.dart';
import '../../../core/themes/theme.dart';
import '../../../domain/usecases/member/sign_in_usecase.dart';
import '../../blocs/member/member_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<MemberBloc, MemberState>(
      listener: (context, state) {
        if (state is MemberLogged) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRouter.main,
            ModalRoute.withName(''),
          );
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
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
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    label: Text('이메일'),
                  ),
                  validator: (String? val) {
                    if (val == null || val.isEmpty) {
                      return '이메일을 입력해주세요';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: passwordController,
                  textInputAction: TextInputAction.go,
                  obscureText: true,
                  decoration: const InputDecoration(
                    label: Text('비밀번호'),
                  ),
                  validator: (String? val) {
                    if (val == null || val.isEmpty) {
                      return '비밀번호를 입력해주세요';
                    }
                    return null;
                  },
                  onFieldSubmitted: (_) {
                    if (_formKey.currentState!.validate()) {
                      context.read<MemberBloc>().add(SignInMember(SignInParams(
                            email: emailController.text,
                            passwd: passwordController.text,
                          )));
                    }
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<MemberBloc>().add(SignInMember(
                            SignInParams(
                                email: emailController.text,
                                passwd: passwordController.text)));
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
                        textStyle: MaterialStateTextStyle.resolveWith(
                            (states) =>
                                const TextStyle(fontWeight: FontWeight.bold)),
                        fixedSize: MaterialStatePropertyAll(
                            Size(MediaQuery.of(context).size.width - 20, 45))),
                    child: const Text('새 계정 만들기')),
                const SizedBox(height: 20)
              ],
            ),
          ),
        )),
      ),
    );
  }
}
