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
    return Padding(
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
                visible: controller.paymentList.length > 1,
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => controller.removePayment(index),
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
                  constraints: BoxConstraints(),
                ),
              ),
              TextFormField(
                // controller: controller.nameController[index!],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                // onChanged: (String name) {
                //   controller.setTicketName(index!, name);
                // },
                decoration: InputDecoration(
                  labelText: 'Tipe Pembayaran',
                  // errorText: controller.nameErrorMessage[index!].value,
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
                  // controller: controller.quotaController[index!],
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  // onChanged: (String quota) {
                  //   controller.setTicketQuota(index!, quota);
                  // },
                  decoration: InputDecoration(
                    labelText: 'No Rekening / No HP',
                    // errorText: controller.quotaErrorMessage[index!].value,
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
    );
  }
}
