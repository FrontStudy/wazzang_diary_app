import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/routes/main_router.dart';
import '../../../core/themes/theme.dart';

enum Gender { male, female }

class SignUpBirthPage extends StatefulWidget {
  final Map<String, dynamic> info;
  const SignUpBirthPage({super.key, required this.info});

  @override
  State<SignUpBirthPage> createState() => _SignUpBirthPageState();
}

class _SignUpBirthPageState extends State<SignUpBirthPage> {
  final TextEditingController birthController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late String _formattedDate;
  Gender _selectedGender = Gender.male;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _formattedDate = DateFormat('yyMMdd').format(picked);
      setState(() {
        birthController.text =
            "${picked.year}년 ${picked.month}월 ${picked.day}일";
      });
    }
  }

  @override
  void dispose() {
    birthController.dispose();
    genderController.dispose();
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
            Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "생년월일 입력",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: birthController,
                      readOnly: true,
                      onTap: () async {
                        _selectDate(context);
                      },
                      decoration: const InputDecoration(
                        labelText: '생년월일',
                      ),
                    ),
                    const SizedBox(height: 50),
                    const Text(
                      "성별 입력",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(
                          height: 50,
                          width: 100,
                          child: RadioListTile(
                            visualDensity: VisualDensity.compact,
                            contentPadding: EdgeInsets.zero,
                            title: const Text('남성'),
                            value: Gender.male,
                            groupValue: _selectedGender,
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value!;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: 100,
                          child: RadioListTile(
                            visualDensity: VisualDensity.compact,
                            contentPadding: EdgeInsets.zero,
                            title: const Text('여성'),
                            value: Gender.female,
                            groupValue: _selectedGender,
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.of(context)
                                .pushNamed(AppRouter.signUpName, arguments: {
                              ...widget.info,
                              'birthDate': _formattedDate,
                              'gender': _selectedGender.name
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
