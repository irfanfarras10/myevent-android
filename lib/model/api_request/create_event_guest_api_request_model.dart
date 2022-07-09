class CreateEventGuestApiRequestModel {
  String? name;
  String? phoneNumber;
  String? email;

  CreateEventGuestApiRequestModel({this.name, this.phoneNumber, this.email});

  CreateEventGuestApiRequestModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    return data;
  }
}
