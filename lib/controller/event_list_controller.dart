import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myevent_android/controller/api_controller.dart';
import 'package:myevent_android/model/api_response/view_event_list_api_response_model.dart';
import 'package:myevent_android/provider/api_event.dart';
import 'package:myevent_android/util/location_util.dart';

class EventListController extends ApiController {
  final isLoading = true.obs;
  RxBool isSearchMode = false.obs;

  List<EventDataList> eventList = [];
  RxList<EventDataList> searchEventList = RxList();

  int eventStatus = 1;

  @override
  void resetState() {
    apiResponseState.value = null;
    eventList.clear();
    isLoading.value = true;
  }

  void setSearchMode(bool mode) {
    isSearchMode.value = mode;
  }

  void resetData() {
    searchEventList.value = eventList;
  }

  Future<void> loadData() async {
    resetState();
    if (eventStatus == 1) {
      await apiEvent.getEventDraft().then(
        (response) {
          checkApiResponse(response);
          if (apiResponseState.value != ApiResponseState.http401) {
            isLoading.value = false;
          }
          if (apiResponseState.value == ApiResponseState.http2xx) {
            final eventData = ViewEventListApiResponseModel.fromJson(response);
            eventList = eventData.eventDataList!;
            searchEventList.value = eventList;
          }
        },
      );
    } else if (eventStatus == 2) {
      await apiEvent.getEventPublish().then(
        (response) {
          checkApiResponse(response);
          if (apiResponseState.value != ApiResponseState.http401) {
            isLoading.value = false;
          }
          if (apiResponseState.value == ApiResponseState.http2xx) {
            final eventData = ViewEventListApiResponseModel.fromJson(response);
            eventList = eventData.eventDataList!;
            searchEventList.value = eventList;
          }
        },
      );
    } else if (eventStatus == 3) {
      await apiEvent.getEventLive().then(
        (response) {
          checkApiResponse(response);
          if (apiResponseState.value != ApiResponseState.http401) {
            isLoading.value = false;
          }
          if (apiResponseState.value == ApiResponseState.http2xx) {
            final eventData = ViewEventListApiResponseModel.fromJson(response);
            eventList = eventData.eventDataList!;
            searchEventList.value = eventList;
          }
        },
      );
    } else if (eventStatus == 4) {
      await apiEvent.getEventPass().then(
        (response) {
          checkApiResponse(response);
          if (apiResponseState.value != ApiResponseState.http401) {
            isLoading.value = false;
          }
          if (apiResponseState.value == ApiResponseState.http2xx) {
            final eventData = ViewEventListApiResponseModel.fromJson(response);
            eventList = eventData.eventDataList!;
            searchEventList.value = eventList;
          }
        },
      );
    } else if (eventStatus == 5) {
      await apiEvent.getEventCancel().then(
        (response) {
          checkApiResponse(response);
          if (apiResponseState.value != ApiResponseState.http401) {
            isLoading.value = false;
          }
          if (apiResponseState.value == ApiResponseState.http2xx) {
            final eventData = ViewEventListApiResponseModel.fromJson(response);
            eventList = eventData.eventDataList!;
            searchEventList.value = eventList;
          }
        },
      );
    }
  }

  void searchEvent(String keyword) {
    if (keyword.isEmpty) {
      searchEventList.value = eventList;
    } else {
      final searchEventData = eventList
          .where(
            (eventData) => eventData.name!.toLowerCase().contains(keyword),
          )
          .toList();
      searchEventList.value = searchEventData;
    }
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

  Future<void> promoteEvent(EventDataList data) async {
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
