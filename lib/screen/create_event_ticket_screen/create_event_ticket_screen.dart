import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/ticket_controller.dart';
import 'package:myevent_android/screen/create_event_ticket_screen/widget/create_event_ticket_screen_card_widget.dart';

class CreateEventTicketScreen extends StatelessWidget {
  const CreateEventTicketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TicketController>();
    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Membuat Tiket',
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
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tiket Harian',
                              style: TextStyle(
                                color: MyEventColor.secondaryColor,
                                fontSize: 16.5,
                              ),
                            ),
                            SizedBox(
                              width: 12.0,
                              child: Checkbox(
                                value: controller.isDailyTicket.value,
                                onChanged: (value) =>
                                    controller.setIsDailyTicket(value!),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tiket Berbayar',
                              style: TextStyle(
                                color: MyEventColor.secondaryColor,
                                fontSize: 16.5,
                              ),
                            ),
                            SizedBox(
                              width: 12.0,
                              child: Checkbox(
                                value: controller.isPayedTicket.value,
                                onChanged: (value) =>
                                    controller.setIsPayedTicket(value!),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          controller:
                              controller.registrationDatePeriodController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          focusNode: controller.registrationDatePeriodFocusNode,
                          readOnly: true,
                          onTap: controller.setRegistrationDate,
                          decoration: InputDecoration(
                            labelText: 'Tanggal Registrasi Tiket',
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
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        //card widget
                        Column(
                          children: List.generate(
                            controller.ticketList.length,
                            (index) {
                              return CreateEventTicketScreenCardWidget(
                                index: index,
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Visibility(
                          visible: controller.ticketList.length == 4,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Text(
                              ' - Maksimal 4 Tiket - ',
                              style: TextStyle(
                                fontSize: 16.5,
                                fontWeight: FontWeight.bold,
                                color: MyEventColor.secondaryColor,
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: controller.isPayedTicket.value &&
                              controller.ticketList.length < 4,
                          child: SizedBox(
                            height: 60.0,
                            child: TextButton(
                              onPressed: controller.addTicket,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Tambahkan Tiket',
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
                        ),
                      ],
                    ),
                  )
                ],
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Total Tiket',
                          style: TextStyle(
                            color: MyEventColor.secondaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.5,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        controller.registrationPeriod.value != null
                            ? Text(
                                '(${controller.registrationPeriod.value!.duration.inDays + 1} Hari)',
                                style: TextStyle(
                                  color: MyEventColor.secondaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.5,
                                ),
                              )
                            : Container(),
                      ],
                    ),
                    Text(
                      controller.ticketQuotaTotal.value.toString(),
                      style: TextStyle(
                        color: MyEventColor.secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.5,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    controller.ticketData[0]['name'] != null
                        ? Text(
                            controller.ticketData[0]['name'],
                            style: TextStyle(
                              color: MyEventColor.secondaryColor,
                              fontSize: 16.5,
                            ),
                          )
                        : Container(),
                    SizedBox(
                      width: 5.0,
                    ),
                    controller.ticketData[0]['quota'] != 0
                        ? Text(
                            controller.ticketData[0]['quota'].toString(),
                            style: TextStyle(
                              color: MyEventColor.secondaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.5,
                            ),
                          )
                        : Container(),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    controller.ticketData[1]['name'] != null
                        ? Text(
                            controller.ticketData[1]['name'],
                            style: TextStyle(
                              color: MyEventColor.secondaryColor,
                              fontSize: 16.5,
                            ),
                          )
                        : Container(),
                    SizedBox(
                      width: 5.0,
                    ),
                    controller.ticketData[1]['quota'] != 0
                        ? Text(
                            controller.ticketData[1]['quota'].toString(),
                            style: TextStyle(
                              color: MyEventColor.secondaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.5,
                            ),
                          )
                        : Container(),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    controller.ticketData[2]['name'] != null
                        ? Text(
                            controller.ticketData[2]['name'],
                            style: TextStyle(
                              color: MyEventColor.secondaryColor,
                              fontSize: 16.5,
                            ),
                          )
                        : Container(),
                    SizedBox(
                      width: 5.0,
                    ),
                    controller.ticketData[2]['quota'] != 0
                        ? Text(
                            controller.ticketData[2]['quota'].toString(),
                            style: TextStyle(
                              color: MyEventColor.secondaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.5,
                            ),
                          )
                        : Container(),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    controller.ticketData[3]['name'] != null
                        ? Text(
                            controller.ticketData[3]['name'],
                            style: TextStyle(
                              color: MyEventColor.secondaryColor,
                              fontSize: 16.5,
                            ),
                          )
                        : Container(),
                    SizedBox(
                      width: 5.0,
                    ),
                    controller.ticketData[3]['quota'] != 0
                        ? Text(
                            controller.ticketData[3]['quota'].toString(),
                            style: TextStyle(
                              color: MyEventColor.secondaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.5,
                            ),
                          )
                        : Container(),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: 60.0,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: controller.isDataValid
                        ? () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            controller.createTicket();
                          }
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
                      'Simpan Tiket',
                      style: TextStyle(
                        fontSize: 17.0,
                        color: MyEventColor.secondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
