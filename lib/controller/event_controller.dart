import 'dart:async';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EventController extends GetxController {
  XFile? bannerImage;
  RxBool isBannerImageUploaded = false.obs;
  Future<void> onPressedUploadBanner() async {
    final ImagePicker _picker = ImagePicker();
    bannerImage = await _picker.pickImage(source: ImageSource.gallery);
    isBannerImageUploaded.value = true;
  }
}
