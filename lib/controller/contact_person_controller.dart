import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/controller/api_controller.dart';
import 'package:myevent_android/model/api_response/contact_person_social_media_api_response_model.dart';
import 'package:myevent_android/provider/api_contact_person.dart';
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

  bool get isAllDataValid {
    return !isContactPersonNameValid.contains(false) &&
        !isContactPersonNumberValid.contains(false) &&
        !isContactPersonSocialMediaIdValid.contains(false);
  }

  @override
  void onInit() {
    getContactPersonSocialMedia();
    addContactPerson();
    super.onInit();
  }

  @override
  void resetState() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Future<void> getContactPersonSocialMedia() async {
    await apiContactPerson.getContactPersonSocialMedia().then(
      (response) {
        checkApiResponse(response);

        if (apiResponseState.value != ApiResponseState.http401) {
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

  void setContactPersonSocialMeda(int index, int id) {
    contactPersonData[index]['eventSocialMediaId'] = id;
    isContactPersonSocialMediaIdValid[index].value = true;
  }
}
