import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../core/routes/main_router.dart';
import '../../../core/themes/theme.dart';
import '../../../domain/usecases/signup/check_email_usecase.dart';
import '../../blocs/signup/check_email_bloc.dart';

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
                    BlocBuilder<CheckEmailBloc, CheckEmailState>(
                        builder: (context, state) {
                      Widget suffixIcon = const Icon(Icons.error);
                      if (state is EmailCheckInitial ||
                          state is EmailCheckFail) {
                        suffixIcon = const Icon(Icons.error);
                      } else if (state is EmailCheckLoading) {
                        suffixIcon = Lottie.asset("assets/lotties/loading.json",
                            height: 20, width: 20);
                      } else {
                        suffixIcon = const Icon(Icons.check);
                      }

                      return TextFormField(
                        controller: emailController,
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                          suffixIcon: suffixIcon,
                          label: const Text('이메일 주소'),
                        ),
                        validator: (String? val) {
                          if (val == null || val.isEmpty) {
                            return '이메일을 입력해주세요';
                          }
                          final RegExp emailRegex = RegExp(
                            r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
                          );
                          if (!emailRegex.hasMatch(val)) {
                            return '이메일 양식을 맞춰주세요.';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          context
                              .read<CheckEmailBloc>()
                              .add(CheckEmail(CheckEmailParams(email: value)));
                        },
                        onFieldSubmitted: (input) {
                          if (_formKey.currentState!.validate()) {
                            Navigator.of(context).pushNamed(AppRouter.signUpPw,
                                arguments: input);
                          }
                        },
                      );
                    }),
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
