import 'dart:convert';
import 'dart:developer';

import 'package:littafy/src/generator/data/models/mcq_quiz.dart';

class QuizGenerator {
  static List<McqQuiz> mcqQuiz(text) {
    List<Map<String, dynamic>> questions = [];

    // Loop through each question block
    var questionBlocks = text.split('/');

    // print("questionBlocks");
    questionBlocks.removeAt(0);
    // print(questionBlocks);

    for (var block in questionBlocks) {
      // print("BLOCK: $block");
      final lines = block.split('\n');
      final question = lines[0].trim().substring(2); // Remove leading "/"

      // Extract options (assuming format "* a. Dart", "* b. Kotlin", etc.)
      Map<String, dynamic> options = {};
      var correctAnswer;

      for (var i = 1; i < lines.length; i++) {
        final optionLine = lines[i].trim();
        // print("optionLine $optionLine");
        if (optionLine.isEmpty) continue; // Skip empty lines
        var optionKey;
        var optionValue;

        if (optionLine.contains('*')) {
          optionLine.replaceAll("*", "");
          optionKey = optionLine.split(' ')[0];
          List correctAnswerList = optionLine.replaceAll("*", "").split(' ');
          correctAnswerList.removeAt(0);
          correctAnswer = correctAnswerList.join(' ');
          optionValue = optionLine
              .substring(2)
              .trim()
              .replaceAll("*", ""); // Remove leading "* " and trim
          // Get "* a.", "* b.", etc.
        } else {
          optionKey = optionLine.split(' ')[0]; // Get "* a.", "* b.", etc.
          optionValue =
              optionLine.substring(2).trim(); // Remove leading "* " and trim
        }

        // print("optionKey: ${optionKey}");
        // print("optionValue: ${optionValue}");

        // final optionValue = optionLine.substring(2).trim(); // Remove leading "* " and trim
        // print("optionValue: ${optionValue}");
        options[optionKey] = optionValue; // Ex
        // tract option letter (a, b, etc.)
        // print("________________");
      }

      // Extract correct answer (assuming the option with leading "*")
      // final correctAnswer = options.keys.firstWhere((key) => options[key]!.contain('*'));

      questions.add({
        "question": question,
        "options": options,
        "correctAnswer": correctAnswer,
      });

      // print("00000000000000000000000000000000000000000");
    }

    // Convert the list to JSON string

    final jsonData = jsonEncode(questions);

    List<McqQuiz> quizList =
        List<McqQuiz>.from(questions.map((x) => McqQuiz.fromMap(x)));

    // List<McqQuiz> quizList=[];
    // for(var quest  in questions){
    //   print("quest:$quest");
    //   // final quiz= McqQuiz.fromJson(convertToJsonStringQuotes(raw:quest));
    //   final quiz= McqQuiz.fromJson(jsonDecode(convertToJsonStringQuotes(raw:quest)));
    //
    //   quizList.add(quiz);
    // }

    // print("TYPE: ${questions.runtimeType}");
    // print(quizList);
    // print(questions.runtimeType);
    // print(questions);
    // print(quizList.first.question);
    // print(quizList.first.question);
    // print("option: ${quizList.first.options!.a}");
    return quizList;
  }

  static List<McqQuiz> serializeQuizText(String text) {
    List<Map<String, dynamic>> questions = [];
    final questionBlocks = text.split('/');

    for (var block in questionBlocks) {
      // print("BLOCK: $block");
      final lines = block.split('\n');
      final question = lines[0].trim().substring(2); // Remove leading "/"

      // Extract options (assuming format "* a. Dart", "* b. Kotlin", etc.)
      Map<String, dynamic> options = {};
      String? correctAnswer;

      for (var i = 1; i < lines.length; i++) {
        final optionLine = lines[i].trim();
        // print("optionLine $optionLine");
        if (optionLine.isEmpty) continue; // Skip empty lines
        var optionKey;
        var optionValue;

        if (optionLine.contains('*')) {
          optionLine.replaceAll("*", "");
          optionKey = optionLine.split(' ')[0];
          List correctAnswerList = optionLine.replaceAll("*", "").split(' ');
          correctAnswerList.removeAt(0);
          correctAnswer = correctAnswerList.join(' ');
          optionValue = optionLine
              .substring(2)
              .trim()
              .replaceAll("*", ""); // Remove leading "* " and trim
        } else {
          optionKey = optionLine.split(' ')[0]; // Get "* a.", "* b.", etc.
          optionValue = optionLine.substring(2).trim();
          // Remove leading "* " and trim
        }

        // print("optionKey: ${optionKey}");
        // print("optionValue: ${optionValue}");

        // final optionValue = optionLine.substring(2).trim(); // Remove leading "* " and trim
        // print("optionValue: ${optionValue}");
        options[optionKey] = optionValue; // Ex
        // tract option letter (a, b, etc.)
        // print("________________");
      }

      // Extract correct answer (assuming the option with leading "*")
      // final correctAnswer = options.keys.firstWhere((key) => options[key]!.contain('*'));

      questions.add({
        "question": question,
        "options": options,
        "correctAnswer": correctAnswer!,
      });

      // print("00000000000000000000000000000000000000000");
    }

    List<McqQuiz> quizList =
        List<McqQuiz>.from(questions.map((x) => McqQuiz.fromMap(x)));

    return quizList;
  }

  static List<McqQuiz> convertTriviaToJson(String triviaString) {
    List<String> triviaList = triviaString.split('\n\n');
    List<Map<String, dynamic>> triviaJson = [];

    for (String trivia in triviaList) {
      List<String> lines = trivia.split('\n');
      String question = lines[0].substring(1);
      List<String> choices =
          lines.where((line) => !line.startsWith('/')).toList();
      lines.removeAt(0);
      String? correctAnswer;
      for (int x = 0; x < lines.length; x++) {
        if (lines[x].contains('*')) {
          correctAnswer = x.toString();
        }
      }

      print("_______________________________________");
      Map<String, dynamic> triviaMap = {
        'question': question,
        'correctAnswer': correctAnswer ?? 0,
        'options': choices,
      };
      triviaJson.add(triviaMap);
    }

    log(jsonEncode(triviaJson).toString());
    List<McqQuiz> quizList =
        List<McqQuiz>.from(triviaJson.map((x) => McqQuiz.fromMap(x)));
    return quizList;
  }
}
