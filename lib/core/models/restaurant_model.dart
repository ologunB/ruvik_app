class RestaurantModel {
  String? id;
  String? alias;
  String? name;
  String? imageUrl;
  bool? isClosed;
  String? url;
  int? reviewCount;
  List<Categories>? categories;
  double? rating;
  Coordinates? coordinates;
  List<String>? transactions;
  Location? location;
  String? phone;
  String? displayPhone;
  double? distance;
  Attributes? attributes;
  List<Hours>? hours;

  RestaurantModel({
    this.id,
    this.alias,
    this.name,
    this.imageUrl,
    this.isClosed,
    this.url,
    this.reviewCount,
    this.categories,
    this.rating,
    this.coordinates,
    this.transactions,
    this.location,
    this.phone,
    this.displayPhone,
    this.distance,
    this.attributes,
    this.hours,
  });

  RestaurantModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    alias = json['alias'];
    name = json['name'];
    imageUrl = json['image_url'];
    isClosed = json['is_closed'];
    url = json['url'];
    reviewCount = json['review_count'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    if (json['hours'] != null) {
      hours = <Hours>[];
      json['hours'].forEach((v) {
        hours!.add(Hours.fromJson(v));
      });
    }
    rating = json['rating'];
    coordinates = json['coordinates'] != null
        ? Coordinates.fromJson(json['coordinates'])
        : null;
    transactions = json['transactions']?.cast<String>() ?? [];
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    phone = json['phone'];
    displayPhone = json['display_phone'];
    distance = json['distance'];
    attributes = json['attributes'] != null
        ? Attributes.fromJson(json['attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['alias'] = alias;
    data['name'] = name;
    data['image_url'] = imageUrl;
    data['is_closed'] = isClosed;
    data['url'] = url;
    if (hours != null) {
      data['hours'] = hours!.map((v) => v.toJson()).toList();
    }
    data['review_count'] = reviewCount;
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    data['rating'] = rating;
    if (coordinates != null) {
      data['coordinates'] = coordinates!.toJson();
    }
    data['transactions'] = transactions;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['phone'] = phone;
    data['display_phone'] = displayPhone;
    data['distance'] = distance;
    if (attributes != null) {
      data['attributes'] = attributes!.toJson();
    }
    return data;
  }
}

class Hours {
  List<Open>? open;
  String? hoursType;
  bool? isOpenNow;

  Hours({this.open, this.hoursType, this.isOpenNow});

  Hours.fromJson(Map<String, dynamic> json) {
    if (json['open'] != null) {
      open = <Open>[];
      json['open'].forEach((v) {
        open!.add(Open.fromJson(v));
      });
    }
    hoursType = json['hours_type'];
    isOpenNow = json['is_open_now'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (open != null) {
      data['open'] = open!.map((v) => v.toJson()).toList();
    }
    data['hours_type'] = hoursType;
    data['is_open_now'] = isOpenNow;
    return data;
  }
}

class Open {
  bool? isOvernight;
  String? start;
  String? end;
  int? day;

  Open({this.isOvernight, this.start, this.end, this.day});

  Open.fromJson(Map<String, dynamic> json) {
    isOvernight = json['is_overnight'];
    start = json['start'];
    end = json['end'];
    day = json['day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_overnight'] = isOvernight;
    data['start'] = start;
    data['end'] = end;
    data['day'] = day;
    return data;
  }
}

class ReviewModel {
  String? id;
  String? url;
  String? text;
  int? rating;
  String? timeCreated;
  User? user;

  ReviewModel(
      {this.id, this.url, this.text, this.rating, this.timeCreated, this.user});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    text = json['text'];
    rating = json['rating'];
    timeCreated = json['time_created'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['text'] = text;
    data['rating'] = rating;
    data['time_created'] = timeCreated;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? profileUrl;
  String? imageUrl;
  String? name;

  User({this.id, this.profileUrl, this.imageUrl, this.name});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profileUrl = json['profile_url'];
    imageUrl = json['image_url'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['profile_url'] = profileUrl;
    data['image_url'] = imageUrl;
    data['name'] = name;
    return data;
  }
}

class Categories {
  String? alias;
  String? title;

  Categories({this.alias, this.title});

  Categories.fromJson(dynamic json) {
    alias = json['alias'];
    title = json['title'];
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Categories && other.alias == alias;
  }

  @override
  int get hashCode => alias.hashCode;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['alias'] = alias;
    data['title'] = title;
    return data;
  }
}

class Coordinates {
  double? latitude;
  double? longitude;

  Coordinates({this.latitude, this.longitude});

  Coordinates.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}

class Location {
  String? address1;
  String? address2;
  String? address3;
  String? city;
  String? zipCode;
  String? country;
  String? state;
  List<String>? displayAddress;

  Location(
      {this.address1,
      this.address2,
      this.address3,
      this.city,
      this.zipCode,
      this.country,
      this.state,
      this.displayAddress});

  Location.fromJson(Map<String, dynamic> json) {
    address1 = json['address1'];
    address2 = json['address2'];
    address3 = json['address3'];
    city = json['city'];
    zipCode = json['zip_code'];
    country = json['country'];
    state = json['state'];
    displayAddress = json['display_address'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address1'] = address1;
    data['address2'] = address2;
    data['address3'] = address3;
    data['city'] = city;
    data['zip_code'] = zipCode;
    data['country'] = country;
    data['state'] = state;
    data['display_address'] = displayAddress;
    return data;
  }
}

class Attributes {
  dynamic businessTempClosed;
  String? menuUrl;
  dynamic open24Hours;
  dynamic waitlistReservation;

  Attributes(
      {this.businessTempClosed,
      this.menuUrl,
      this.open24Hours,
      this.waitlistReservation});

  Attributes.fromJson(Map<String, dynamic> json) {
    businessTempClosed = json['business_temp_closed'];
    menuUrl = json['menu_url'];
    open24Hours = json['open24_hours'];
    waitlistReservation = json['waitlist_reservation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['business_temp_closed'] = businessTempClosed;
    data['menu_url'] = menuUrl;
    data['open24_hours'] = open24Hours;
    data['waitlist_reservation'] = waitlistReservation;
    return data;
  }
}
