class Page {
  final int totalElements;
  final int totalPages;

  Page({required this.totalElements, required this.totalPages});

  factory Page.fromJson(Map<String, dynamic> json) {
    return Page(
      totalElements: json['totalElements'] as int,
      totalPages: json['totalPages'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalElements': totalElements,
      'totalPages': totalPages,
    };
  }
}
