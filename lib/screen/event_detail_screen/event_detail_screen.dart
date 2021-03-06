import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/api_controller.dart';
import 'package:myevent_android/controller/event_detail_controller.dart';
import 'package:myevent_android/model/api_response/view_event_detail_api_response_model.dart';
import 'package:myevent_android/route/route_name.dart';
import 'package:myevent_android/util/location_util.dart';
import 'package:myevent_android/widget/http_error_widget.dart';
import 'package:myevent_android/widget/loading_widget.dart';
import 'package:myevent_android/widget/navigation_drawer_widget.dart';

class EventDetailScreen extends StatelessWidget {
  final secondaryMenu = <String>['Batalkan'];

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EventDetailController>();
    return Obx(
      () {
        Widget body;
        if (controller.isLoading.value) {
          body = LoadingWidget();
        } else {
          if (controller.apiResponseState.value != ApiResponseState.http2xx &&
              controller.apiResponseState.value != ApiResponseState.http401) {
            return HttpErrorWidget(
              errorMessage: controller.errorMessage,
              refreshAction: controller.loadData,
            );
          }

          body = RefreshIndicator(
            onRefresh: controller.loadData,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(15.0),
                    color: Colors.grey.shade50,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'STATUS',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: MyEventColor.secondaryColor,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          _getStatusText(controller.eventData!.eventStatus!),
                          style: TextStyle(
                            fontSize: 16.0,
                            color: MyEventColor.secondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: CachedNetworkImage(
                      imageUrl: controller.eventData!.bannerPhoto!,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey.shade100,
                        child: Center(
                          child: Icon(
                            Icons.image,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Nama Event',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: MyEventColor.secondaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    controller.eventData!.name!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                      color: MyEventColor.secondaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible:
                                  controller.eventData!.eventStatus!.id == 1
                                      ? true
                                      : false,
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.toNamed(
                                    RouteName.editEventDataScreen.replaceAll(
                                      ':id',
                                      controller.eventData!.id!.toString(),
                                    ),
                                  )!
                                      .then((refresh) {
                                    if (refresh) {
                                      controller.loadData();
                                    }
                                  });
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'Edit',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Icon(
                                      Icons.edit,
                                      size: 16.5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                color: MyEventColor.primaryColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4.0),
                                ),
                              ),
                              child: Text(
                                controller.eventData!.eventCategory!.name!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: MyEventColor.secondaryColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Container(
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                color: MyEventColor.secondaryColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4.0),
                                ),
                              ),
                              child: Text(
                                controller.eventData!.eventVenueCategory!.name!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Deskripsi Event',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: MyEventColor.secondaryColor,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              controller.eventData!.description!,
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tanggal dan Waktu Event',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: MyEventColor.secondaryColor,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.date_range,
                                  size: 16.5,
                                  color: MyEventColor.secondaryColor,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  _parseEventDate(
                                    controller.eventData!.dateEventStart!,
                                    controller.eventData!.dateEventEnd!,
                                  ),
                                  style: TextStyle(
                                    color: MyEventColor.secondaryColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 16.5,
                                  color: MyEventColor.secondaryColor,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  _parseEventTime(
                                    controller.eventData!.timeEventStart!,
                                    controller.eventData!.timeEventEnd!,
                                  ),
                                  style: TextStyle(
                                    color: MyEventColor.secondaryColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Lokasi Event',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: MyEventColor.secondaryColor,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      FutureBuilder<String>(
                                        future: locationUtil.parseLocation(
                                          controller
                                              .eventData!.eventVenueCategory!,
                                          controller.eventData!.venue!,
                                        ),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(
                                              snapshot.data.toString(),
                                              style: TextStyle(
                                                color:
                                                    MyEventColor.secondaryColor,
                                              ),
                                            );
                                          } else {
                                            return Text(
                                              '',
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 15.0,
                                ),
                                Visibility(
                                  visible: controller
                                          .eventData!.eventVenueCategory!.id ==
                                      1,
                                  child: ElevatedButton(
                                    onPressed: controller.openLocation,
                                    child: Row(
                                      children: [
                                        Text(
                                          'Lihat Lokasi',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: MyEventColor.secondaryColor,
                                          ),
                                        ),
                                        Icon(
                                          Icons.location_on,
                                          size: 16.5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Tiket',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Visibility(
                              visible:
                                  controller.eventData!.eventStatus!.id == 1
                                      ? true
                                      : false,
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.toNamed(
                                    RouteName.createEventTicketScreen
                                        .replaceAll(
                                      ':id',
                                      controller.eventData!.id!.toString(),
                                    ),
                                    arguments: {
                                      'dateEventStart':
                                          DateTime.fromMillisecondsSinceEpoch(
                                        controller.eventData!.dateEventStart!,
                                      ),
                                      'dateEventEnd':
                                          DateTime.fromMillisecondsSinceEpoch(
                                        controller.eventData!.dateEventEnd!,
                                      ),
                                      'canEdit':
                                          controller.eventData!.ticket!.isEmpty
                                              ? false
                                              : true,
                                    },
                                  )!
                                      .then((refresh) {
                                    if (refresh) {
                                      controller.loadData();
                                    }
                                  });
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'Edit',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: MyEventColor.secondaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Icon(
                                      Icons.edit,
                                      size: 16.5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        controller.eventData!.ticket!.isEmpty
                            ? Center(
                                child: Text(
                                  'Tidak ada data tiket',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: MyEventColor.secondaryColor,
                                  ),
                                ),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Tanggal Registrasi',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: MyEventColor.secondaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.date_range,
                                        size: 16.5,
                                        color: MyEventColor.secondaryColor,
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        _parseEventDate(
                                          controller.eventData!
                                              .dateTimeRegistrationStart!,
                                          controller.eventData!
                                              .dateTimeRegistrationEnd!,
                                        ),
                                        style: TextStyle(
                                          color: MyEventColor.secondaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 20.0,
                                        height: 10.0,
                                        child: Checkbox(
                                          value: controller.eventData!
                                                      .ticket![0].quotaPerDay! >
                                                  0
                                              ? true
                                              : false,
                                          onChanged: (checked) {},
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        'Tiket Harian',
                                        style: TextStyle(
                                          color: MyEventColor.secondaryColor,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 20.0,
                                        height: 10.0,
                                        child: Checkbox(
                                          value: controller.eventData!
                                                      .ticket![0].price! >
                                                  0
                                              ? true
                                              : false,
                                          onChanged: (checked) {},
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        'Tiket Berbayar',
                                        style: TextStyle(
                                          color: MyEventColor.secondaryColor,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total Tiket (${_getTotalEventDay(controller.eventData!.dateEventStart!, controller.eventData!.dateEventEnd!)} Hari)',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: MyEventColor.secondaryColor,
                                        ),
                                      ),
                                      Text(
                                        controller.calculateTicketTotal(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: MyEventColor.secondaryColor,
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: List.generate(
                                        controller.eventData!.ticket!.length,
                                        (index) {
                                      controller.eventData!.ticket!.sort(
                                        (a, b) => a.id!.compareTo(b.id!),
                                      );
                                      return Column(
                                        children: [
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                controller.eventData!
                                                    .ticket![index].name!,
                                                style: TextStyle(
                                                  color: MyEventColor
                                                      .secondaryColor,
                                                ),
                                              ),
                                              Text(
                                                '${controller.eventData!.ticket![index].quotaTotal!}',
                                                style: TextStyle(
                                                  color: MyEventColor
                                                      .secondaryColor,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      );
                                    }),
                                  ),
                                ],
                              )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Pembayaran',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: MyEventColor.secondaryColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Visibility(
                              visible: controller.eventData!.eventStatus!.id ==
                                      1 &&
                                  controller.eventData!.ticket!.isNotEmpty &&
                                  controller.eventData!.eventPaymentCategory!
                                          .id ==
                                      2,
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.toNamed(
                                    RouteName.createEventPaymentScreen
                                        .replaceAll(
                                      ':id',
                                      controller.eventData!.id!.toString(),
                                    ),
                                    arguments: {
                                      'canEdit': controller
                                              .eventData!.eventPayment!.isEmpty
                                          ? false
                                          : true,
                                    },
                                  )!
                                      .then((refresh) {
                                    if (refresh) {
                                      controller.loadData();
                                    }
                                  });
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'Edit',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: MyEventColor.secondaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Icon(
                                      Icons.edit,
                                      size: 16.5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        controller.eventData!.eventPayment!.isEmpty
                            ? Center(
                                child: Text(
                                  'Tidak ada data pembayaran',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: MyEventColor.secondaryColor,
                                  ),
                                ),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                  controller.eventData!.eventPayment!.length,
                                  (index) {
                                    return SizedBox(
                                      width: double.infinity,
                                      child: Card(
                                        shadowColor: Colors.black12,
                                        color: Colors.grey.shade100,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller.eventData!
                                                    .eventPayment![index].type!,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: MyEventColor
                                                      .secondaryColor,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                controller
                                                    .eventData!
                                                    .eventPayment![index]
                                                    .information!,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: MyEventColor
                                                      .secondaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Tamu Undangan',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: MyEventColor.secondaryColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Visibility(
                              visible:
                                  controller.eventData!.eventStatus!.id == 1
                                      ? true
                                      : false,
                              child: ElevatedButton(
                                onPressed: () async {
                                  await Get.toNamed(
                                    RouteName.createGuestScreen.replaceAll(
                                      ':id',
                                      controller.eventData!.id!.toString(),
                                    ),
                                    arguments: {
                                      'canEdit': false,
                                    },
                                  )!
                                      .then((refresh) {
                                    if (refresh) {
                                      controller.loadData();
                                    }
                                  });
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'Tambah',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: MyEventColor.secondaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Icon(
                                      Icons.add,
                                      size: 16.5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        controller.eventData!.eventGuest!.isEmpty
                            ? Center(
                                child: Text(
                                  'Tidak ada data tamu',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: MyEventColor.secondaryColor,
                                  ),
                                ),
                              )
                            : Column(
                                children: List.generate(
                                  controller.eventData!.eventGuest!.length,
                                  (index) {
                                    return SizedBox(
                                      width: double.infinity,
                                      child: Card(
                                        shadowColor: Colors.black12,
                                        color: Colors.grey.shade100,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller.eventData!
                                                    .eventGuest![index].name!,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: MyEventColor
                                                      .secondaryColor,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                controller.eventData!
                                                    .eventGuest![index].email!,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: MyEventColor
                                                      .secondaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Contact Person',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: MyEventColor.secondaryColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Visibility(
                              visible:
                                  controller.eventData!.eventStatus!.id == 1
                                      ? true
                                      : false,
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.toNamed(
                                    RouteName.createEventContactPersonScreen
                                        .replaceAll(
                                      ':id',
                                      controller.eventData!.id!.toString(),
                                    ),
                                    arguments: {
                                      'canEdit': controller.eventData!
                                              .eventContactPerson!.isEmpty
                                          ? false
                                          : true,
                                    },
                                  )!
                                      .then(
                                    (refresh) {
                                      if (refresh) {
                                        controller.loadData();
                                      }
                                    },
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'Edit',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: MyEventColor.secondaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Icon(
                                      Icons.edit,
                                      size: 16.5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        controller.eventData!.eventContactPerson!.isEmpty
                            ? Center(
                                child: Text(
                                  'Tidak ada data contact person',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: MyEventColor.secondaryColor,
                                  ),
                                ),
                              )
                            : Column(
                                children: List.generate(
                                  controller
                                      .eventData!.eventContactPerson!.length,
                                  (index) {
                                    return SizedBox(
                                      width: double.infinity,
                                      child: Card(
                                        shadowColor: Colors.black12,
                                        color: Colors.grey.shade100,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller
                                                    .eventData!
                                                    .eventContactPerson![index]
                                                    .name!,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: MyEventColor
                                                      .secondaryColor,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                '${controller.eventData!.eventContactPerson![index].eventSocialMedia!.name}: ${controller.eventData!.eventContactPerson![index].contact}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: MyEventColor
                                                      .secondaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return WillPopScope(
          onWillPop: () async {
            Get.back(result: true);
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Detail Event',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: MyEventColor.secondaryColor,
                ),
              ),
              actions: [
                Visibility(
                  visible: controller.eventData != null &&
                          controller.eventData!.eventStatus!.id == 1 &&
                          !controller.isLoading.value
                      ? true
                      : false,
                  child: IconButton(
                    onPressed: controller.deleteEvent,
                    icon: Icon(Icons.delete),
                    tooltip: 'Hapus Event',
                  ),
                ),
                Visibility(
                  visible: controller.eventData != null &&
                      (controller.eventData!.eventStatus!.id == 2 ||
                          controller.eventData!.eventStatus!.id == 3) &&
                      !controller.isLoading.value,
                  child: PopupMenuButton<String>(
                      itemBuilder: (BuildContext context) {
                    return secondaryMenu.map((String choice) {
                      return PopupMenuItem<String>(
                        child: Text(choice),
                        value: choice,
                      );
                    }).toList();
                  }, onSelected: (item) {
                    switch (item) {
                      case 'Batalkan':
                        Get.defaultDialog(
                          title: 'Batalkan Event',
                          content: Text(
                            'Apakah Anda ingin membatalkan event',
                            textAlign: TextAlign.center,
                          ),
                          textConfirm: 'Ya',
                          textCancel: 'Tidak',
                          confirmTextColor: MyEventColor.secondaryColor,
                          barrierDismissible: false,
                          onConfirm: () async {
                            Get.back();
                            Get.dialog(
                              AlertDialog(
                                title: Text(
                                  'Alasan Pembatalan',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: MyEventColor.secondaryColor,
                                  ),
                                ),
                                content: Obx(
                                  () => SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextFormField(
                                          controller: controller
                                              .cancelTextEditingController,
                                          textInputAction: TextInputAction.done,
                                          keyboardType: TextInputType.name,
                                          onChanged: (String message) {
                                            controller
                                                .validateCancelMessage(message);
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'Alasan Pembatalan',
                                            errorText: controller
                                                .cancelErrorMessage.value,
                                            fillColor:
                                                MyEventColor.primaryColor,
                                            labelStyle: TextStyle(
                                              color:
                                                  MyEventColor.secondaryColor,
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color:
                                                    MyEventColor.secondaryColor,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color:
                                                    MyEventColor.secondaryColor,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color:
                                                    MyEventColor.primaryColor,
                                              ),
                                            ),
                                          ),
                                          maxLines: 20,
                                        ),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        SizedBox(
                                          height: 60.0,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: ElevatedButton(
                                            onPressed: controller
                                                    .isCancelButtonValid.value
                                                ? controller.cancelEvent
                                                : null,
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty
                                                      .resolveWith<Color>(
                                                (states) {
                                                  if (states.contains(
                                                      MaterialState.disabled)) {
                                                    return Colors
                                                        .amber.shade300;
                                                  }
                                                  return Colors.amber;
                                                },
                                              ),
                                            ),
                                            child: Text(
                                              'Konfirmasi Pembatalan',
                                              style: TextStyle(
                                                fontSize: 17.0,
                                                color:
                                                    MyEventColor.secondaryColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ).then((_) {
                              controller.isCancelButtonValid.value = false;
                              controller.cancelErrorMessage.value = null;
                            });
                          },
                        );
                        break;
                    }
                  }),
                ),
              ],
            ),
            backgroundColor: Colors.grey.shade200,
            body: body,
            bottomNavigationBar: controller.getBottomButton(),
            drawer: !controller.isLoading.value
                ? NavigationDrawerWidget(eventData: controller.eventData!)
                : null,
          ),
        );
      },
    );
  }

  String _getStatusText(EventStatus eventStatus) {
    String? statusText;
    switch (eventStatus.id) {
      case 1:
        statusText = 'Belum di Publish';
        break;
      case 2:
        statusText = 'Akan Datang';
        break;
      case 3:
        statusText = 'Sedang Berjalan';
        break;
      case 4:
        statusText = 'Selesai';
        break;
      case 5:
        statusText = 'Dibatalkan';
        break;
      default:
    }
    return statusText!;
  }

  String _parseEventDate(int dateEventStart, int dateEventEnd) {
    String? dateTimeEvent;
    String dateEventStartString = DateFormat('d MMMM yyyy', 'id_ID').format(
      DateTime.fromMillisecondsSinceEpoch(dateEventStart),
    );
    String dateEventEndString = DateFormat('d MMMM yyyy', 'id_ID').format(
      DateTime.fromMillisecondsSinceEpoch(dateEventEnd),
    );
    dateTimeEvent = '$dateEventStartString - $dateEventEndString';
    return dateTimeEvent;
  }

  String _parseEventTime(int timeEventStart, int timeEventEnd) {
    String? dateTimeEvent;
    String timeEventStartString = DateFormat('HH:mm', 'id_ID').format(
      DateTime.fromMillisecondsSinceEpoch(timeEventStart),
    );
    String timeEventEndString = DateFormat('HH:mm', 'id_ID').format(
      DateTime.fromMillisecondsSinceEpoch(timeEventEnd),
    );
    dateTimeEvent = '$timeEventStartString - $timeEventEndString';
    return dateTimeEvent;
  }

  String _getTotalEventDay(int dateTimeEventStart, int dateTimeEventEnd) {
    int totalEventDay;
    totalEventDay = DateTime.fromMillisecondsSinceEpoch(dateTimeEventEnd)
            .difference(DateTime.fromMillisecondsSinceEpoch(dateTimeEventStart))
            .inDays +
        1;
    return totalEventDay.toString();
  }
}
