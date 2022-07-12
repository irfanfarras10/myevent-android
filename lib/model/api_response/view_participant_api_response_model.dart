class ViewParticipantApiResponseModel {
  List<ListParticipant>? listParticipant;

  ViewParticipantApiResponseModel({this.listParticipant});

  ViewParticipantApiResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['listParticipant'] != null) {
      listParticipant = <ListParticipant>[];
      json['listParticipant'].forEach((v) {
        listParticipant!.add(new ListParticipant.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listParticipant != null) {
      data['listParticipant'] =
          this.listParticipant!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListParticipant {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? status;
  List<TicketParticipants>? ticketParticipants;

  ListParticipant(
      {this.id,
      this.name,
      this.email,
      this.phoneNumber,
      this.status,
      this.ticketParticipants});

  ListParticipant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    status = json['status'];
    if (json['ticketParticipants'] != null) {
      ticketParticipants = <TicketParticipants>[];
      json['ticketParticipants'].forEach((v) {
        ticketParticipants!.add(new TicketParticipants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['status'] = this.status;
    if (this.ticketParticipants != null) {
      data['ticketParticipants'] =
          this.ticketParticipants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TicketParticipants {
  int? id;
  int? eventDate;
  int? purchaseDate;
  String? status;

  TicketParticipants({this.id, this.eventDate, this.purchaseDate, this.status});

  TicketParticipants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventDate = json['event_date'];
    purchaseDate = json['purchase_date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['event_date'] = this.eventDate;
    data['purchase_date'] = this.purchaseDate;
    data['status'] = this.status;
    return data;
  }
}
