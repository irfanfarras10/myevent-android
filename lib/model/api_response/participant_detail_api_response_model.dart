class ParticipantDetailApiResponseModel {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? ticket;
  String? paymentProofPhoto;

  ParticipantDetailApiResponseModel(
      {this.id,
      this.name,
      this.email,
      this.phoneNumber,
      this.ticket,
      this.paymentProofPhoto});

  ParticipantDetailApiResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    ticket = json['ticket'];
    paymentProofPhoto = json['paymentProofPhoto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['ticket'] = this.ticket;
    data['paymentProofPhoto'] = this.paymentProofPhoto;
    return data;
  }
}
