import 'dart:convert';

var lang = [
  {"code": "fr-FR", "name": "French"},
  {"code": "en-US", "name": "English (United States)"},
  {"code": "af-AF", "name": "Afrikaans"},
  {"code": "ca-CA", "name": "Catalan"},
  {"code": "cs-CS", "name": "Czech"},
  {"code": "da-DA", "name": "Danish"},
  {"code": "de-DE", "name": "German"},
  {"code": "el-EL", "name": "Greek"},
  {"code": "en-GB", "name": "English (United Kingdom)"},
  {"code": "en-US", "name": "English (United States)"},
  {"code": "es-ES", "name": "Spanish"},
  {"code": "fi-FI", "name": "Finnish"},
  {"code": "fr-FR", "name": "French"},
  {"code": "ha-NG", "name": "Hausa"},
  {"code": "he-HE", "name": "Hebrew"},
  {"code": "hi-HI", "name": "Hindi"},
  {"code": "it-IT", "name": "Italian"},
  {"code": "ig-NG", "name": "Igbo"},
  {"code": "ja-JA", "name": "Japanese"},
  {"code": "ko-KO", "name": "Korean"},
  {"code": "ms-MS", "name": "Malay"},
  {"code": "pt-PT", "name": "Portuguese"},
  {"code": "ru-RU", "name": "Russian"},
  {"code": "yo-NG", "name": "Yoruba"},
  {"code": "zh-ZH", "name": "Chinese"},
  {"code": "zh-CN", "name": "Chinese (China)"},
  {"code": "zu-ZU", "name": "Zulu"}
];

List<LocalModel> languageList =
    List<LocalModel>.from(lang.map((x) => LocalModel.fromMap(x)));

class LocalModel {
  String? code;
  String? name;

  LocalModel({
    this.code,
    this.name,
  });

  factory LocalModel.fromJson(String str) =>
      LocalModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LocalModel.fromMap(Map<String, dynamic> json) => LocalModel(
        code: json["code"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "name": name,
      };
}
