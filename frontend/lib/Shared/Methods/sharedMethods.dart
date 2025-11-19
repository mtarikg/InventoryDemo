import 'dart:convert';

class SharedMethods {
  Future<String?> convertImageToBase64(dynamic image) async {
    String? imageURL;
    if (image != null) {
      final imageBytes = await image!.readAsBytes();
      final base64Image = base64Encode(imageBytes);
      imageURL = base64Image;
    }
    return imageURL;
  }
}
