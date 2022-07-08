import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/contact_person_controller.dart';

class CreateEventContactPersonCardWidget extends StatelessWidget {
  final int? index;
  const CreateEventContactPersonCardWidget({Key? key, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ContactPersonController>();
    return Obx(
      () => Padding(
        padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
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
                  visible: controller.contactPersonList.length > 1,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => controller.removeContactPerson(index!),
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
                    constraints: BoxConstraints(),
                  ),
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  onChanged: (String name) {
                    controller.setContactPersonName(index!, name);
                  },
                  controller: controller.contactPersonNameController[index!],
                  decoration: InputDecoration(
                    labelText: 'Nama',
                    errorText:
                        controller.contactPersonNameErrorMessage[index!].value,
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
                    textInputAction: TextInputAction.next,
                    onChanged: (String number) {
                      controller.setContactPersonNumber(index!, number);
                    },
                    controller:
                        controller.contactPersonNumberController[index!],
                    decoration: InputDecoration(
                      labelText: 'ID / Nomor Media Sosial',
                      errorText: controller
                          .contactPersonNumberErrorMessage[index!].value,
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
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButtonFormField<int>(
                      items: controller.contactPersonSocialMedia
                          .map(
                            (category) => DropdownMenuItem(
                              value: category.id,
                              child: Text(category.name!),
                            ),
                          )
                          .toList(),
                      value: controller.contactPersonSocialMediaIdValue.isEmpty
                          ? null
                          : controller.contactPersonSocialMediaIdValue[index!],
                      onChanged: (socialMediaId) {
                        controller.setContactPersonSocialMedia(
                          index!,
                          socialMediaId!,
                        );
                      },
                      hint: Text(
                        'Pilih Media Sosial',
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
