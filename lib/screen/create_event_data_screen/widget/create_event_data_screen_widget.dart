import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/event_controller.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:myevent_android/model/api_response/location_api_response_model.dart';

class CreateEventDataScreenWidget extends StatelessWidget {
  const CreateEventDataScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EventController>();
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
                      child: TextFormField(
                        controller: controller.dateEventStartController,
                        textInputAction: TextInputAction.next,
                        // focusNode: controller.organizerNameFocusNode,
                        onTap: controller.setEventDateStart,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Tanggal Mulai Event',
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
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Text('-'),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: controller.dateEventEndController,
                        textInputAction: TextInputAction.next,
                        // focusNode: controller.organizerNameFocusNode,
                        onTap: controller.setEventDateEnd,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Tanggal Selesai Event',
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
                          suffixIcon: Icon(Icons.calendar_today),
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
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                      child: TextFormField(
                        controller: controller.timeEventStartController,
                        textInputAction: TextInputAction.next,
                        // focusNode: controller.organizerNameFocusNode,
                        onTap: controller.setEventTimeStart,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Jam Mulai Event',
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
                          suffixIcon: Icon(Icons.access_time),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Text('-'),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: controller.timeEventEndController,
                        textInputAction: TextInputAction.next,
                        // focusNode: controller.organizerNameFocusNode,
                        onTap: controller.setEventTimeEnd,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Jam Selesai Event',
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
                          suffixIcon: Icon(Icons.access_time),
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
                  child: DropdownButtonFormField<String>(
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
                    onChanged: (venue) {
                      controller.selectVenueType(venue!);
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
                                ),
                                controller: controller.locationController,
                              ),
                              suggestionsCallback: (location) async {
                                return await controller.findLocation(location);
                              },
                              itemBuilder: (context, Features location) {
                                return ListTile(
                                  leading: Icon(Icons.location_on),
                                  title: Text(location.properties!.name == null
                                      ? location.properties!.city!
                                      : location.properties!.name!),
                                );
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
                              // controller: controller.organizerNameController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.name,
                              // focusNode: controller.organizerNameFocusNode,
                              onChanged: (String organizerName) {
                                // controller.validateOrganizerName(organizerName);
                              },
                              decoration: InputDecoration(
                                labelText: 'Link Video Conference',
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
                          ),
                ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButtonFormField(
                    items: controller.eventCategoryList
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.name!),
                          ),
                        )
                        .toList(),
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
                SizedBox(height: 80.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
