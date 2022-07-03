import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/event_controller.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:myevent_android/model/api_response/location_api_response_model.dart';

class CreateEventDataScreenWidget extends StatelessWidget {
  final controller = Get.find<EventController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          !controller.isBannerImageUploaded.value
              ? Container(
                  decoration: BoxDecoration(color: Colors.grey),
                  width: double.infinity,
                  height: 200,
                  child: Material(
                    color: Colors.grey,
                    child: InkWell(
                      onTap: controller.pickBannerPhoto,
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
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Image.file(
                        File(controller.bannerImage.value!.path),
                      ),
                      Container(
                        height: 70.0,
                        color: Colors.black.withOpacity(0.5),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: controller.pickBannerPhoto,
                                  child: Text(
                                    'Ubah',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Get.dialog(
                                      SizedBox(
                                        child: Image.file(
                                          File(
                                            controller.bannerImage.value!.path,
                                          ),
                                        ),
                                      ),
                                      barrierDismissible: true,
                                    );
                                  },
                                  child: Text(
                                    'Lihat',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: controller.nameController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  focusNode: controller.nameFocusNode,
                  onChanged: (String name) {
                    controller.validateName(name);
                  },
                  decoration: InputDecoration(
                    labelText: 'Nama Event',
                    errorText: controller.nameErrorMessage.value,
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
                  controller: controller.descriptionController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  focusNode: controller.descriptionFocusNode,
                  onChanged: (String description) {
                    controller.validateDescription(description);
                  },
                  decoration: InputDecoration(
                    labelText: 'Deskripsi Event',
                    errorText: controller.descriptionErrorMessage.value,
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
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.dateEventStartController,
                        textInputAction: TextInputAction.next,
                        focusNode: controller.dateEventStartFocusNode,
                        onTap: controller.setEventDateStart,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Tanggal Mulai',
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
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: controller.dateEventEndController,
                        textInputAction: TextInputAction.next,
                        focusNode: controller.dateEventEndFocusNode,
                        onTap: controller.setEventDateEnd,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Tanggal Selesai',
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
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Visibility(
                  visible: controller.dateEventErrorMessage.value != null,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 12.0,
                      bottom: 15.0,
                    ),
                    child: Text(
                      controller.dateEventErrorMessage.value ?? '',
                      style: TextStyle(
                        color: Colors.red.shade800,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.timeEventStartController,
                        textInputAction: TextInputAction.next,
                        focusNode: controller.timeEventStartFocusNode,
                        onTap: controller.setEventTimeStart,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Waktu Mulai',
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
                          suffixIcon: Icon(Icons.access_time),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: controller.timeEventEndController,
                        textInputAction: TextInputAction.next,
                        focusNode: controller.timeEventEndFocusNode,
                        onTap: controller.setEventTimeEnd,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Waktu Selesai',
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
                          suffixIcon: Icon(Icons.access_time),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Visibility(
                  visible: controller.timeEventErrorMessage.value != null,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 12.0,
                      bottom: 15.0,
                    ),
                    child: Text(
                      controller.timeEventErrorMessage.value ?? '',
                      style: TextStyle(
                        color: Colors.red.shade800,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButtonFormField<int>(
                    items: [
                      DropdownMenuItem(
                        value: 1,
                        child: Text('Onsite'),
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: Text('Online'),
                      ),
                    ],
                    onChanged: (venue) {
                      controller.setEventVenueCategory(venue!);
                    },
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
                controller.isOnsiteEvent.value == null
                    ? Container()
                    : controller.isOnsiteEvent.value!
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: TypeAheadField<Features>(
                              textFieldConfiguration: TextFieldConfiguration(
                                decoration: InputDecoration(
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
                                  labelText: 'Lokasi Event',
                                  labelStyle: TextStyle(
                                    color: MyEventColor.secondaryColor,
                                  ),
                                  errorText:
                                      controller.locationErrorMessage.value,
                                ),
                                controller: controller.locationController,
                                onChanged: (String location) {
                                  controller.validateLocation(location);
                                },
                              ),
                              suggestionsCallback: (location) async {
                                var data =
                                    await controller.findLocation(location);
                                // if (data['code'] != 400) {
                                //   return [];
                                // }
                                return data;
                              },
                              itemBuilder: (context, Features location) {
                                try {
                                  return ListTile(
                                    leading: Icon(Icons.location_on),
                                    title: Text(
                                      location.properties!.name != null
                                          ? location.properties!.name!
                                          : location.properties!.city != null
                                              ? location.properties!.city!
                                              : location.properties!.street !=
                                                      null
                                                  ? location.properties!.street!
                                                  : location.properties!
                                                      .addressLine1!,
                                    ),
                                  );
                                } catch (e) {
                                  print(e);
                                  throw e;
                                }
                              },
                              onSuggestionSelected: (location) {
                                controller.setVenue(
                                  location: location.properties!.name == null
                                      ? location.properties!.city!
                                      : location.properties!.name!,
                                  lon: location.properties!.lon!,
                                  lat: location.properties!.lat!,
                                );
                              },
                              noItemsFoundBuilder: (context) {
                                return Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text('Lokasi Tidak Diemukan'),
                                );
                              },
                              errorBuilder: (context, error) {
                                return Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text('Lokasi Tidak Diemukan'),
                                );
                              },
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: TextFormField(
                              controller: controller.locationController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.name,
                              focusNode: controller.locationFocusNode,
                              onChanged: (String location) {
                                controller.validateLocation(location);
                              },
                              decoration: InputDecoration(
                                labelText: 'Link Video Conference',
                                errorText:
                                    controller.locationErrorMessage.value,
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
                ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButtonFormField<int>(
                    items: controller.eventCategoryList
                        .map(
                          (category) => DropdownMenuItem(
                            value: category.id,
                            child: Text(category.name!),
                          ),
                        )
                        .toList(),
                    onChanged: (category) {
                      controller.setEventCategory(category!);
                    },
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
                SizedBox(height: 80.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
