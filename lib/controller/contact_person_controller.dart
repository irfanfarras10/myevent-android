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

  @override
  void onInit() {
    getContactPersonSocialMedia();
    addContactPerson();
    super.onInit();
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
  }

  @override
  void resetState() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
