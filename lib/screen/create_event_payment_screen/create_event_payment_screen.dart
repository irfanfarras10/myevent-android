import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/api_controller.dart';
import 'package:myevent_android/controller/payment_controller.dart';
import 'package:myevent_android/screen/create_event_payment_screen/widget/create_event_payment_screen_card_widget.dart';
import 'package:myevent_android/widget/http_error_widget.dart';
import 'package:myevent_android/widget/loading_widget.dart';

class CreateEventPaymentScreen extends StatelessWidget {
  final controller = Get.find<PaymentController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      Widget body;
      if (controller.isLoading.value) {
        body = LoadingWidget();
      } else {
        if (controller.apiResponseState.value != null &&
            controller.apiResponseState.value != ApiResponseState.http2xx &&
            controller.apiResponseState.value != ApiResponseState.http401) {
          return HttpErrorWidget(
            errorMessage: controller.errorMessage,
            refreshAction: controller.loadData,
          );
        }
        body = WillPopScope(
          onWillPop: () async {
            Get.back(result: true);
            return true;
          },
          child: GestureDetector(
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
                          return CreateEventPaymentScreenCardWidget(
                              index: index);
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
        );
      }
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Pengaturan Pembayaran',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: MyEventColor.secondaryColor,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_outlined),
            onPressed: () {
              Get.back(result: true);
            },
          ),
        ),
        body: body,
        bottomNavigationBar: controller.isLoading.value
            ? null
            : Container(
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
                    onPressed: controller.isDataValid
                        ? controller.createPayment
                        : null,
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
      );
    });
  }
}
