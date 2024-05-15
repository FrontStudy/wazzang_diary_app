String parseToKorean(int number) {
  if (number >= 1e8) {
    return "${(number / 1e8).toStringAsFixed(1)}억";
  } else if (number >= 1e7) {
    return "${(number / 1e7).toStringAsFixed(1)}천만";
  } else if (number >= 1e6) {
    return "${(number / 1e6).toStringAsFixed(0)}만";
  } else if (number >= 1e5) {
    return "${(number / 1e5).toStringAsFixed(0)}만";
  } else if (number >= 1e4) {
    return "${(number / 1e4).toStringAsFixed(1)}만";
  } else if (number >= 1e3) {
    return "${(number / 1e3).toStringAsFixed(1)}천";
  } else {
    return number.toStringAsFixed(0);
  }
}
