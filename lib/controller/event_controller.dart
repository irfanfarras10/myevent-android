import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:myevent_android/controller/api_controller.dart';
import 'package:myevent_android/model/api_response/location_api_response_model.dart';
import 'package:myevent_android/provider/api_event.dart';
import 'package:myevent_android/model/api_response/event_category_api_response_model.dart';
import 'package:myevent_android/provider/api_location.dart';

class EventController extends ApiController {
  XFile? bannerImage;
  final isBannerImageUploaded = false.obs;
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateEventStartController = TextEditingController();
  final dateEventEndController = TextEditingController();
  final timeEventStartController = TextEditingController();
  final timeEventEndController = TextEditingController();
  List<EventCategories> eventCategoryList = [];
  final locationController = TextEditingController();
  String? venue;

  RxBool isLoadingEventCategoryData = true.obs;

  RxnBool isOnsiteEvent = RxnBool();

  RxBool isFormValid = false.obs;

  @override
  onInit() {
    getEventCategory();
    super.onInit();
  }

  @override
  void resetState() {
    // TODO: implement resetState
  }

  Future<void> pickBannerPhoto() async {
    final ImagePicker _picker = ImagePicker();
    bannerImage = await _picker.pickImage(source: ImageSource.gallery);
    isBannerImageUploaded.value = true;
  }

  Future<void> setEventDateStart() async {
    showDatePicker(
      context: Get.key.currentContext!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    ).then(
      (date) => dateEventStartController.text =
          DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(date!),
    );
  }

  Future<void> setEventDateEnd() async {
    showDatePicker(
      context: Get.key.currentContext!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    ).then(
      (date) => dateEventEndController.text =
          DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(date!),
    );
  }

  Future<void> setEventTimeStart() async {
    showTimePicker(
      context: Get.key.currentContext!,
      initialTime: TimeOfDay.now(),
    ).then(
      (time) {
        timeEventStartController.text =
            MaterialLocalizations.of(Get.key.currentContext!)
                .formatTimeOfDay(time!);
      },
    );
  }

  Future<void> setEventTimeEnd() async {
    showTimePicker(
      context: Get.key.currentContext!,
      initialTime: TimeOfDay.now(),
    ).then(
      (time) {
        timeEventEndController.text =
            MaterialLocalizations.of(Get.key.currentContext!)
                .formatTimeOfDay(time!);
      },
    );
  }

  Future<void> getEventCategory() async {
    await apiEvent.getEventCategory().then(
      (response) {
        checkApResponse(response);
        if (apiResponseState.value != ApiResponseState.http401) {
          isLoadingEventCategoryData.value = false;
          final eventCategoryApiResponse =
              EventCategoryApiResponseModel.fromJson(response);
          eventCategoryList = eventCategoryApiResponse.eventCategories!;
        }
      },
    );
  }

  Future findLocation(String keyword) async {
    if (keyword.isEmpty) {
      keyword = ' ';
    }
    return await apiLocation.getLocation(keyword).then(
          (response) => LocationApiResponseModel.fromJson(response).features,
        );
  }

  void setVenue({
    required String location,
    required double lon,
    required double lat,
  }) {
    venue = '$lon|$lat';
    locationController.text = location;
  }

  void selectVenueType(String venue) {
    if (venue == 'Onsite') {
      isOnsiteEvent.value = true;
      locationController.text = '';
    } else {
      isOnsiteEvent.value = false;
      locationController.text = '';
    }
  }
}
