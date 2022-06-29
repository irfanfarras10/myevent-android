import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/payment_controller.dart';
import 'package:myevent_android/screen/create_event_payment_screen/widget/create_event_payment_screen_card_widget.dart';

class CreateEventPaymentScreen extends StatelessWidget {
  final controller = Get.find<PaymentController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(
            'Pengaturan Pembayaran',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: MyEventColor.secondaryColor,
            ),
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  //card widget
                  Column(
                    children: List.generate(
                      controller.paymentList.length,
                      (index) {
                        return CreateEventPaymentScreenCardWidget(index: index);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 60.0,
                    child: TextButton(
                      onPressed: controller.addPayment,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Tambahkan Pembayaran',
                            style: TextStyle(
                              fontSize: 17.0,
                              color: MyEventColor.secondaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Icon(
                            Icons.add,
                            color: MyEventColor.secondaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 6.0,
                offset: Offset(0.0, 3.0),
                color: Colors.black26,
              ),
            ],
          ),
          child: SizedBox(
            height: 60.0,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed:
                  controller.isDataValid ? controller.createPayment : null,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Colors.amber.shade300;
                    }
                    return Colors.amber;
                  },
                ),
              ),
              child: Text(
                'Simpan Pembayaran',
                style: TextStyle(
                  fontSize: 17.0,
                  color: MyEventColor.secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
