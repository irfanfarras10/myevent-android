import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/api_controller.dart';
import 'package:myevent_android/controller/participant_controller.dart';
import 'package:myevent_android/widget/http_error_widget.dart';
import 'package:myevent_android/widget/loading_widget.dart';
import 'package:myevent_android/widget/navigation_drawer_widget.dart';

class ParticipantScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ParticipantController>();
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

          body = GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: RefreshIndicator(
              onRefresh: controller.loadParticipantData,
              child: ListView(
                padding: EdgeInsets.all(15.0),
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ActionChip(
                        label: Text('Terdaftar'),
                        onPressed: () {
                          controller.menuIndex.value = 0;
                          controller.loadParticipantData();
                        },
                        backgroundColor: controller.menuIndex.value == 0
                            ? Colors.amber
                            : Colors.grey.shade400,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      ActionChip(
                        label: Text(
                            controller.eventData!.eventStatus!.id == 2 ||
                                    controller.eventData!.eventStatus!.id == 3
                                ? 'Konfirmasi Pembayaran'
                                : 'Pembayaran Tidak Disetujui'),
                        onPressed: () {
                          controller.menuIndex.value = 1;
                          controller.loadParticipantData();
                        },
                        backgroundColor: controller.menuIndex.value == 1
                            ? Colors.amber
                            : Colors.grey.shade400,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Visibility(
                    visible: !controller.isLoadingParticipantData.value,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Cari berdasarkan nama peserta',
                        hintStyle: TextStyle(
                          color: MyEventColor.secondaryColor,
                        ),
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(
                          Icons.search,
                        ),
                      ),
                      onChanged: (keyword) {
                        controller.searchEvent(keyword);
                      },
                    ),
                  ),
                  SizedBox(height: 15.0),
                  !controller.isLoadingParticipantData.value
                      ? controller.dataList.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${controller.dataList.length} Peserta',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.5,
                                  ),
                                ),
                                SizedBox(height: 15.0),
                                ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      onTap: () {
                                        if (controller.menuIndex.value == 1) {
                                          controller
                                              .getWaitingConfirmationParticipantDetail(
                                            index,
                                          );
                                        }

                                        (controller.menuIndex.value == 0)
                                            ? Get.dialog(
                                                AlertDialog(
                                                  title: Text(
                                                    'Data Peserta',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: MyEventColor
                                                          .secondaryColor,
                                                      fontSize: 16.5,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  content: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        TextFormField(
                                                          initialValue:
                                                              controller
                                                                  .dataList[
                                                                      index]
                                                                  .name,
                                                          readOnly: true,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText: 'Nama',
                                                            fillColor:
                                                                MyEventColor
                                                                    .primaryColor,
                                                            labelStyle:
                                                                TextStyle(
                                                              color: MyEventColor
                                                                  .secondaryColor,
                                                            ),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                color: MyEventColor
                                                                    .secondaryColor,
                                                              ),
                                                            ),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                color: MyEventColor
                                                                    .secondaryColor,
                                                              ),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                color: MyEventColor
                                                                    .primaryColor,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15.0,
                                                        ),
                                                        TextFormField(
                                                          initialValue:
                                                              controller
                                                                  .dataList[
                                                                      index]
                                                                  .email,
                                                          readOnly: true,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText: 'E-Mail',
                                                            fillColor:
                                                                MyEventColor
                                                                    .primaryColor,
                                                            labelStyle:
                                                                TextStyle(
                                                              color: MyEventColor
                                                                  .secondaryColor,
                                                            ),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                color: MyEventColor
                                                                    .secondaryColor,
                                                              ),
                                                            ),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                color: MyEventColor
                                                                    .secondaryColor,
                                                              ),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                color: MyEventColor
                                                                    .primaryColor,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15.0,
                                                        ),
                                                        TextFormField(
                                                          initialValue:
                                                              controller
                                                                  .dataList[
                                                                      index]
                                                                  .phoneNumber,
                                                          readOnly: true,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                'Nomor HP',
                                                            fillColor:
                                                                MyEventColor
                                                                    .primaryColor,
                                                            labelStyle:
                                                                TextStyle(
                                                              color: MyEventColor
                                                                  .secondaryColor,
                                                            ),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                color: MyEventColor
                                                                    .secondaryColor,
                                                              ),
                                                            ),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                color: MyEventColor
                                                                    .secondaryColor,
                                                              ),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                color: MyEventColor
                                                                    .primaryColor,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Get.dialog(
                                                Obx(
                                                  () => AlertDialog(
                                                    title: controller
                                                                .isLoadingGetParticipantDetailData
                                                                .value ||
                                                            controller
                                                                    .apiResponseState
                                                                    .value !=
                                                                ApiResponseState
                                                                    .http2xx
                                                        ? null
                                                        : Text(
                                                            'Data Peserta',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: MyEventColor
                                                                  .secondaryColor,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                    content: controller
                                                            .isLoadingGetParticipantDetailData
                                                            .value
                                                        ? Center(
                                                            heightFactor: 5.0,
                                                            child:
                                                                CircularProgressIndicator(),
                                                          )
                                                        : controller.apiResponseState
                                                                    .value !=
                                                                ApiResponseState
                                                                    .http2xx
                                                            ? Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Icon(
                                                                    Icons.close,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                  Text(
                                                                      'Terjadi Kesalahan'),
                                                                ],
                                                              )
                                                            : SingleChildScrollView(
                                                                physics:
                                                                    BouncingScrollPhysics(),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    TextFormField(
                                                                      initialValue: controller
                                                                          .participantDetailData!
                                                                          .name!,
                                                                      readOnly:
                                                                          true,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        labelText:
                                                                            'Nama',
                                                                        fillColor:
                                                                            MyEventColor.primaryColor,
                                                                        labelStyle:
                                                                            TextStyle(
                                                                          color:
                                                                              MyEventColor.secondaryColor,
                                                                        ),
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              const BorderSide(
                                                                            color:
                                                                                MyEventColor.secondaryColor,
                                                                          ),
                                                                        ),
                                                                        enabledBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              const BorderSide(
                                                                            color:
                                                                                MyEventColor.secondaryColor,
                                                                          ),
                                                                        ),
                                                                        focusedBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              const BorderSide(
                                                                            color:
                                                                                MyEventColor.primaryColor,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          15.0,
                                                                    ),
                                                                    TextFormField(
                                                                      initialValue: controller
                                                                          .participantDetailData!
                                                                          .email!,
                                                                      readOnly:
                                                                          true,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        labelText:
                                                                            'E-Mail',
                                                                        fillColor:
                                                                            MyEventColor.primaryColor,
                                                                        labelStyle:
                                                                            TextStyle(
                                                                          color:
                                                                              MyEventColor.secondaryColor,
                                                                        ),
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              const BorderSide(
                                                                            color:
                                                                                MyEventColor.secondaryColor,
                                                                          ),
                                                                        ),
                                                                        enabledBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              const BorderSide(
                                                                            color:
                                                                                MyEventColor.secondaryColor,
                                                                          ),
                                                                        ),
                                                                        focusedBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              const BorderSide(
                                                                            color:
                                                                                MyEventColor.primaryColor,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          15.0,
                                                                    ),
                                                                    TextFormField(
                                                                      initialValue: controller
                                                                          .participantDetailData!
                                                                          .phoneNumber!,
                                                                      readOnly:
                                                                          true,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        labelText:
                                                                            'Nomor HP',
                                                                        fillColor:
                                                                            MyEventColor.primaryColor,
                                                                        labelStyle:
                                                                            TextStyle(
                                                                          color:
                                                                              MyEventColor.secondaryColor,
                                                                        ),
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              const BorderSide(
                                                                            color:
                                                                                MyEventColor.secondaryColor,
                                                                          ),
                                                                        ),
                                                                        enabledBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              const BorderSide(
                                                                            color:
                                                                                MyEventColor.secondaryColor,
                                                                          ),
                                                                        ),
                                                                        focusedBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              const BorderSide(
                                                                            color:
                                                                                MyEventColor.primaryColor,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          15.0,
                                                                    ),
                                                                    TextFormField(
                                                                      initialValue: controller
                                                                          .participantDetailData!
                                                                          .ticket!,
                                                                      readOnly:
                                                                          true,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        labelText:
                                                                            'Membeli Tiket',
                                                                        fillColor:
                                                                            MyEventColor.primaryColor,
                                                                        labelStyle:
                                                                            TextStyle(
                                                                          color:
                                                                              MyEventColor.secondaryColor,
                                                                        ),
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              const BorderSide(
                                                                            color:
                                                                                MyEventColor.secondaryColor,
                                                                          ),
                                                                        ),
                                                                        enabledBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              const BorderSide(
                                                                            color:
                                                                                MyEventColor.secondaryColor,
                                                                          ),
                                                                        ),
                                                                        focusedBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              const BorderSide(
                                                                            color:
                                                                                MyEventColor.primaryColor,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          15.0,
                                                                    ),
                                                                    Text(
                                                                      'Foto Bukti Pembayaran',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          15.0,
                                                                    ),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        Get.dialog(
                                                                          CachedNetworkImage(
                                                                            imageUrl:
                                                                                controller.participantDetailData!.paymentProofPhoto!,
                                                                            imageBuilder: (context, imageProvider) =>
                                                                                Container(
                                                                              decoration: BoxDecoration(
                                                                                image: DecorationImage(
                                                                                  image: imageProvider,
                                                                                  fit: BoxFit.contain,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            placeholder: (context, url) =>
                                                                                Center(
                                                                              child: CircularProgressIndicator(),
                                                                            ),
                                                                            errorWidget: (context, url, error) =>
                                                                                Container(
                                                                              color: Colors.grey.shade100,
                                                                              child: Center(
                                                                                child: Icon(
                                                                                  Icons.image,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                      child:
                                                                          SizedBox(
                                                                        height:
                                                                            200,
                                                                        child:
                                                                            CachedNetworkImage(
                                                                          imageUrl: controller
                                                                              .participantDetailData!
                                                                              .paymentProofPhoto!,
                                                                          imageBuilder: (context, imageProvider) =>
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              image: DecorationImage(
                                                                                image: imageProvider,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          placeholder: (context, url) =>
                                                                              Center(
                                                                            child:
                                                                                CircularProgressIndicator(),
                                                                          ),
                                                                          errorWidget: (context, url, error) =>
                                                                              Container(
                                                                            color:
                                                                                Colors.grey.shade100,
                                                                            child:
                                                                                Center(
                                                                              child: Icon(
                                                                                Icons.image,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          15.0,
                                                                    ),
                                                                    Visibility(
                                                                      visible: controller.eventData!.eventStatus!.id! ==
                                                                              2 ||
                                                                          controller.eventData!.eventStatus!.id ==
                                                                              3,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          SizedBox(
                                                                            width:
                                                                                MediaQuery.of(context).size.width,
                                                                            height:
                                                                                60.0,
                                                                            child:
                                                                                ElevatedButton(
                                                                              onPressed: () {
                                                                                controller.confirmPayment(index);
                                                                              },
                                                                              child: Text(
                                                                                'Setuju',
                                                                                style: TextStyle(
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontSize: 15.0,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                60.0,
                                                                            width:
                                                                                double.infinity,
                                                                            child:
                                                                                TextButton(
                                                                              onPressed: () {
                                                                                Get.back();
                                                                                Get.dialog(
                                                                                  Obx(
                                                                                    () => AlertDialog(
                                                                                      title: Text(
                                                                                        'Alasan Penolakan',
                                                                                        style: TextStyle(fontWeight: FontWeight.bold),
                                                                                      ),
                                                                                      content: SingleChildScrollView(
                                                                                        child: Column(
                                                                                          mainAxisSize: MainAxisSize.min,
                                                                                          children: [
                                                                                            TextFormField(
                                                                                              controller: controller.rejectionReasonController,
                                                                                              textInputAction: TextInputAction.done,
                                                                                              keyboardType: TextInputType.name,
                                                                                              onChanged: (String message) {
                                                                                                controller.validateRejectionMessage(message);
                                                                                              },
                                                                                              decoration: InputDecoration(
                                                                                                labelText: 'Alasan Penolakan',
                                                                                                errorText: controller.rejectionReasonErrorMessage.value,
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
                                                                                              maxLines: 20,
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height: 20.0,
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height: 60.0,
                                                                                              width: MediaQuery.of(context).size.width,
                                                                                              child: ElevatedButton(
                                                                                                onPressed: controller.isRejectionReasonValid.value
                                                                                                    ? () {
                                                                                                        controller.rejectPayment(index);
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
                                                                                                  'Konfirmasi Penolakan',
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
                                                                                    ),
                                                                                  ),
                                                                                ).then((_) {
                                                                                  controller.isRejectionReasonValid.value = false;
                                                                                  controller.rejectionReasonController.text = '';
                                                                                  controller.rejectionReasonErrorMessage.value = null;
                                                                                });
                                                                              },
                                                                              child: Text(
                                                                                'Tidak Setuju',
                                                                                style: TextStyle(
                                                                                  color: MyEventColor.secondaryColor,
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
                                                ),
                                              );
                                      },
                                      title: Text(
                                          controller.dataList[index].name!),
                                      subtitle: Text(
                                        controller.dataList[index].email!,
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                      leading: Icon(Icons.person),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return Divider();
                                  },
                                  itemCount: controller.dataList.length,
                                ),
                              ],
                            )
                          : Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.0),
                                ),
                                color: Colors.grey.shade200,
                              ),
                              child: Text(
                                'Tidak Ada Data Peserta',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            )
                      : Center(
                          child: LoadingWidget(),
                        )
                ],
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Peserta',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: MyEventColor.secondaryColor,
              ),
            ),
          ),
          body: body,
          drawer: controller.isLoading.value
              ? null
              : NavigationDrawerWidget(eventData: controller.eventData),
          bottomNavigationBar: controller.isLoading.value ||
                  controller.isLoadingParticipantData.value
              ? null
              : Container(
                  padding: const EdgeInsets.all(15.0),
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
                  child: SizedBox(
                    height: 60.0,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.downloadParticipantReport();
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (states) {
                            if (states.contains(MaterialState.disabled)) {
                              return Colors.amber.shade300;
                            }
                            return Colors.amber;
                          },
                        ),
                      ),
                      child: Text(
                        'Unduh File Laporan Peserta',
                        style: TextStyle(
                          fontSize: 17.0,
                          color: MyEventColor.secondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
