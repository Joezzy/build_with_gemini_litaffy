import 'dart:convert';

List<CountryStateModel> countryStateListFromJson(String str) =>
    List<CountryStateModel>.from(
        json.decode(str).map((x) => CountryStateModel.fromJson(x)));

class CountryStateModel {
  String? name;
  String? iso3;
  List<StateItem>? states;

  CountryStateModel({
    this.name,
    this.iso3,
    this.states,
  });

  CountryStateModel copyWith({
    String? name,
    String? iso3,
    List<StateItem>? states,
  }) =>
      CountryStateModel(
        name: name ?? this.name,
        iso3: iso3 ?? this.iso3,
        states: states ?? this.states,
      );

  factory CountryStateModel.fromRawJson(String str) =>
      CountryStateModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CountryStateModel.fromJson(Map<String, dynamic> json) =>
      CountryStateModel(
        name: json["name"],
        iso3: json["iso3"],
        states: json["states"] == null
            ? []
            : List<StateItem>.from(
                json["states"]!.map((x) => StateItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "iso3": iso3,
        "states": states == null
            ? []
            : List<dynamic>.from(states!.map((x) => x.toJson())),
      };
}

class StateItem {
  String? name;
  String? stateCode;

  StateItem({
    this.name,
    this.stateCode,
  });

  StateItem copyWith({
    String? name,
    String? stateCode,
  }) =>
      StateItem(
        name: name ?? this.name,
        stateCode: stateCode ?? this.stateCode,
      );

  factory StateItem.fromRawJson(String str) =>
      StateItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StateItem.fromJson(Map<String, dynamic> json) => StateItem(
        name: json["name"],
        stateCode: json["state_code"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "state_code": stateCode,
      };
}
