import 'dart:math';

String parseToKorean(int number) {
  if (number == 0) return '0';
  final koreanUnits = ['', '', '백', '천', '만', '십만', '백만', '천만', '억'];
  final digitCount = (log(number.abs()) / ln10).floor() + 1;
  final String firstDigit = number.toString()[0];

  return firstDigit + koreanUnits[digitCount];
}
