import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/api_controller.dart';
import 'package:myevent_android/model/api_request/create_payment_api_request_mode.dart';
import 'package:myevent_android/provider/api_payment.dart';
import 'package:myevent_android/route/route_name.dart';
import 'package:myevent_android/screen/create_event_payment_screen/widget/create_event_payment_screen_card_widget.dart';

class PaymentController extends ApiController {
  RxList<CreateEventPaymentScreenCardWidget> paymentList = RxList();

  RxList<TextEditingController> paymentTypeController = RxList();
  RxList<TextEditingController> paymentNumberController = RxList();

  RxList<RxBool> isPaymentTypeValid = RxList();
  RxList<RxBool> isPaymentNumberValid = RxList();

  RxList<RxnString> paymentTypeErrorMessage = RxList();
  RxList<RxnString> paymentNumberErrorMessage = RxList();

  List<Map<String, dynamic>> paymentData = [];
  List<CreatePaymentApiRequestModel> _apiRequest = [];

  final _eventId = Get.parameters['id'];

  @override
  void onInit() {
    addPayment();
    super.onInit();
  }

  @override
  void resetState() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  bool get isDataValid {
    return !isPaymentTypeValid.contains(false) &&
        !isPaymentNumberValid.contains(false);
  }

  void addPayment() {
    paymentList.add(CreateEventPaymentScreenCardWidget());
    paymentTypeController.add(TextEditingController());
    paymentNumberController.add(TextEditingController());
    isPaymentTypeValid.add(RxBool(false));
    isPaymentNumberValid.add(RxBool(false));
    paymentTypeErrorMessage.add(RxnString());
    paymentNumberErrorMessage.add(RxnString());
    paymentData.add({
      'type': '',
      'information': '',
    });
  }

  void removePayment(index) {
    paymentList.removeAt(index);
    paymentTypeController.removeAt(index);
    paymentNumberController.removeAt(index);
    isPaymentTypeValid.removeAt(index);
    isPaymentNumberValid.removeAt(index);
    paymentTypeErrorMessage.removeAt(index);
    paymentNumberErrorMessage.removeAt(index);
    paymentData.removeAt(index);
  }

  void setPaymentType(int index, String name) {
    if (name.isEmpty) {
      isPaymentTypeValid[index].value = false;
      paymentTypeErrorMessage[index].value = 'Tipe pembayaran harus diisi';
    } else {
      isPaymentTypeValid[index].value = true;
      paymentTypeErrorMessage[index].value = null;
    }

    paymentData[index]['type'] = name;
  }

  void setPaymentNumber(int index, String number) {
    if (number.isEmpty) {
      isPaymentNumberValid[index].value = false;
      paymentNumberErrorMessage[index].value = 'Nomor pembayaran harus diisi';
    } else {
      isPaymentNumberValid[index].value = true;
      paymentNumberErrorMessage[index].value = null;
    }

    paymentData[index]['information'] = number;
  }

  Future<void> createPayment() async {
    resetState();
    _apiRequest.clear();
    for (int i = 0; i < paymentList.length; i++) {
      _apiRequest.add(CreatePaymentApiRequestModel.fromJson(paymentData[i]));
    }

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

    for (int i = 0; i < _apiRequest.length; i++) {
      await apiPayment
          .createPayment(eventId: _eventId!, requestBody: _apiRequest[i])
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
              'Pembayaran Tersimpan',
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
            Get.back();
            Get.toNamed(
              RouteName.createEventContactPersonScreen.replaceAll(
                ':id',
                _eventId!,
              ),
            );
          } else {
            Get.back();
          }
        },
      );
    }
  }
}
