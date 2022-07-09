class ViewGuestListApiResponseModel {
  List<ListGuest>? listGuest;

  ViewGuestListApiResponseModel({this.listGuest});

  ViewGuestListApiResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['listGuest'] != null) {
      listGuest = <ListGuest>[];
      json['listGuest'].forEach((v) {
        listGuest!.add(new ListGuest.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listGuest != null) {
      data['listGuest'] = this.listGuest!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListGuest {
  int? id;
  String? name;
  String? phoneNumber;
  String? email;
  bool? alreadyShared;

  ListGuest(
      {this.id, this.name, this.phoneNumber, this.email, this.alreadyShared});

  ListGuest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    alreadyShared = json['alreadyShared'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['alreadyShared'] = this.alreadyShared;
    return data;
  }
}
