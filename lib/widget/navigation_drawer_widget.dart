import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/model/api_response/view_event_detail_api_response_model.dart';
import 'package:myevent_android/route/route_name.dart';
import 'package:myevent_android/util/location_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final ViewEventDetailApiResponseModel? eventData;
  const NavigationDrawerWidget({Key? key, this.eventData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: MyEventColor.primaryColor,
            ),
            child: Center(
              child: Text(
                eventData!.name!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.5,
                  color: MyEventColor.secondaryColor,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.event, color: MyEventColor.secondaryColor),
            title: Text('Event'),
            onTap: () {
              Get.offAllNamed(RouteName.mainScreen);
            },
          ),
          ListTile(
            leading:
                Icon(Icons.calendar_today, color: MyEventColor.secondaryColor),
            title: Text('Agenda'),
            onTap: () {
              Get.offAllNamed(RouteName.agendaScreen);
            },
          ),
          ListTile(
            leading: Icon(Icons.dashboard, color: MyEventColor.secondaryColor),
            title: Text('Detail Event'),
            onTap: () {
              Get.offAllNamed(
                RouteName.eventDetailScreen.replaceAll(
                  ':id',
                  eventData!.id!.toString(),
                ),
              );
            },
          ),
          Visibility(
            visible: eventData!.eventStatus!.id! != 1,
            child: ListTile(
              leading: Icon(
                Icons.people,
                color: MyEventColor.secondaryColor,
              ),
              title: Text('Peserta'),
              onTap: () {
                Get.offAllNamed(
                  RouteName.participantScreen.replaceAll(
                    ':id',
                    eventData!.id!.toString(),
                  ),
                );
              },
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.card_membership_sharp,
              color: MyEventColor.secondaryColor,
            ),
            title: Text('Tiket'),
            onTap: () {
              Get.offAllNamed(
                RouteName.ticketDetailScreen.replaceAll(
                  ':id',
                  eventData!.id!.toString(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.people, color: MyEventColor.secondaryColor),
            title: Text('Tamu'),
            onTap: () {
              Get.offAllNamed(
                RouteName.guestScreen.replaceAll(
                  ':id',
                  eventData!.id!.toString(),
                ),
                arguments: {
                  'canEdit': false,
                },
              );
            },
          ),
          Visibility(
            visible: eventData!.eventStatus!.id! != 1 &&
                eventData!.eventStatus!.id != 3 &&
                eventData!.eventStatus!.id != 4 &&
                eventData!.eventStatus!.id != 5,
            child: ListTile(
              leading: Icon(Icons.share, color: MyEventColor.secondaryColor),
              title: Text('Promosi Event'),
              onTap: () {
                promoteEvent(eventData!);
              },
            ),
          ),
          Visibility(
            visible: eventData!.eventStatus!.id! != 1 &&
                eventData!.eventStatus!.id != 2 &&
                eventData!.eventStatus!.id != 5,
            child: ListTile(
              leading: Icon(
                Icons.file_copy_sharp,
                color: MyEventColor.secondaryColor,
              ),
              title: Text('Bagikan File'),
              onTap: () {
                Get.offAllNamed(
                  RouteName.shareFileScreen.replaceAll(
                    ':id',
                    eventData!.id!.toString(),
                  ),
                );
              },
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person, color: MyEventColor.secondaryColor),
            title: Text('Profil'),
            onTap: () {
              Get.offAllNamed(RouteName.profileScreen);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: MyEventColor.secondaryColor),
            title: Text('Keluar'),
            onTap: () {
              Get.defaultDialog(
                title: 'Keluar Akun',
                content: Text('Apakah Anda Ingin keluar akun?'),
                textConfirm: 'Ya',
                textCancel: 'Tidak',
                confirmTextColor: MyEventColor.secondaryColor,
                barrierDismissible: false,
                onConfirm: () async {
                  final prefs = await SharedPreferences.getInstance();
                  FirebaseMessaging.instance.unsubscribeFromTopic(
                    prefs.getString('myevent.auth.token.subject')!,
                  );
                  prefs.remove('myevent.auth.token');
                  prefs.remove('myevent.auth.token.subject');
                  Get.offAllNamed(RouteName.signInScreen);
                },
              );
            },
          ),
        ],
      ),
    );
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

  Future<void> promoteEvent(ViewEventDetailApiResponseModel data) async {
    String location = await locationUtil.parseLocation(
      data.eventVenueCategory,
      data.venue!,
    );
    String baseTemplate = '';
    baseTemplate +=
        'Halo semua, ayo ikuti event ${data.name} untuk mengisi waktu luang Anda!';
    baseTemplate += '\n';
    baseTemplate += '\n';
    baseTemplate += 'Deskripsi Event: ${data.description!}';
    baseTemplate += '\n';
    baseTemplate += '\n';
    baseTemplate +=
        'Tanggal Event: ${_parseEventDate(data.dateEventStart!, data.dateEventEnd!)}';
    baseTemplate += '\n';
    baseTemplate +=
        'Waktu Event: ${_parseEventTime(data.timeEventStart!, data.timeEventEnd!)}';
    baseTemplate += '\n';
    baseTemplate += 'Lokasi Event: $location';
    baseTemplate += '\n';
    baseTemplate += '\n';
    baseTemplate += 'Yuk daftarkan diri Anda melalui link di bawah ini';
    await FlutterShare.share(
      title: 'Promosi Event',
      text: baseTemplate,
      linkUrl: 'https://myevent-web.herokuapp.com/event/${data.id}',
      chooserTitle: 'Promosi Event',
    );
  }
}
