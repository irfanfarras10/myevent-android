import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/model/api_response/view_event_detail_api_response_model.dart';
import 'package:myevent_android/route/route_name.dart';

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
          ListTile(
            leading: Icon(Icons.dashboard, color: MyEventColor.secondaryColor),
            title: Text('Dashboard'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.people,
              color: MyEventColor.secondaryColor,
            ),
            title: Text('Peserta'),
            onTap: () {
              Navigator.pop(context);
            },
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
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.share, color: MyEventColor.secondaryColor),
            title: Text('Promosi Event'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
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
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
