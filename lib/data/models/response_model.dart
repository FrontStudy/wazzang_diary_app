import 'pagination/page.dart';

class ResponseModel<T> {
  final String status;
  final T? data;
  final Page? page;

  ResponseModel({required this.status, required this.data, this.page});

  factory ResponseModel.fromJsonList(
      Map<String, dynamic> json, T Function(List<dynamic>) fromJson) {
    return ResponseModel(
        status: json["status"],
        data: fromJson(json["data"]),
        page: json["page"] == null ? null : Page.fromJson(json["page"]));
  }

  factory ResponseModel.fromJsonMap(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJson) {
    return ResponseModel(
        status: json["status"],
        data: fromJson(json["data"]),
        page: json["page"] == null ? null : Page.fromJson(json["page"]));
  }

  factory ResponseModel.fromJsonWithoutData(Map<String, dynamic> json) {
    return ResponseModel(
        status: json["status"], data: null, page: Page.fromJson(json["page"]));
  }
}
