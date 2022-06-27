class CreatePaymentApiRequestModel {
  String? type;
  String? information;

  CreatePaymentApiRequestModel({this.type, this.information});

  CreatePaymentApiRequestModel.fromJson(Map<String, dynamic> json) {
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
