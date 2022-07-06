import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/api_controller.dart';
import 'package:myevent_android/model/api_request/create_ticket_api_request_model.dart';
import 'package:myevent_android/model/api_response/view_event_detail_api_response_model.dart';
import 'package:myevent_android/provider/api_event.dart';
import 'package:myevent_android/provider/api_ticket.dart';
import 'package:myevent_android/route/route_name.dart';
import 'package:myevent_android/screen/create_event_ticket_screen/widget/create_event_ticket_screen_card_widget.dart';

class TicketController extends ApiController {
  RxBool isDailyTicket = false.obs;
  RxBool isPayedTicket = false.obs;
  RxList<Widget> ticketList = RxList();
  RxList<RxMap<String, dynamic>> ticketData = RxList();
  Rxn<DateTimeRange> registrationPeriod = Rxn<DateTimeRange>();
  RxInt ticketQuotaTotal = RxInt(0);
  final registrationDatePeriodFocusNode = FocusNode();
  final registrationDatePeriodController = TextEditingController();
  List<TextEditingController> nameController = [];
  List<TextEditingController> quotaController = [];
  List<TextEditingController> priceController = [];

  List<RxnString> nameErrorMessage = RxList();
  List<RxBool> isNameValid = RxList();
  List<RxnString> quotaErrorMessage = RxList();
  List<RxBool> isQuotaValid = RxList();
  List<RxnString> priceErrorMessage = RxList();
  List<RxBool> isPriceValid = RxList();
  RxnString registrationDatePeriodErrorMessage = RxnString();
  RxBool isRegistrationDatePeriodValid = false.obs;

  List<CreateTicketApiRequestModel> _apiRequest = [];

  final _eventId = Get.parameters['id'];
  Map<String, dynamic> _eventData = Get.arguments;
  int? totalEventDay;

  RxBool isLoading = false.obs;

  ViewEventDetailApiResponseModel? eventData;

  bool get isDataValid {
    if (isPayedTicket.value) {
      return !isNameValid.contains(false) &&
          !isQuotaValid.contains(false) &&
          !isPriceValid.contains(false) &&
          registrationPeriod.value != null;
    }
    return !isNameValid.contains(false) &&
        !isQuotaValid.contains(false) &&
        registrationPeriod.value != null;
  }

  @override
  void resetState() {}

  @override
  void onInit() {
    if (_eventData['canEdit']) {
      loadData();
    }
    initEventDate();
    initTicket();
    super.onInit();
  }

  Future<void> loadData() async {
    isLoading.value = true;
    apiEvent.getEventDetail(id: int.parse(_eventId!)).then((response) {
      checkApiResponse(response);
      if (apiResponseState.value == ApiResponseState.http2xx) {
        eventData = ViewEventDetailApiResponseModel.fromJson(response);
        isLoading.value = false;
        //daily ticket checklist
        if (eventData!.ticket!.isNotEmpty) {
          if (eventData!.ticket![0].quotaPerDay! > 0) {
            isDailyTicket.value = true;
          } else {
            isDailyTicket.value = false;
          }
        }
        //paid ticket checklist
        if (eventData!.ticket!.isNotEmpty) {
          if (eventData!.ticket![0].price! > 0) {
            isPayedTicket.value = true;
          } else {
            isPayedTicket.value = false;
          }
        }
      }
    });
  }

  void initEventDate() {
    final dateEventStart = _eventData['dateEventStart'] as DateTime;
    final dateEventEnd = _eventData['dateEventEnd'] as DateTime;
    totalEventDay = dateEventEnd.difference(dateEventStart).inDays.abs() + 1;
  }

  void _calculateTicketQuota(int index) {
    if (isDailyTicket.value) {
      ticketQuotaTotal.value += ticketData[index]['quotaTotal'] as int;
      ticketData[index]['quotaPerDay'] = int.parse(quotaController[index].text);
      ticketData[index]['quotaTotal'] *= totalEventDay;
    } else {
      ticketData[index]['quotaPerDay'] = 0;
      ticketData[index]['quotaTotal'] = int.parse(quotaController[index].text);
      ticketQuotaTotal.value += ticketData[index]['quotaTotal'] as int;
    }

    ticketQuotaTotal.value = 0;

    for (int i = 0; i < ticketList.length; i++) {
      ticketQuotaTotal.value += ticketData[i]['quotaTotal'] as int;
    }
  }

  void _calculateTicketQuotaTotal() {
    ticketQuotaTotal.value = 0;

    for (int i = 0; i < ticketList.length; i++) {
      if (isDailyTicket.value) {
        ticketData[i]['quotaPerDay'] = int.parse(quotaController[i].text);
        ticketData[i]['quotaTotal'] *= totalEventDay;
        ticketQuotaTotal.value += ticketData[i]['quotaTotal'] as int;
      } else {
        ticketData[i]['quotaPerDay'] = 0;
        ticketData[i]['quotaTotal'] = int.parse(quotaController[i].text);
        ticketQuotaTotal.value += ticketData[i]['quotaTotal'] as int;
      }
    }
  }

  void _calculateTicketQuotaTotalAfterRemove() {
    ticketQuotaTotal.value = 0;
    for (int i = 0; i < ticketList.length; i++) {
      ticketQuotaTotal.value += ticketData[i]['quotaTotal'] as int;
    }
  }

  void setIsDailyTicket(bool value) {
    isDailyTicket.value = value;

    _calculateTicketQuotaTotal();
  }

  void setIsPayedTicket(bool value) {
    isPayedTicket.value = value;
    initTicket();

    ever(isPayedTicket, (_) {
      _calculateTicketQuotaTotal();
      if (!isPayedTicket.value) {
        initTicket();
      }
    });
  }

  void addTicket() {
    _apiRequest.clear();
    ticketList.add(CreateEventTicketScreenCardWidget());
    ticketData.add(
      RxMap({
        'name': '',
        'quotaPerDay': 0,
        'quotaTotal': 0,
        'price': 0,
      }),
    );
    nameErrorMessage.add(RxnString());
    quotaErrorMessage.add(RxnString());
    priceErrorMessage.add(RxnString());
    isNameValid.add(RxBool(false));
    isQuotaValid.add(RxBool(false));
    isPriceValid.add(RxBool(false));
    nameController.add(TextEditingController());
    quotaController.add(TextEditingController());
    priceController.add(TextEditingController());
    nameController[ticketList.length - 1].text = '';
    quotaController[ticketList.length - 1].text = '0';
    priceController[ticketList.length - 1].text = '0';
  }

  void initTicket() {
    _apiRequest.clear();
    ticketQuotaTotal.value = 0;
    ticketList.clear();
    ticketData.clear();
    nameErrorMessage.clear();
    quotaErrorMessage.clear();
    priceErrorMessage.clear();
    isNameValid.clear();
    isQuotaValid.clear();
    isPriceValid.clear();
    ticketList.add(CreateEventTicketScreenCardWidget());
    ticketData.add(
      RxMap({
        'name': '',
        'quotaPerDay': 0,
        'quotaTotal': 0,
        'price': 0,
      }),
    );
    ticketData.add(
      RxMap({
        'name': '',
        'quotaPerDay': 0,
        'quotaTotal': 0,
        'price': 0,
      }),
    );
    ticketData.add(
      RxMap({
        'name': '',
        'quotaPerDay': 0,
        'quotaTotal': 0,
        'price': 0,
      }),
    );
    ticketData.add(
      RxMap({
        'name': '',
        'quotaPerDay': 0,
        'quotaTotal': 0,
        'price': 0,
      }),
    );
    nameErrorMessage.add(RxnString());
    quotaErrorMessage.add(RxnString());
    priceErrorMessage.add(RxnString());
    isNameValid.add(RxBool(false));
    isQuotaValid.add(RxBool(false));
    isPriceValid.add(RxBool(false));
    nameController.add(TextEditingController());
    quotaController.add(TextEditingController());
    priceController.add(TextEditingController());
    nameController[0].text = '';
    quotaController[0].text = '0';
    priceController[0].text = '0';
  }

  Future<void> setRegistrationDate() async {
    showDateRangePicker(
      context: Get.key.currentContext!,
      firstDate: DateTime(2000),
      lastDate: (_eventData['dateEventStart'] as DateTime).add(
        Duration(
          days: -1,
        ),
      ),
      currentDate: (_eventData['dateEventStart'] as DateTime).add(
        Duration(
          days: -1,
        ),
      ),
    ).then((dateTimeRange) {
      registrationPeriod.value = dateTimeRange!;
      final registrationDateStart = DateFormat('EEEE, d MMMM yyyy', 'id_ID')
          .format(registrationPeriod.value!.start);
      final registrationDateEnd = DateFormat('EEEE, d MMMM yyyy', 'id_ID')
          .format(registrationPeriod.value!.end);
      registrationDatePeriodController.text =
          '$registrationDateStart - $registrationDateEnd';
    });
  }

  void setTicketName(int index, String name) {
    if (name.isEmpty) {
      nameErrorMessage[index].value = 'Nama tiket harus diisi';
      isNameValid[index].value = false;
    } else {
      nameErrorMessage[index].value = null;
      isNameValid[index].value = true;
    }
    ticketData[index]['name'] = name;
  }

  void setTicketQuota(int index, String quota) {
    if (quota.isEmpty) {
      quotaErrorMessage[index].value = 'Jumlah tiket harus diisi';
      isQuotaValid[index].value = false;
      quotaController[index].text = '0';
    } else {
      quotaErrorMessage[index].value = null;
      isQuotaValid[index].value = true;
    }

    ticketData[index]['quotaTotal'] = int.parse(quotaController[index].text);

    _calculateTicketQuota(index);
  }

  void setTicketPrice(int index, String price) {
    if (price.isEmpty) {
      priceErrorMessage[index].value = 'Harga tiket harus diisi';
      isPriceValid[index].value = false;
      priceController[index].text = '0';
    } else {
      priceErrorMessage[index].value = null;
      isPriceValid[index].value = true;
    }

    ticketData[index]['price'] = int.parse(priceController[index].text);
  }

  Future<void> createTicket() async {
    _apiRequest.clear();
    for (int i = 0; i < ticketList.length; i++) {
      _apiRequest.add(
        CreateTicketApiRequestModel.fromJson({
          'name': ticketData[i]['name'],
          'price': ticketData[i]['price'],
          'dateTimeRegistrationStart':
              registrationPeriod.value!.start.toUtc().millisecondsSinceEpoch,
          'dateTimeRegistrationEnd':
              registrationPeriod.value!.end.toUtc().millisecondsSinceEpoch,
          'quotaPerDay': ticketData[i]['quotaPerDay'],
          'quotaTotal': ticketData[i]['quotaTotal'],
        }),
      );

      print(ticketData[i]);

      print(_apiRequest[i].name);
      print(_apiRequest[i].dateTimeRegistrationStart);
      print(_apiRequest[i].dateTimeRegistrationEnd);
      print(_apiRequest[i].quotaPerDay);
      print(_apiRequest[i].quotaTotal);
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
      await apiTicket
          .createTicket(eventId: _eventId!, requestBody: _apiRequest[i])
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
              'Tiket Tersimpan',
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
            Get.back(result: true);
            if (isPayedTicket.value) {
              Get.toNamed(
                RouteName.createEventPaymentScreen.replaceAll(':id', _eventId!),
              );
            } else {
              Get.toNamed(
                RouteName.createEventContactPersonScreen
                    .replaceAll(':id', _eventId!),
              );
            }
          } else {
            Get.back();
          }
        },
      );
    }
  }

  void removeTicket(int index) {
    ticketData.removeAt(index);
    ticketList.removeAt(index);
    nameErrorMessage.removeAt(index);
    quotaErrorMessage.removeAt(index);
    priceErrorMessage.removeAt(index);
    isNameValid.removeAt(index);
    isQuotaValid.removeAt(index);
    isPriceValid.removeAt(index);
    nameController.removeAt(index);
    quotaController.removeAt(index);
    priceController.removeAt(index);
    _calculateTicketQuotaTotalAfterRemove();
  }
}
