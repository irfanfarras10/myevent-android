class CreateContactPersonApiRequestModel {
  String? name;
  String? contact;
  int? eventSocialMediaId;

  CreateContactPersonApiRequestModel(
      {this.name, this.contact, this.eventSocialMediaId});

  CreateContactPersonApiRequestModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    contact = json['contact'];
    eventSocialMediaId = json['eventSocialMediaId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['contact'] = this.contact;
    data['eventSocialMediaId'] = this.eventSocialMediaId;
    return data;
  }
}
