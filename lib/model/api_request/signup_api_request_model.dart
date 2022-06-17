class SignUpApiRequestModel {
  String? username;
  String? organizerName;
  String? email;
  String? password;
  String? phoneNumber;

  SignUpApiRequestModel(
      {this.username,
      this.organizerName,
      this.email,
      this.password,
      this.phoneNumber});

  SignUpApiRequestModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    organizerName = json['organizerName'];
    email = json['email'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['organizerName'] = this.organizerName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}
