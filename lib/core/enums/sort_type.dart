enum SortType {
  latest,
  popular,
  likes,
  date,
}

extension SortTypeExtension on SortType {
  String get name {
    switch (this) {
      case SortType.latest:
        return '최신순';
      case SortType.popular:
        return '조회순';
      case SortType.likes:
        return '좋아요순';
      case SortType.date:
        return '날짜순';
      default:
        return '최신순';
    }
  }
}
