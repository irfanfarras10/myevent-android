class ContactPersonSocialMediaApiResponseModel {
  List<EventSocialMedias>? eventSocialMedias;

  ContactPersonSocialMediaApiResponseModel({this.eventSocialMedias});

  ContactPersonSocialMediaApiResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['eventSocialMedias'] != null) {
      eventSocialMedias = <EventSocialMedias>[];
      json['eventSocialMedias'].forEach((v) {
        eventSocialMedias!.add(new EventSocialMedias.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.eventSocialMedias != null) {
      data['eventSocialMedias'] =
          this.eventSocialMedias!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EventSocialMedias {
  int? id;
  String? name;

  EventSocialMedias({this.id, this.name});

  EventSocialMedias.fromJson(Map<String, dynamic> json) {
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
