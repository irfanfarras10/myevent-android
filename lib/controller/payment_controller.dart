import 'package:get/get.dart';
import 'package:myevent_android/screen/create_event_payment_screen/widget/create_event_payment_screen_card_widget.dart';

class PaymentController extends GetxController {
  RxList<CreateEventPaymentScreenCardWidget> paymentList = RxList();

  @override
  void onInit() {
    addPayment();
    super.onInit();
  }

  void addPayment() {
    paymentList.add(CreateEventPaymentScreenCardWidget());
  }

  void removePayment(index) {
    paymentList.removeAt(index);
  }
}
