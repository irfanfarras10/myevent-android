import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/payment_controller.dart';

class CreateEventPaymentScreenCardWidget extends StatelessWidget {
  final int? index;
  const CreateEventPaymentScreenCardWidget({
    Key? key,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PaymentController>();
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white70, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Visibility(
                  visible: controller.paymentList.length > 1 &&
                      !controller.paymentParam['canEdit'],
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => controller.removePayment(index),
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
                    constraints: BoxConstraints(),
                  ),
                ),
                TextFormField(
                  controller: controller.paymentTypeController[index!],
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  onChanged: (String name) {
                    controller.setPaymentType(index!, name);
                  },
                  decoration: InputDecoration(
                    labelText: 'Tipe Pembayaran',
                    errorText: controller.paymentTypeErrorMessage[index!].value,
                    helperText: 'Contoh: BCA, BRI / OVO, Gopay',
                    fillColor: MyEventColor.primaryColor,
                    labelStyle: TextStyle(
                      color: MyEventColor.secondaryColor,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: MyEventColor.secondaryColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: MyEventColor.secondaryColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: MyEventColor.primaryColor,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: TextFormField(
                    controller: controller.paymentNumberController[index!],
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    onChanged: (String number) {
                      controller.setPaymentNumber(index!, number);
                    },
                    decoration: InputDecoration(
                      labelText: 'No Rekening / No HP',
                      errorText:
                          controller.paymentNumberErrorMessage[index!].value,
                      helperText: 'Nomor Rekening / Nomor Tujuan',
                      fillColor: MyEventColor.primaryColor,
                      labelStyle: TextStyle(
                        color: MyEventColor.secondaryColor,
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: MyEventColor.secondaryColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: MyEventColor.secondaryColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: MyEventColor.primaryColor,
                        ),
                      ),
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
}
