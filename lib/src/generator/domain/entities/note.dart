// To parse this JSON data, do
//
//     final note = noteFromJson(jsonString);

import 'dart:convert';

List<Note> noteFromJson(String str) =>
    List<Note>.from(json.decode(str).map((x) => Note.fromJson(x)));

String noteToJson(List<Note> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Note {
  int? id;
  String? title;
  String? content;
  String? category;
  DateTime? date;

  Note({
    this.id,
    this.title,
    this.content,
    this.category,
    this.date,
  });

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        category: json["category"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "category": category,
        "date": date?.toIso8601String(),
      };
}
