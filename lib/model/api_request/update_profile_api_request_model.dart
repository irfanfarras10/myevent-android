class UpdateProfileApiRequestModel {
  String? username;
  String? email;
  String? organizerName;
  String? phoneNumber;

  UpdateProfileApiRequestModel(
      {this.username, this.email, this.organizerName, this.phoneNumber});

  UpdateProfileApiRequestModel.fromJson(Map<String, dynamic> json) {
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
