class CreateTicketApiRequestModel {
  String? name;
  int? price;
  int? dateTimeRegistrationStart;
  int? dateTimeRegistrationEnd;
  int? quotaTotal;

  CreateTicketApiRequestModel(
      {this.name,
      this.price,
      this.dateTimeRegistrationStart,
      this.dateTimeRegistrationEnd,
      this.quotaTotal});

  CreateTicketApiRequestModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    dateTimeRegistrationStart = json['dateTimeRegistrationStart'];
    dateTimeRegistrationEnd = json['dateTimeRegistrationEnd'];
    quotaTotal = json['quotaTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['dateTimeRegistrationStart'] = this.dateTimeRegistrationStart;
    data['dateTimeRegistrationEnd'] = this.dateTimeRegistrationEnd;
    data['quotaTotal'] = this.quotaTotal;
    return data;
  }
}
