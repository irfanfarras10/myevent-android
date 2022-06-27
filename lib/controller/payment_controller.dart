import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/screen/create_event_payment_screen/widget/create_event_payment_screen_card_widget.dart';

class PaymentController extends GetxController {
  RxList<CreateEventPaymentScreenCardWidget> paymentList = RxList();

  RxList<TextEditingController> paymentTypeController = RxList();
  RxList<TextEditingController> paymentNumberController = RxList();

  RxList<RxBool> isPaymentTypeValid = RxList();
  RxList<RxBool> isPaymentNumberValid = RxList();

  RxList<RxnString> paymentTypeErrorMessage = RxList();
  RxList<RxnString> paymentNumberErrorMessage = RxList();

  List<Map<String, dynamic>> paymentData = [];

  @override
  void onInit() {
    addPayment();
    super.onInit();
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
    for (int i = 0; i < paymentList.length; i++) {
      print(paymentData[i]['type']);
      print(paymentData[i]['information']);
    }
  }
}
