import 'package:flutter/material.dart';

import '../../../core/themes/theme.dart';

class SignUpTermsPage extends StatefulWidget {
  final Map<String, dynamic> info;

  const SignUpTermsPage({required this.info, super.key});

  @override
  State<SignUpTermsPage> createState() => _SignUpTermsPageState();
}

class _SignUpTermsPageState extends State<SignUpTermsPage> {
  bool _useTerm = false;
  bool _privacyTerm = false;
  bool _locateTerm = false;
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
                "모두의일기 약관 및 정책에 동의",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              const Text("계정을 만들려면 모든 약관에 동의해주세요."),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("이용 약관",
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    TextButton(
                        onPressed: () {
                          if (mounted) {
                            setState(() {
                              _useTerm = !_useTerm;
                              _privacyTerm = !_privacyTerm;
                              _locateTerm = !_locateTerm;
                            });
                          }
                        },
                        child: const Text('모두 선택'))
                  ],
                ),
              ),
              Container(
                height: 210,
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white70),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "이용 약관(필수)",
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                "더 알아보기",
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 12),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Checkbox(
                                value: _useTerm,
                                onChanged: (isCheck) {
                                  if (mounted) {
                                    setState(() {
                                      _useTerm = isCheck!;
                                    });
                                  }
                                }),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          border: Border.symmetric(
                              horizontal:
                                  BorderSide(color: Colors.grey[300]!))),
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "개인정보처리방침(필수)",
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                "더 알아보기",
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 12),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Checkbox(
                                value: _privacyTerm,
                                onChanged: (isCheck) {
                                  if (mounted) {
                                    setState(() {
                                      _privacyTerm = isCheck!;
                                    });
                                  }
                                }),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "위치 기반 기능(필수)",
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                "더 알아보기",
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 12),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Checkbox(
                                value: _locateTerm,
                                onChanged: (isCheck) {
                                  if (mounted) {
                                    setState(() {
                                      _locateTerm = isCheck!;
                                    });
                                  }
                                }),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    if (_useTerm && _privacyTerm && _locateTerm) {
                      //다음 페이지
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => _useTerm && _privacyTerm && _locateTerm
                              ? darkblueColor
                              : Colors.blue[300]!),
                      foregroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white),
                      overlayColor: MaterialStateColor.resolveWith((states) =>
                          _useTerm && _privacyTerm && _locateTerm
                              ? Colors.white12
                              : Colors.transparent),
                      textStyle: MaterialStateTextStyle.resolveWith((states) =>
                          const TextStyle(fontWeight: FontWeight.bold)),
                      fixedSize: MaterialStatePropertyAll(
                          Size(MediaQuery.of(context).size.width - 20, 45))),
                  child: const Text('동의')),
            ],
          ),
        ));
  }
}
