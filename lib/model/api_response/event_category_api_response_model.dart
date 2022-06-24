class EventCategoryApiResponseModel {
  List<EventCategories>? eventCategories;

  EventCategoryApiResponseModel({this.eventCategories});

  EventCategoryApiResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['eventCategories'] != null) {
      eventCategories = <EventCategories>[];
      json['eventCategories'].forEach((v) {
        eventCategories!.add(new EventCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.eventCategories != null) {
      data['eventCategories'] =
          this.eventCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EventCategories {
  int? id;
  String? name;

  EventCategories({this.id, this.name});

  EventCategories.fromJson(Map<String, dynamic> json) {
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
