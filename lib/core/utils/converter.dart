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

String parseToTimeAgo(String dateTimeString) {
  final DateTime givenTime = DateTime.parse(dateTimeString);
  final DateTime currentTime = DateTime.now();
  final Duration difference = currentTime.difference(givenTime);

  if (difference.inSeconds < 60) {
    return '${difference.inSeconds}초 전';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes}분 전';
  } else if (difference.inHours < 24) {
    return '${difference.inHours}시간 전';
  } else if (difference.inDays < 30) {
    return '${difference.inDays}일 전';
  } else if (difference.inDays < 365) {
    return '${difference.inDays ~/ 30}달 전';
  } else {
    return '${difference.inDays ~/ 365}년 전';
  }
}
