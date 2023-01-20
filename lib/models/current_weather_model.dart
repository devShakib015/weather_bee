class CurrentWeatherModel {
  CurrentWeatherModel({
    required this.location,
    required this.current,
  });

  Location location;
  Current current;

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) =>
      CurrentWeatherModel(
        location: Location.fromJson(json["location"]),
        current: Current.fromJson(json["current"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "current": current.toJson(),
      };
}

class Current {
  Current({
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.condition,
  });

  double tempC;
  double tempF;
  int isDay; // 1 for day, 0 for night
  Condition condition;

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        tempC: json["temp_c"]?.toDouble(),
        tempF: json["temp_f"],
        isDay: json["is_day"],
        condition: Condition.fromJson(json["condition"]),
      );

  Map<String, dynamic> toJson() => {
        "temp_c": tempC,
        "temp_f": tempF,
        "is_day": isDay,
        "condition": condition.toJson(),
      };
}

class Condition {
  Condition({
    required this.text,
    required this.icon,
  });

  String text;
  String icon;

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
        text: json["text"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "icon": icon,
      };
}

class Location {
  Location({
    required this.name,
    required this.country,
  });

  String name;
  String country;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "country": country,
      };
}
