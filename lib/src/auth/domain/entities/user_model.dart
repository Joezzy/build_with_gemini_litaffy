import 'dart:convert';

class CurrentUser {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? image;
  String? password;
  String? createdAt;
  String? lastActive;
  String? pushToken;
  String? country;
  String? schoolType;
  String? school;
  String? grade;
  double? latitude;
  double? longitude;
  double? credit;

  CurrentUser({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.image,
    this.password,
    this.createdAt,
    this.lastActive,
    this.pushToken,
    this.country,
    this.schoolType,
    this.school,
    this.grade,
    this.latitude,
    this.longitude,
    this.credit,
  });

  factory CurrentUser.fromJson(String str) =>
      CurrentUser.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CurrentUser.fromMap(Map<String, dynamic> json) => CurrentUser(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        image: json["image"],
        password: json["password"],
        createdAt: json["created_at"],
        lastActive: json["last_active"],
        pushToken: json["push_token"],
        country: json["country"],
        schoolType: json["school_type"],
        school: json["school"],
        grade: json["grade"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        credit: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "image": image,
        "password": password,
        "created_at": createdAt,
        "last_active": lastActive,
        "push_token": pushToken,
        "country": country,
        "school_type": schoolType,
        "school": school,
        "grade": grade,
        "latitude": latitude,
        "longitude": longitude,
        "credit": credit,
      };
}
