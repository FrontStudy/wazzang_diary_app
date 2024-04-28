import '../../../domain/entities/member/image/image.dart';

class ImageModel extends Image {
  @override
  final int id;
  @override
  final String storagePath;
  final String? fileName;

  ImageModel({required this.storagePath, required this.id, this.fileName})
      : super(id, storagePath: storagePath);
}
