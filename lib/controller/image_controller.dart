import 'dart:io';

class ImageController {
  File? image;

  imageSet(String pickedImage) {
    image = File(pickedImage);
  }
}
