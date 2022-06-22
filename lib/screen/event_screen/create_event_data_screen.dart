import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/event_controller.dart';

class CreateEventDataScreen extends StatelessWidget {
  const CreateEventDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EventController>();
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(
            'Membuat Event',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: MyEventColor.secondaryColor,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                !controller.isBannerImageUploaded.value
                    ? Container(
                        decoration: BoxDecoration(color: Colors.grey),
                        width: double.infinity,
                        height: 200,
                        child: Material(
                          color: Colors.grey,
                          child: InkWell(
                            onTap: controller.onPressedUploadBanner,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Unggah Foto Banner'),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Icon(
                                  Icons.camera_alt,
                                  color: Colors.grey[800],
                                  size: 30.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        height: 200,
                        color: Colors.grey,
                        child: Image.file(
                          File(controller.bannerImage!.path),
                        ),
                      ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        // controller: controller.organizerNameController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        // focusNode: controller.organizerNameFocusNode,
                        onChanged: (String organizerName) {
                          // controller.validateOrganizerName(organizerName);
                        },
                        decoration: InputDecoration(
                          labelText: 'Nama Event',
                          // errorText: controller.organizerNameErrorMessage.value,
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
                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        // controller: controller.organizerNameController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        // focusNode: controller.organizerNameFocusNode,
                        onChanged: (String organizerName) {
                          // controller.validateOrganizerName(organizerName);
                        },
                        decoration: InputDecoration(
                          labelText: 'Deskripsi Event',
                          // errorText: controller.organizerNameErrorMessage.value,
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
                        maxLines: 5,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                border: Border.all(
                                  color: MyEventColor.secondaryColor,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Tanggal Mulai',
                                          style: TextStyle(
                                            color: MyEventColor.secondaryColor,
                                            fontSize: 16.0,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Icon(
                                        Icons.calendar_today,
                                        color: MyEventColor.secondaryColor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0, right: 5.0),
                            child: Text('-'),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                border: Border.all(
                                  color: MyEventColor.secondaryColor,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Tanggal Selesai',
                                          style: TextStyle(
                                            color: MyEventColor.secondaryColor,
                                            fontSize: 16.0,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Icon(
                                        Icons.calendar_today,
                                        color: MyEventColor.secondaryColor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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
                            height: 24.0,
                            width: 15.0,
                            child: Checkbox(
                              value: true,
                              onChanged: (bool) {},
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text('Untuk Satu Hari'),
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                border: Border.all(
                                  color: MyEventColor.secondaryColor,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Waktu Mulai',
                                          style: TextStyle(
                                            color: MyEventColor.secondaryColor,
                                            fontSize: 16.0,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Icon(
                                        Icons.access_time,
                                        color: MyEventColor.secondaryColor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0, right: 5.0),
                            child: Text('-'),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                border: Border.all(
                                  color: MyEventColor.secondaryColor,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Waktu Selesai',
                                          style: TextStyle(
                                            color: MyEventColor.secondaryColor,
                                            fontSize: 16.0,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Icon(
                                        Icons.access_time,
                                        color: MyEventColor.secondaryColor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButtonFormField(
                          items: [
                            DropdownMenuItem(
                              value: 'Webinar',
                              child: Text('Webinar'),
                            ),
                            DropdownMenuItem(
                              value: 'Seminar',
                              child: Text('Seminar'),
                            ),
                            DropdownMenuItem(
                              value: 'Konser',
                              child: Text('Konser'),
                            ),
                          ],
                          onChanged: (value) {},
                          hint: Text(
                            'Kategori Event',
                            style: TextStyle(
                              color: MyEventColor.secondaryColor,
                            ),
                          ),
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 27.0,
                          ),
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: MyEventColor.secondaryColor,
                              ),
                            ),
                            contentPadding: EdgeInsets.fromLTRB(
                              0.0,
                              18.0,
                              10.0,
                              18.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButtonFormField(
                          items: [
                            DropdownMenuItem(
                              value: 'Onsite',
                              child: Text('Onsite'),
                            ),
                            DropdownMenuItem(
                              value: 'Online',
                              child: Text('Online'),
                            ),
                          ],
                          onChanged: (value) {},
                          hint: Text(
                            'Jenis Tempat Event',
                            style: TextStyle(
                              color: MyEventColor.secondaryColor,
                            ),
                          ),
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 27.0,
                          ),
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: MyEventColor.secondaryColor,
                              ),
                            ),
                            contentPadding: EdgeInsets.fromLTRB(
                              0.0,
                              18.0,
                              10.0,
                              18.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        // controller: controller.organizerNameController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        // focusNode: controller.organizerNameFocusNode,
                        onChanged: (String organizerName) {
                          // controller.validateOrganizerName(organizerName);
                        },
                        decoration: InputDecoration(
                          labelText: 'Masukkan Lokasi',
                          // errorText: controller.organizerNameErrorMessage.value,
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
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(15.0),
          child: SizedBox(
            height: 60.0,
            child: ElevatedButton(
              onPressed: () {},
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
                'Atur Tiket',
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
