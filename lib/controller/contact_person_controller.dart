import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/api_controller.dart';
import 'package:myevent_android/model/api_request/create_contact_person_api_request_model.dart';
import 'package:myevent_android/model/api_response/contact_person_social_media_api_response_model.dart';
import 'package:myevent_android/model/api_response/view_event_detail_api_response_model.dart';
import 'package:myevent_android/provider/api_contact_person.dart';
import 'package:myevent_android/provider/api_event.dart';
import 'package:myevent_android/screen/create_event_contact_person_screen/widget/create_event_contact_person_card_widget.dart';

class ContactPersonController extends ApiController {
  RxList<CreateEventContactPersonCardWidget> contactPersonList = RxList();
  List<EventSocialMedias> contactPersonSocialMedia = [];

  RxBool isLoading = true.obs;

  List<Map<String, dynamic>> contactPersonData = [];

  List<RxnString> contactPersonNameErrorMessage = [];
  List<RxnString> contactPersonNumberErrorMessage = [];

  List<RxBool> isContactPersonNameValid = [];
  List<RxBool> isContactPersonNumberValid = [];
  List<RxBool> isContactPersonSocialMediaIdValid = [];

  List<TextEditingController> contactPersonNameController = [];
  List<TextEditingController> contactPersonNumberController = [];
  List<int?> contactPersonSocialMediaIdValue = [];

  final _eventId = Get.parameters['id'];

  final contactPersonParam = Get.arguments;

  ViewEventDetailApiResponseModel? eventData;

  bool get isAllDataValid {
    return !isContactPersonNameValid.contains(false) &&
        !isContactPersonNumberValid.contains(false) &&
        !isContactPersonSocialMediaIdValid.contains(false);
  }

  @override
  void onInit() {
    getContactPersonSocialMedia();
    addContactPerson();
    if (contactPersonParam['canEdit']) {
      loadData();
    }
    super.onInit();
  }

  @override
  void resetState() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Future<void> loadData() async {
    await apiEvent.getEventDetail(id: int.parse(_eventId!)).then((response) {
      checkApiResponse(response);
      if (apiResponseState.value == ApiResponseState.http2xx) {
        isLoading.value = false;
        eventData = ViewEventDetailApiResponseModel.fromJson(response);

        contactPersonList.clear();
        contactPersonData.clear();
        contactPersonNameErrorMessage.clear();
        contactPersonNumberErrorMessage.clear();
        isContactPersonNameValid.clear();
        isContactPersonNumberValid.clear();
        isContactPersonSocialMediaIdValid.clear();
        contactPersonNameController.clear();
        contactPersonNumberController.clear();
        contactPersonSocialMediaIdValue.clear();

        eventData!.eventContactPerson!.forEach((data) {
          contactPersonList.add(CreateEventContactPersonCardWidget());
          contactPersonData.add({
            'name': data.name,
            'contact': data.contact,
            'eventSocialMediaId': data.eventSocialMedia!.id,
          });
          contactPersonNameErrorMessage.add(RxnString());
          contactPersonNumberErrorMessage.add(RxnString());
          isContactPersonNameValid.add(RxBool(true));
          isContactPersonNumberValid.add(RxBool(true));
          isContactPersonSocialMediaIdValid.add(RxBool(true));
          contactPersonNameController
              .add(TextEditingController(text: data.name));
          contactPersonNumberController
              .add(TextEditingController(text: data.contact));
          contactPersonSocialMediaIdValue.add(data.eventSocialMedia!.id);
        });
      }
    });
  }

  Future<void> getContactPersonSocialMedia() async {
    await apiContactPerson.getContactPersonSocialMedia().then(
      (response) {
        checkApiResponse(response);

        if (apiResponseState.value != ApiResponseState.http401 &&
            !contactPersonParam['canEdit']) {
          isLoading.value = false;
        }

        if (apiResponseState.value == ApiResponseState.http2xx) {
          final socialMedia =
              ContactPersonSocialMediaApiResponseModel.fromJson(response);
          contactPersonSocialMedia = socialMedia.eventSocialMedias!;
        }
      },
    );
  }

  void addContactPerson() {
    contactPersonList.add(CreateEventContactPersonCardWidget());
    contactPersonData.add({
      'name': '',
      'contact': '',
      'eventSocialMediaId': null,
    });
    contactPersonNameErrorMessage.add(RxnString());
    contactPersonNumberErrorMessage.add(RxnString());
    isContactPersonNameValid.add(RxBool(false));
    isContactPersonNumberValid.add(RxBool(false));
    isContactPersonSocialMediaIdValid.add(RxBool(false));
    contactPersonNameController.add(TextEditingController());
    contactPersonNumberController.add(TextEditingController());
    contactPersonSocialMediaIdValue.add(null);
  }

  void removeContactPerson(int index) {
    contactPersonList.removeAt(index);
    contactPersonData.removeAt(index);
    contactPersonNameErrorMessage.removeAt(index);
    contactPersonNumberErrorMessage.removeAt(index);
    isContactPersonNameValid.removeAt(index);
    isContactPersonNumberValid.removeAt(index);
    isContactPersonSocialMediaIdValid.removeAt(index);
    contactPersonNameController.removeAt(index);
    contactPersonNumberController.removeAt(index);
    contactPersonSocialMediaIdValue.removeAt(index);
  }

  void setContactPersonName(int index, String name) {
    if (name.isEmpty) {
      isContactPersonNameValid[index].value = false;
      contactPersonNameErrorMessage[index].value = 'Nama harus diisi';
    } else {
      isContactPersonNameValid[index].value = true;
      contactPersonNameErrorMessage[index].value = null;
    }
    contactPersonData[index]['name'] = name;
  }

  void setContactPersonNumber(int index, String number) {
    if (number.isEmpty) {
      isContactPersonNumberValid[index].value = false;
      contactPersonNumberErrorMessage[index].value =
          'ID / nomor media sosial harus diisi';
    } else {
      isContactPersonNumberValid[index].value = true;
      contactPersonNumberErrorMessage[index].value = null;
    }

    contactPersonData[index]['contact'] = number;
  }

  void setContactPersonSocialMedia(int index, int id) {
    contactPersonData[index]['eventSocialMediaId'] = id;
    isContactPersonSocialMediaIdValid[index].value = true;
  }

  Future<void> updateContactPerson() async {
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

    for (int i = 0; i < contactPersonList.length; i++) {
      await apiContactPerson
          .updateContactPerson(
        eventId: _eventId!,
        contactPersonId: eventData!.eventContactPerson![i].id.toString(),
        requestBody: CreateContactPersonApiRequestModel.fromJson(
          contactPersonData[i],
        ),
      )
          .then(
        (response) {
          checkApiResponse(response);

          if (apiResponseState.value != ApiResponseState.http2xx) {
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
                if (apiResponseState.value != ApiResponseState.http401) {
                  Get.back();
                }
              },
            );
            return;
          }
        },
      );
    }

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
              'Contact Person Tersimpan',
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
          if (apiResponseState.value == ApiResponseState.http2xx) {
            Get.back();
            Get.back();
            Get.back(result: true);
            //go to event detail page
          } else {
            Get.back();
          }
        },
      );
    }
  }

  Future<void> createContactPerson() async {
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

    for (int i = 0; i < contactPersonList.length; i++) {
      await apiContactPerson
          .createContactPerson(
        eventId: _eventId!,
        requestBody: CreateContactPersonApiRequestModel.fromJson(
          contactPersonData[i],
        ),
      )
          .then(
        (response) {
          checkApiResponse(response);

          if (apiResponseState.value != ApiResponseState.http2xx) {
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
                if (apiResponseState.value != ApiResponseState.http401) {
                  Get.back();
                }
              },
            );
            return;
          }
        },
      );
    }

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
              'Contact Person Tersimpan',
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
          if (apiResponseState.value == ApiResponseState.http2xx) {
            Get.back();
            Get.back();
            Get.back(result: true);
            //go to event detail page
          } else {
            Get.back();
          }
        },
      );
    }
  }
}
