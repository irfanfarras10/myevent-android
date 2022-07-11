import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/api_controller.dart';
import 'package:myevent_android/model/api_response/view_event_detail_api_response_model.dart';
import 'package:myevent_android/provider/api_event.dart';
import 'package:dio/dio.dart' as dio;

class SharingFileController extends ApiController {
  ViewEventDetailApiResponseModel? eventData;
  RxBool isLoading = RxBool(true);
  final _eventId = int.parse(Get.parameters['id']!);

  TextEditingController titleController = TextEditingController();
  Rxn<FilePickerResult> pickedFile = Rxn<FilePickerResult>();
  TextEditingController fileLocationController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  RxBool isTitleValid = RxBool(false);
  RxBool isLinkValid = RxBool(true);
  RxBool isDescriptionValid = RxBool(false);

  RxnString titleErrorMessage = RxnString();
  RxnString linkErrorMessage = RxnString();
  RxnString descriptionErrorMessage = RxnString();

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  @override
  void resetState() {
    isLoading.value = true;
  }

  bool get isAllDataValid {
    return isTitleValid.value && isLinkValid.value && isDescriptionValid.value
        ? true
        : false;
  }

  Future<void> loadData() async {
    resetState();
    apiEvent.getEventDetail(id: _eventId).then((response) {
      checkApiResponse(response);
      if (apiResponseState.value == ApiResponseState.http2xx) {
        eventData = ViewEventDetailApiResponseModel.fromJson(response);
        isLoading.value = false;
      }
    });
  }

  Future<void> setFile() async {
    pickedFile.value = await FilePicker.platform.pickFiles();
    if (pickedFile.value != null) {
      File file = File(pickedFile.value!.files.single.path!);
      fileLocationController.text = file.path;
    }
  }

  void setTitle(String title) {
    if (title.isEmpty) {
      isTitleValid.value = false;
      titleErrorMessage.value = 'Judul harus diisi';
    } else {
      isTitleValid.value = true;
      titleErrorMessage.value = null;
    }
  }

  void setLink(String link) {
    if (link.isEmpty) {
      isLinkValid.value = true;
      linkErrorMessage.value = null;
    } else if (!Uri.parse(link).isAbsolute) {
      isLinkValid.value = false;
      linkErrorMessage.value = 'Link tidak valid';
    } else {
      isLinkValid.value = true;
      linkErrorMessage.value = null;
    }
  }

  void setDescription(String description) {
    if (description.isEmpty) {
      isDescriptionValid.value = false;
      descriptionErrorMessage.value = 'Deskripsi harus diisi';
    } else {
      isDescriptionValid.value = true;
      descriptionErrorMessage.value = null;
    }
  }

  Future<void> shareFile() async {
    Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 25.0),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 15.0),
            Text('Membagikan File...'),
          ],
        ),
      ),
      barrierDismissible: false,
    );
    await apiEvent.shareFile(
      id: _eventId,
      data: {
        'judul': titleController.text,
        'fileShare': pickedFile.value == null
            ? null
            : await dio.MultipartFile.fromFile(
                fileLocationController.text,
              ),
        'link': linkController.text,
        'message': descriptionController.text,
      },
    ).then(
      (response) {
        checkApiResponse(response);
        if (apiResponseState.value == ApiResponseState.http2xx) {
          Get.defaultDialog(
            titleStyle: TextStyle(
              fontSize: 0.0,
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Berhasil Dibagikan',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: MyEventColor.secondaryColor,
                  ),
                ),
                Icon(
                  Icons.check,
                  size: 50.0,
                  color: Colors.green,
                ),
              ],
            ),
            textConfirm: 'OK',
            confirmTextColor: MyEventColor.secondaryColor,
            barrierDismissible: false,
            onConfirm: () {
              Get.back();
              Get.back();
            },
          );
        } else {
          Get.defaultDialog(
            titleStyle: TextStyle(
              fontSize: 0.0,
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Terjadi Kesalahan',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: MyEventColor.secondaryColor,
                  ),
                ),
                Icon(
                  Icons.close,
                  size: 50.0,
                  color: Colors.red,
                ),
              ],
            ),
            textConfirm: 'OK',
            confirmTextColor: MyEventColor.secondaryColor,
            barrierDismissible: false,
            onConfirm: () {
              Get.back();
              Get.back();
            },
          );
        }
      },
    );
  }
}
