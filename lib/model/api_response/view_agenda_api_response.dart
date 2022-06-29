class ViewAgendaApiResponse {
  List<AgendaEventDataList>? agendaEventDataList;

  ViewAgendaApiResponse({this.agendaEventDataList});

  ViewAgendaApiResponse.fromJson(Map<String, dynamic> json) {
    if (json['agendaEventDataList'] != null) {
      agendaEventDataList = <AgendaEventDataList>[];
      json['agendaEventDataList'].forEach((v) {
        agendaEventDataList!.add(new AgendaEventDataList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.agendaEventDataList != null) {
      data['agendaEventDataList'] =
          this.agendaEventDataList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AgendaEventDataList {
  String? name;
  int? dateTimeEventStart;
  int? dateTimeEventEnd;
  EventStatus? eventStatus;

  AgendaEventDataList(
      {this.name,
      this.dateTimeEventStart,
      this.dateTimeEventEnd,
      this.eventStatus});

  AgendaEventDataList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dateTimeEventStart = json['dateTimeEventStart'];
    dateTimeEventEnd = json['dateTimeEventEnd'];
    eventStatus = json['eventStatus'] != null
        ? new EventStatus.fromJson(json['eventStatus'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['dateTimeEventStart'] = this.dateTimeEventStart;
    data['dateTimeEventEnd'] = this.dateTimeEventEnd;
    if (this.eventStatus != null) {
      data['eventStatus'] = this.eventStatus!.toJson();
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
