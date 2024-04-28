import 'image_model.dart';

class ImageListResponseModel {
  final List<ImageModel> imageList;

  ImageListResponseModel(this.imageList);

  factory ImageListResponseModel.fromJson(List<dynamic> json) {
    List<ImageModel> imageList = json.map((jsonData) {
      return ImageModel(
        storagePath: jsonData['storagePath'],
        id: jsonData['id'],
        fileName: jsonData['fileName'],
      );
    }).toList();

    return ImageListResponseModel(imageList);
  }
}
