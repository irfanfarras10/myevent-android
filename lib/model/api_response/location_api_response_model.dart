class LocationApiResponseModel {
  List<Features>? features;
  String? type;
  Query? query;

  LocationApiResponseModel({this.features, this.type, this.query});

  LocationApiResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features!.add(new Features.fromJson(v));
      });
    }
    type = json['type'];
    query = json['query'] != null ? new Query.fromJson(json['query']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.features != null) {
      data['features'] = this.features!.map((v) => v.toJson()).toList();
    }
    data['type'] = this.type;
    if (this.query != null) {
      data['query'] = this.query!.toJson();
    }
    return data;
  }
}

class Features {
  String? type;
  Properties? properties;
  Geometry? geometry;
  List<double>? bbox;

  Features({this.type, this.properties, this.geometry, this.bbox});

  Features.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    properties = json['properties'] != null
        ? new Properties.fromJson(json['properties'])
        : null;
    geometry = json['geometry'] != null
        ? new Geometry.fromJson(json['geometry'])
        : null;
    bbox = json['bbox'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.properties != null) {
      data['properties'] = this.properties!.toJson();
    }
    if (this.geometry != null) {
      data['geometry'] = this.geometry!.toJson();
    }
    data['bbox'] = this.bbox;
    return data;
  }
}

class Properties {
  Datasource? datasource;
  String? name;
  String? street;
  String? suburb;
  String? district;
  String? city;
  String? state;
  String? postcode;
  String? country;
  String? countryCode;
  double? lon;
  double? lat;
  String? formatted;
  String? addressLine1;
  String? addressLine2;
  String? category;
  String? resultType;
  Rank? rank;
  String? placeId;
  String? housenumber;

  Properties(
      {this.datasource,
      this.name,
      this.street,
      this.suburb,
      this.district,
      this.city,
      this.state,
      this.postcode,
      this.country,
      this.countryCode,
      this.lon,
      this.lat,
      this.formatted,
      this.addressLine1,
      this.addressLine2,
      this.category,
      this.resultType,
      this.rank,
      this.placeId,
      this.housenumber});

  Properties.fromJson(Map<String, dynamic> json) {
    datasource = json['datasource'] != null
        ? new Datasource.fromJson(json['datasource'])
        : null;
    name = json['name'];
    street = json['street'];
    suburb = json['suburb'];
    district = json['district'];
    city = json['city'];
    state = json['state'];
    postcode = json['postcode'];
    country = json['country'];
    countryCode = json['country_code'];
    lon = json['lon'];
    lat = json['lat'];
    formatted = json['formatted'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    category = json['category'];
    resultType = json['result_type'];
    rank = json['rank'] != null ? new Rank.fromJson(json['rank']) : null;
    placeId = json['place_id'];
    housenumber = json['housenumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.datasource != null) {
      data['datasource'] = this.datasource!.toJson();
    }
    data['name'] = this.name;
    data['street'] = this.street;
    data['suburb'] = this.suburb;
    data['district'] = this.district;
    data['city'] = this.city;
    data['state'] = this.state;
    data['postcode'] = this.postcode;
    data['country'] = this.country;
    data['country_code'] = this.countryCode;
    data['lon'] = this.lon;
    data['lat'] = this.lat;
    data['formatted'] = this.formatted;
    data['address_line1'] = this.addressLine1;
    data['address_line2'] = this.addressLine2;
    data['category'] = this.category;
    data['result_type'] = this.resultType;
    if (this.rank != null) {
      data['rank'] = this.rank!.toJson();
    }
    data['place_id'] = this.placeId;
    data['housenumber'] = this.housenumber;
    return data;
  }
}

class Datasource {
  String? sourcename;
  String? attribution;
  String? license;
  String? url;

  Datasource({this.sourcename, this.attribution, this.license, this.url});

  Datasource.fromJson(Map<String, dynamic> json) {
    sourcename = json['sourcename'];
    attribution = json['attribution'];
    license = json['license'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sourcename'] = this.sourcename;
    data['attribution'] = this.attribution;
    data['license'] = this.license;
    data['url'] = this.url;
    return data;
  }
}

class Rank {
  int? confidence;
  String? matchType;

  Rank({this.confidence, this.matchType});

  Rank.fromJson(Map<String, dynamic> json) {
    confidence = json['confidence'];
    matchType = json['match_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['confidence'] = this.confidence;
    data['match_type'] = this.matchType;
    return data;
  }
}

class Geometry {
  String? type;
  List<double>? coordinates;

  Geometry({this.type, this.coordinates});

  Geometry.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}

class Query {
  String? text;
  Parsed? parsed;

  Query({this.text, this.parsed});

  Query.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    parsed =
        json['parsed'] != null ? new Parsed.fromJson(json['parsed']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    if (this.parsed != null) {
      data['parsed'] = this.parsed!.toJson();
    }
    return data;
  }
}

class Parsed {
  String? city;
  String? expectedType;

  Parsed({this.city, this.expectedType});

  Parsed.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    expectedType = json['expected_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['expected_type'] = this.expectedType;
    return data;
  }
}
