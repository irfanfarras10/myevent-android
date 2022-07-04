class ViewEventDetailApiResponseModel {
  int? id;
  String? name;
  String? description;
  int? dateEventStart;
  int? dateEventEnd;
  int? timeEventStart;
  int? timeEventEnd;
  String? venue;
  String? bannerPhoto;
  int? dateTimeRegistrationStart;
  int? dateTimeRegistrationEnd;
  EventStatus? eventStatus;
  EventStatus? eventCategory;
  EventStatus? eventVenueCategory;
  EventStatus? eventPaymentCategory;
  EventOrganizer? eventOrganizer;
  List<EventContactPerson>? eventContactPerson;
  List<Ticket>? ticket;
  List<EventGuest>? eventGuest;
  List<EventPayment>? eventPayment;

  ViewEventDetailApiResponseModel(
      {this.id,
      this.name,
      this.description,
      this.dateEventStart,
      this.dateEventEnd,
      this.timeEventStart,
      this.timeEventEnd,
      this.venue,
      this.bannerPhoto,
      this.dateTimeRegistrationStart,
      this.dateTimeRegistrationEnd,
      this.eventStatus,
      this.eventCategory,
      this.eventVenueCategory,
      this.eventPaymentCategory,
      this.eventOrganizer,
      this.eventContactPerson,
      this.ticket,
      this.eventGuest,
      this.eventPayment});

  ViewEventDetailApiResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    dateEventStart = json['dateEventStart'];
    dateEventEnd = json['dateEventEnd'];
    timeEventStart = json['timeEventStart'];
    timeEventEnd = json['timeEventEnd'];
    venue = json['venue'];
    bannerPhoto = json['bannerPhoto'];
    dateTimeRegistrationStart = json['dateTimeRegistrationStart'];
    dateTimeRegistrationEnd = json['dateTimeRegistrationEnd'];
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
    if (json['eventContactPerson'] != null) {
      eventContactPerson = <EventContactPerson>[];
      json['eventContactPerson'].forEach((v) {
        eventContactPerson!.add(new EventContactPerson.fromJson(v));
      });
    }
    if (json['ticket'] != null) {
      ticket = <Ticket>[];
      json['ticket'].forEach((v) {
        ticket!.add(new Ticket.fromJson(v));
      });
    }
    if (json['eventGuest'] != null) {
      eventGuest = <EventGuest>[];
      json['eventGuest'].forEach((v) {
        eventGuest!.add(new EventGuest.fromJson(v));
      });
    }
    if (json['eventPayment'] != null) {
      eventPayment = <EventPayment>[];
      json['eventPayment'].forEach((v) {
        eventPayment!.add(new EventPayment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['dateEventStart'] = this.dateEventStart;
    data['dateEventEnd'] = this.dateEventEnd;
    data['timeEventStart'] = this.timeEventStart;
    data['timeEventEnd'] = this.timeEventEnd;
    data['venue'] = this.venue;
    data['bannerPhoto'] = this.bannerPhoto;
    data['dateTimeRegistrationStart'] = this.dateTimeRegistrationStart;
    data['dateTimeRegistrationEnd'] = this.dateTimeRegistrationEnd;
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
    if (this.eventContactPerson != null) {
      data['eventContactPerson'] =
          this.eventContactPerson!.map((v) => v.toJson()).toList();
    }
    if (this.ticket != null) {
      data['ticket'] = this.ticket!.map((v) => v.toJson()).toList();
    }
    if (this.eventGuest != null) {
      data['eventGuest'] = this.eventGuest!.map((v) => v.toJson()).toList();
    }
    if (this.eventPayment != null) {
      data['eventPayment'] = this.eventPayment!.map((v) => v.toJson()).toList();
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

class EventContactPerson {
  int? id;
  String? name;
  String? contact;
  EventStatus? eventSocialMedia;

  EventContactPerson({this.id, this.name, this.contact, this.eventSocialMedia});

  EventContactPerson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    contact = json['contact'];
    eventSocialMedia = json['eventSocialMedia'] != null
        ? new EventStatus.fromJson(json['eventSocialMedia'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['contact'] = this.contact;
    if (this.eventSocialMedia != null) {
      data['eventSocialMedia'] = this.eventSocialMedia!.toJson();
    }
    return data;
  }
}

class Ticket {
  int? id;
  String? name;
  int? price;
  int? quotaPerDay;
  int? quotaTotal;

  Ticket({this.id, this.name, this.price, this.quotaPerDay, this.quotaTotal});

  Ticket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    quotaPerDay = json['quotaPerDay'];
    quotaTotal = json['quotaTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['quotaPerDay'] = this.quotaPerDay;
    data['quotaTotal'] = this.quotaTotal;
    return data;
  }
}

class EventGuest {
  String? name;
  String? phoneNumber;
  String? email;
  bool? alreadyShared;

  EventGuest({this.name, this.phoneNumber, this.email, this.alreadyShared});

  EventGuest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    alreadyShared = json['alreadyShared'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['alreadyShared'] = this.alreadyShared;
    return data;
  }
}

class EventPayment {
  String? type;
  String? information;

  EventPayment({this.type, this.information});

  EventPayment.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    information = json['information'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['information'] = this.information;
    return data;
  }
}
