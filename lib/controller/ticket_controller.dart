import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myevent_android/screen/create_event_ticket_screen/widget/create_event_ticket_screen_card_widget.dart';

class TicketController extends GetxController {
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
  void onInit() {
    initTicket();
    super.onInit();
  }

  void _calculateTicketPriceTotal() {
    ticketQuotaTotal.value = 0;
    if (registrationPeriod.value != null) {
      ticketData.forEach((data) {
        ticketQuotaTotal.value += data['quota'] as int;
      });

      if (isDailyTicket.value) {
        ticketQuotaTotal.value *= registrationPeriod.value!.duration.inDays + 1;
      }
    }
  }

  void setIsDailyTicket(bool value) {
    isDailyTicket.value = value;

    ever(isDailyTicket, (_) {
      _calculateTicketPriceTotal();
    });
  }

  void setIsPayedTicket(bool value) {
    isPayedTicket.value = value;
    initTicket();

    ever(isPayedTicket, (_) {
      _calculateTicketPriceTotal();
      if (!isPayedTicket.value) {
        initTicket();
      }
    });
  }

  void addTicket() {
    ticketList.add(CreateEventTicketScreenCardWidget());
    ticketData.add(
      RxMap({
        'name': '',
        'quota': 0,
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
        'quota': 0,
        'price': 0,
      }),
    );
    ticketData.add(
      RxMap({
        'name': '',
        'quota': 0,
        'price': 0,
      }),
    );
    ticketData.add(
      RxMap({
        'name': '',
        'quota': 0,
        'price': 0,
      }),
    );
    ticketData.add(
      RxMap({
        'name': '',
        'quota': 0,
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
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    ).then((dateTimeRange) {
      registrationPeriod.value = dateTimeRange!;
      final registrationDateStart = DateFormat('EEEE, d MMMM yyyy', 'id_ID')
          .format(registrationPeriod.value!.start);
      final registrationDateEnd = DateFormat('EEEE, d MMMM yyyy', 'id_ID')
          .format(registrationPeriod.value!.end);
      registrationDatePeriodController.text =
          '$registrationDateStart - $registrationDateEnd';
      _calculateTicketPriceTotal();
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

    ticketData[index]['quota'] = int.parse(quotaController[index].text);

    ever(
      ticketData[index],
      (_) {
        print('cek cek cek');
        _calculateTicketPriceTotal();
      },
    );
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
}
