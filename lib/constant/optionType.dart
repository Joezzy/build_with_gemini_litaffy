import 'dart:convert';

import 'package:flutter/cupertino.dart';

List<OptionClass> dropDownClassFromJson(String str) => List<OptionClass>.from(
    json.decode(str).map((x) => OptionClass.fromJson(x)));

String dropDownClassToJson(List<OptionClass> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OptionClass {
  OptionClass({
    this.id,
    this.title,
    this.subtitle,
    required this.value,
    this.icon,
  });

  int? id;
  String? title;
  String? subtitle;
  String value;
  IconData? icon;

  factory OptionClass.fromJson(Map<String, dynamic> json) => OptionClass(
        id: json["id"],
        title: json["title"],
        value: json["value"],
        icon: json["icon"],
        subtitle: json["subtitle"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subtitle": subtitle,
        "value": value,
        "icon": icon,
      };
}
