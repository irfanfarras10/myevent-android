import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/event_list_controller.dart';
import 'package:myevent_android/model/api_response/view_event_list_api_response_model.dart';
import 'package:myevent_android/route/route_name.dart';
import 'package:myevent_android/util/location_util.dart';

class DraftEventScreenCardWidget extends StatelessWidget {
  final controller = Get.put(EventListController(), tag: 'draft');
  final EventDataList? data;
  DraftEventScreenCardWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 7.5),
      child: Card(
        child: InkWell(
          onTap: () {
            Get.toNamed(RouteName.eventDetailScreen.replaceAll(
              ':id',
              data!.id.toString(),
            ))!
                .then((refresh) {
              if (refresh) {
                controller.loadData();
              }
            });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  SizedBox(
                    height: 200,
                    child: CachedNetworkImage(
                      imageUrl: data!.bannerPhoto!,
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
                      errorWidget: (context, url, error) => Center(
                        child: Icon(
                          Icons.image,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SizedBox(
                      height: 170.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
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
                              data!.eventVenueCategory!.name!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: MyEventColor.secondaryColor,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: MyEventColor.secondaryColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(4.0),
                              ),
                            ),
                            child: Text(
                              data!.eventCategory!.name!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data!.name!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: MyEventColor.secondaryColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            data!.eventOrganizer!.organizerName!,
                            style: TextStyle(
                              color: MyEventColor.secondaryColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  DateFormat('EEEE, d MMMM yyyy', 'id_ID')
                                      .format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                      data!.dateEventStart!,
                                    ),
                                  ),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0,
                                    color: MyEventColor.secondaryColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '•',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: MyEventColor.secondaryColor,
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                DateFormat('HH:mm', 'id_ID').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                    data!.timeEventStart!,
                                  ),
                                ),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0,
                                  color: MyEventColor.secondaryColor,
                                ),
                              ),
                            ],
                          ),
                          FutureBuilder<String>(
                            future: locationUtil.parseLocation(
                              data!.eventVenueCategory!,
                              data!.venue!,
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  snapshot.data.toString(),
                                  style: TextStyle(
                                    color: MyEventColor.secondaryColor,
                                    fontSize: 12.0,
                                  ),
                                );
                              } else {
                                return Text(
                                  '',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1.0,
                color: Colors.black26,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
