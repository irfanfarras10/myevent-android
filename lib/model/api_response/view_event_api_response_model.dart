class ViewEventApiResponseModel {
  List<EventDataList>? eventDataList;

  ViewEventApiResponseModel({this.eventDataList});

  ViewEventApiResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['eventDataList'] != null) {
      eventDataList = <EventDataList>[];
      json['eventDataList'].forEach((v) {
        eventDataList!.add(new EventDataList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.eventDataList != null) {
      data['eventDataList'] =
          this.eventDataList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EventDataList {
  String? name;
  String? description;
  int? dateTimeEventStart;
  int? dateTimeEventEnd;
  String? venue;
  String? bannerPhoto;
  EventStatus? eventStatus;
  EventStatus? eventCategory;
  EventStatus? eventVenueCategory;
  EventStatus? eventPaymentCategory;
  EventOrganizer? eventOrganizer;

  EventDataList(
      {this.name,
      this.description,
      this.dateTimeEventStart,
      this.dateTimeEventEnd,
      this.venue,
      this.bannerPhoto,
      this.eventStatus,
      this.eventCategory,
      this.eventVenueCategory,
      this.eventPaymentCategory,
      this.eventOrganizer});

  EventDataList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    dateTimeEventStart = json['dateTimeEventStart'];
    dateTimeEventEnd = json['dateTimeEventEnd'];
    venue = json['venue'];
    bannerPhoto = json['bannerPhoto'];
    eventStatus = json['eventStatus'] != null
        ? new EventStatus.fromJson(json['eventStatus'])
        : null;
    eventCategory = json['eventCategory'] != null
        ? new EventStatus.fromJson(json['eventCategory'])
        : null;
    eventVenueCategory = json['eventVenueCategory'] != null
        ? new EventStatus.fromJson(json['eventVenueCategory'])
        : null;
    eventPaymentCategory = json['eventPaymentCategory'] != null
        ? new EventStatus.fromJson(json['eventPaymentCategory'])
        : null;
    eventOrganizer = json['eventOrganizer'] != null
        ? new EventOrganizer.fromJson(json['eventOrganizer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['dateTimeEventStart'] = this.dateTimeEventStart;
    data['dateTimeEventEnd'] = this.dateTimeEventEnd;
    data['venue'] = this.venue;
    data['bannerPhoto'] = this.bannerPhoto;
    if (this.eventStatus != null) {
      data['eventStatus'] = this.eventStatus!.toJson();
    }
    if (this.eventCategory != null) {
      data['eventCategory'] = this.eventCategory!.toJson();
    }
    if (this.eventVenueCategory != null) {
      data['eventVenueCategory'] = this.eventVenueCategory!.toJson();
    }
    if (this.eventPaymentCategory != null) {
      data['eventPaymentCategory'] = this.eventPaymentCategory!.toJson();
    }
    if (this.eventOrganizer != null) {
      data['eventOrganizer'] = this.eventOrganizer!.toJson();
    }
    return data;
  }
}

class EventStatus {
  int? id;
  String? name;

  EventStatus({this.id, this.name});

  EventStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class EventOrganizer {
  String? username;
  String? email;
  String? organizerName;
  String? phoneNumber;

  EventOrganizer(
      {this.username, this.email, this.organizerName, this.phoneNumber});

  EventOrganizer.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    organizerName = json['organizerName'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['organizerName'] = this.organizerName;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}
