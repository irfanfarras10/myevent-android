import 'dart:async';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/api_controller.dart';
import 'package:myevent_android/model/api_response/create_event_api_response_model.dart';
import 'package:myevent_android/model/api_response/location_api_response_model.dart';
import 'package:myevent_android/provider/api_event.dart';
import 'package:myevent_android/model/api_response/event_category_api_response_model.dart';
import 'package:myevent_android/provider/api_location.dart';
import 'package:myevent_android/route/route_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventController extends ApiController {
  Rxn<XFile> bannerImage = Rxn();
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
  int? eventVenueCategoryId;
  int eventStatusId = 1;
  int? eventCategoryId;

  RxBool isLoadingEventCategoryData = true.obs;

  RxnBool isOnsiteEvent = RxnBool();

  final nameFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();
  final dateEventStartFocusNode = FocusNode();
  final dateEventEndFocusNode = FocusNode();
  final timeEventStartFocusNode = FocusNode();
  final timeEventEndFocusNode = FocusNode();
  final locationFocusNode = FocusNode();

  RxBool isNameValid = false.obs;
  RxBool isDescriptionValid = false.obs;
  RxBool isDateTimeEventValid = false.obs;
  RxBool isLocationValid = false.obs;
  RxBool isCategoryValid = false.obs;
  RxBool isVenueCategoryValid = false.obs;

  RxnString nameErrorMessage = RxnString();
  RxnString descriptionErrorMessage = RxnString();
  RxnString dateTimeEventErrorMessage = RxnString();
  RxnString locationErrorMessage = RxnString();

  Map<String, dynamic> apiRequest = {};

  @override
  onInit() {
    getEventCategory();
    super.onInit();
  }

  @override
  void resetState() {
    nameErrorMessage.value = null;
    descriptionErrorMessage.value = null;
    dateTimeEventErrorMessage.value = null;
    locationErrorMessage.value = null;

    nameFocusNode.unfocus();
    descriptionFocusNode.unfocus();
    dateEventStartFocusNode.unfocus();
    dateEventEndFocusNode.unfocus();
    timeEventStartFocusNode.unfocus();
    timeEventEndFocusNode.unfocus();
    locationFocusNode.unfocus();
  }

  RxBool isDataValid = RxBool(false);

  // bool get isFormValid =>
  //     isBannerImageUploaded.value &&
  //     isNameValid.value &&
  //     isDescriptionValid.value &&
  //     isDateTimeEventValid.value &&
  //     dateEventStart != null &&
  //     timeEventStart != null &&
  //     dateEventEnd != null &&
  //     timeEventEnd != null &&
  //     isLocationValid.value &&
  //     venue != null &&
  //     eventVenueCategoryId != null &&
  //     eventCategoryId != null &&
  //     isCategoryValid.value &&
  //     locationController.text.isNotEmpty;

  void validateAllData() {
    if (isBannerImageUploaded.value &&
        isNameValid.value &&
        isDescriptionValid.value &&
        isDateTimeEventValid.value &&
        isLocationValid.value &&
        isCategoryValid.value &&
        isVenueCategoryValid.value) {
      isDataValid.value = true;
    } else {
      isDataValid.value = false;
    }
  }

  Future<void> pickBannerPhoto() async {
    final ImagePicker _picker = ImagePicker();
    bannerImage.value = await _picker.pickImage(source: ImageSource.gallery);
    isBannerImageUploaded.value = true;
    update();
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
      (response) {
        print(response['code']);
        print(response);
        if (response['code'] != null) {
          return [];
        }
        return LocationApiResponseModel.fromJson(response).features;
      },
    );
  }

  void setVenue({
    required String location,
    required double lon,
    required double lat,
  }) {
    venue = '$lon|$lat';
    locationController.text = location;
    validateLocation(location);
  }

  void setEventVenueCategory(int id) {
    if (id == 1) {
      isVenueCategoryValid.value = false;
      isOnsiteEvent.value = true;
      locationController.text = '';
      locationErrorMessage.value = null;
    } else {
      isVenueCategoryValid.value = false;
      isOnsiteEvent.value = false;
      locationController.text = '';
      locationErrorMessage.value = null;
    }
    eventVenueCategoryId = id;
    validateAllData();
  }

  void setEventCategory(int id) {
    eventCategoryId = id;
    isCategoryValid.value = true;
    validateAllData();
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
    validateAllData();
  }

  void validateDescription(String description) {
    errorMessage = null;
    isDescriptionValid.value = true;
    if (description.isEmpty) {
      descriptionErrorMessage.value = 'Deskripsi event harus diisi';
    } else if (description.length < 50) {
      descriptionErrorMessage.value = 'Deskripsi event minimal 50 karakter';
    } else {
      descriptionErrorMessage.value = null;
      isNameValid.value = true;
    }
    validateAllData();
  }

  void validateDateTime() {
    dateTimeEventErrorMessage.value = null;
    isDateTimeEventValid.value = true;
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
    validateAllData();
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

  void validateLocation(String location) {
    isVenueCategoryValid.value = true;
    isLocationValid.value = true;
    locationErrorMessage.value = null;
    if (isOnsiteEvent.value != null) {
      if (isOnsiteEvent.value! && venue == null) {
        isLocationValid.value = false;
        locationErrorMessage.value = 'Lokasi harus dipilih';
      } else if (!isOnsiteEvent.value!) {
        if (location.isEmpty) {
          isLocationValid.value = false;
          locationErrorMessage.value = 'Link video conference harus diisi';
        } else if (!Uri.parse(location).isAbsolute) {
          isLocationValid.value = false;
          locationErrorMessage.value = 'Link tidak valid';
        } else {
          isLocationValid.value = true;
          isVenueCategoryValid.value = true;
          locationErrorMessage.value = null;
          venue = location;
        }
      } else {
        isLocationValid.value = true;
        isVenueCategoryValid.value = true;
        locationErrorMessage.value = null;
      }
      validateAllData();
    }
  }

  Future<void> createEvent() async {
    resetState();
    final pref = await SharedPreferences.getInstance();
    apiRequest = {
      'name': nameController.text,
      'description': descriptionController.text,
      'dateTimeEventStart': dateTimeEventStart!.millisecondsSinceEpoch,
      'dateTimeEventEnd': dateTimeEventEnd!.millisecondsSinceEpoch,
      'location': venue,
      'bannerPhoto': await dio.MultipartFile.fromFile(bannerImage.value!.path),
      'eventStatusId': eventStatusId,
      'eventCategoryId': eventCategoryId,
      'eventVenueCategoryId': eventVenueCategoryId,
      'eventOrganizerId': int.parse(
        pref.getString('myevent.auth.token.subject')!,
      ),
    };
    Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 25.0),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 15.0),
            Text('Menyimpan data...'),
          ],
        ),
      ),
      barrierDismissible: false,
    );
    apiEvent.createEvent(data: apiRequest).then(
      (response) {
        Get.back();
        checkApResponse(response);
        CreateEventApiResponseModel? createEventApiResponse;
        if (apiResponseState.value == ApiResponseState.http2xx) {
          createEventApiResponse =
              CreateEventApiResponseModel.fromJson(response);
        }
        Get.defaultDialog(
          titleStyle: TextStyle(
            fontSize: 0.0,
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                apiResponseState.value == ApiResponseState.http2xx
                    ? createEventApiResponse!.message!
                    : response['message'],
                style: TextStyle(
                  fontSize: 15.0,
                  color: MyEventColor.secondaryColor,
                ),
              ),
              response['code'] != null
                  ? Icon(
                      Icons.close,
                      size: 50.0,
                      color: Colors.red,
                    )
                  : Icon(
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
            if (apiResponseState.value == ApiResponseState.http2xx) {
              print('ini');
              Get.back();
              Get.back();
              Get.toNamed(
                RouteName.createEventTicketScreen,
                arguments: createEventApiResponse!.eventId,
              );
            } else {
              print('tasdas');
              Get.back();
            }
          },
        );
      },
    );
  }
}
