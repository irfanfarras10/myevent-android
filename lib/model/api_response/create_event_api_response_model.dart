class CreateEventApiResponseModel {
  String? message;
  int? eventId;

  CreateEventApiResponseModel({this.message, this.eventId});

  CreateEventApiResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    eventId = json['eventId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['eventId'] = this.eventId;
    return data;
  }
}
