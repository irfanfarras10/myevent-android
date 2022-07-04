import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/api_controller.dart';
import 'package:myevent_android/controller/event_detail_controller.dart';
import 'package:myevent_android/widget/http_error_widget.dart';
import 'package:myevent_android/widget/loading_widget.dart';

class EventDetailScreen extends StatelessWidget {
  final controller = Get.find<EventDetailController>();

  @override
  Widget build(BuildContext context) {
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

          body = SingleChildScrollView(
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
                        'Belum Di Publish',
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
                    imageUrl: '',
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
                          Column(
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
                                'Webinar Data Analytics',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: MyEventColor.secondaryColor,
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                Text(
                                  'Edit',
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
                              'Webinar',
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
                              'Onsite',
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
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam ex ipsum, ultrices in egestas blandit, gravida eget odio. Integer vestibulum neque ut mi maximus, cursus tempus lorem commodo. In egestas tortor nec elementum efficitur. Curabitur ac ultrices felis. Donec faucibus, neque nec cursus tincidunt, arcu ipsum rhoncus est, vitae sagittis neque libero eget ligula. Praesent mattis leo eget dolor porta, finibus interdum nisl mollis. Sed fringilla est ut congue volutpat. Donec ligula velit, bibendum et metus in, ullamcorper mollis justo. Pellentesque malesuada metus id gravida elementum. Aliquam bibendum at ante eget lacinia. Sed semper lacus orci. Donec tincidunt mi arcu, maximus auctor odio tincidunt ac. Nullam a lorem sagittis neque vestibulum eleifend. ',
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
                                '18 Juni 2022 - 19 Juni 2022',
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
                                '09.00 - 15.00',
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    Text('Jl. Untung Suropati 2 RT 002 / 08   ',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          color: MyEventColor.secondaryColor,
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              ElevatedButton(
                                onPressed: () {},
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
                          ElevatedButton(
                            onPressed: () {},
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
                        ],
                      ),
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
                            '18 Juni 2022 - 19 Juni 2022',
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
                              value: true,
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
                              value: true,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Tiket (4 Hari)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: MyEventColor.secondaryColor,
                            ),
                          ),
                          Text(
                            '4000',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: MyEventColor.secondaryColor,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: List.generate(4, (index) {
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
                                    'Reguler',
                                    style: TextStyle(
                                      color: MyEventColor.secondaryColor,
                                    ),
                                  ),
                                  Text(
                                    '1000',
                                    style: TextStyle(
                                      color: MyEventColor.secondaryColor,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          );
                        }),
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
                          ElevatedButton(
                            onPressed: () {},
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
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Column(
                        children: List.generate(
                          3,
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
                                        'OVO',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: MyEventColor.secondaryColor,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        '085894577241',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: MyEventColor.secondaryColor,
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
                          ElevatedButton(
                            onPressed: () {},
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
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Column(
                        children: List.generate(
                          3,
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
                                        'Nama Tamu',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: MyEventColor.secondaryColor,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        'tamu@gmail.com',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: MyEventColor.secondaryColor,
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
                          ElevatedButton(
                            onPressed: () {},
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
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Column(
                        children: List.generate(
                          3,
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
                                        'Irfan',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: MyEventColor.secondaryColor,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        '085894577241',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: MyEventColor.secondaryColor,
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
          );
        }
        return Scaffold(
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
                visible: controller.eventData!.eventStatus!.id == 1 &&
                        !controller.isLoading.value
                    ? true
                    : false,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete),
                  tooltip: 'Hapus Event',
                ),
              ),
            ],
          ),
          backgroundColor: Colors.grey.shade200,
          body: body,
        );
      },
    );
  }
}
