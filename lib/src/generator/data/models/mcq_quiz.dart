import 'dart:convert';

class McqQuiz {
  final String? question;
  List<String>? options;
  final String? correctAnswer;

  McqQuiz({
    this.question,
    this.options,
    this.correctAnswer,
  });

  factory McqQuiz.fromJson(String str) => McqQuiz.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory McqQuiz.fromMap(Map<String, dynamic> json) => McqQuiz(
        question: json["question"],
        options: json["options"] == null
            ? []
            : List<String>.from(json["options"]!.map((x) => x)),
        correctAnswer: json["correctAnswer"],
      );

  Map<String, dynamic> toMap() => {
        "question": question,
        "options":
            options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
        "correctAnswer": correctAnswer,
      };
}

// class Options {
//   final String? a;
//   final String? b;
//   final String? c;
//   final String? d;
//
//   Options({
//     this.a,
//     this.b,
//     this.c,
//     this.d,
//   });
//
//   factory Options.fromJson(String str) => Options.fromMap(json.decode(str));
//
//   String toJson() => json.encode(toMap());
//
//   factory Options.fromMap(Map<String, dynamic> json) => Options(
//     a: json["a)"],
//     b: json["b)"],
//     c: json["c)"],
//     d: json["d)"],
//   );
//
//   Map<String, dynamic> toMap() => {
//     "a)": a,
//     "b)": b,
//     "c)": c,
//     "d)": d,
//   };
// }
