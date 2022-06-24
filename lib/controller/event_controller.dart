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
  DateTime? dateEventStart;
  DateTime? dateEventEnd;
  TimeOfDay? timeEventStart;
  TimeOfDay? timeEventEnd;
  DateTime? dateTimeEventStart;
  DateTime? dateTimeEventEnd;

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

  final nameFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();
  final dateEventStartFocusNode = FocusNode();
  final dateEventEndFocusNode = FocusNode();
  final timeEventStartFocusNode = FocusNode();
  final timeEventEndFocusNode = FocusNode();

  RxBool isNameValid = false.obs;
  RxBool isDescriptionValid = false.obs;
  RxBool isDateTimeEventValid = false.obs;

  RxBool isFormValid = false.obs;

  RxnString nameErrorMessage = RxnString();
  RxnString descriptionErrorMessage = RxnString();
  RxnString dateTimeEventErrorMessage = RxnString();

  @override
  onInit() {
    getEventCategory();
    super.onInit();
  }

  @override
  void resetState() {
    nameErrorMessage.value = null;
    descriptionErrorMessage.value = null;

    nameFocusNode.unfocus();
    descriptionFocusNode.unfocus();
  }

  Future<void> pickBannerPhoto() async {
    final ImagePicker _picker = ImagePicker();
    bannerImage = await _picker.pickImage(source: ImageSource.gallery);
    isBannerImageUploaded.value = true;
  }

  Future<void> setEventDateStart() async {
    showDatePicker(
      context: Get.key.currentContext!,
      initialDate: dateEventStart == null ? DateTime.now() : dateEventStart!,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    ).then((date) {
      dateEventStart = date;
      dateEventStartController.text =
          '${DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(dateEventStart!)}';
      setEventDateTimeStart();
    });
  }

  Future<void> setEventDateEnd() async {
    showDatePicker(
      context: Get.key.currentContext!,
      initialDate: dateEventEnd == null ? DateTime.now() : dateEventEnd!,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    ).then((date) {
      dateEventEnd = date;
      dateEventEndController.text =
          '${DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(dateEventEnd!)}';
      setEventDateTimeEnd();
    });
  }

  Future<void> setEventTimeStart() async {
    showTimePicker(
      context: Get.key.currentContext!,
      initialTime: TimeOfDay.now(),
    ).then(
      (time) {
        timeEventStart = time;
        timeEventStartController.text =
            MaterialLocalizations.of(Get.key.currentContext!)
                .formatTimeOfDay(time!);

        setEventDateTimeStart();
      },
    );
  }

  Future<void> setEventTimeEnd() async {
    showTimePicker(
      context: Get.key.currentContext!,
      initialTime: TimeOfDay.now(),
    ).then(
      (time) {
        timeEventEnd = time;
        timeEventEndController.text =
            MaterialLocalizations.of(Get.key.currentContext!)
                .formatTimeOfDay(time!);

        setEventDateTimeEnd();
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

  void validateName(String organizerName) {
    errorMessage = null;
    isNameValid.value = false;
    if (organizerName.isEmpty) {
      nameErrorMessage.value = 'Nama event harus diisi';
    } else {
      nameErrorMessage.value = null;
      isNameValid.value = true;
    }
  }

  void validateDescription(String description) {
    errorMessage = null;
    isDescriptionValid.value = false;
    if (description.isEmpty) {
      descriptionErrorMessage.value = 'Deskripsi event harus diisi';
    } else if (description.length < 50) {
      descriptionErrorMessage.value = 'Deskripsi event minimal 50 karakter';
    } else {
      nameErrorMessage.value = null;
      isNameValid.value = true;
    }
  }

  void validateDateTime() {
    if (dateTimeEventStart != null && dateTimeEventEnd != null) {
      if (dateTimeEventEnd!.difference(dateTimeEventStart!).isNegative) {
        dateTimeEventErrorMessage.value =
            'Tanggal dan waktu mulai tidak boleh melebihi tanggal dan waktu selesai';
        isDateTimeEventValid.value = false;
      } else {
        dateTimeEventErrorMessage.value = null;
        isDateTimeEventValid.value = true;
      }
    }
  }

  void setEventDateTimeStart() {
    if (dateEventStart != null && timeEventStart != null) {
      String dateStart = DateFormat('yyyy-MM-dd').format(dateEventStart!);
      String timeStart = timeEventStartController.text;
      dateTimeEventStart = DateTime.parse('$dateStart $timeStart');
    }
    validateDateTime();
  }

  void setEventDateTimeEnd() {
    if (dateEventEnd != null && timeEventEnd != null) {
      String dateEnd = DateFormat('yyyy-MM-dd').format(dateEventEnd!);
      String timeEnd = timeEventEndController.text;
      dateTimeEventEnd = DateTime.parse('$dateEnd $timeEnd');
    }
    validateDateTime();
  }
}
