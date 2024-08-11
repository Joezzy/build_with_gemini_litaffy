import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iconsax/iconsax.dart';
import 'package:littafy/constant/countryJson.dart';
import 'package:littafy/constant/optionType.dart';
import 'package:littafy/src/auth/domain/entities/country_state_model.dart';
import 'package:littafy/src/auth/domain/entities/user_model.dart';

String appName = "Littafy";
const assetImage = "assets/images/";
String? loginToken;
CurrentUser? currentUser;

List<CountryStateModel> countryList =
    countryStateListFromJson(json.encode(countryJson));

String geminiKey = dotenv.env["GEMINI_KEY"].toString();
String articleBaseUrl = dotenv.env["ARTICLE_BASE_URL"].toString();

List<OptionClass> mainOptionList = [
  OptionClass(
      title: "pdf_text".tr(),
      subtitle: "get_text_from_pdf".tr(),
      value: "pdf",
      icon: Iconsax.document),
  OptionClass(
      title: "camera_text".tr(),
      subtitle: "scan_text_with_camera".tr(),
      value: "camera",
      icon: Icons.camera_outlined),
  OptionClass(
      title: "gallery_text".tr(),
      subtitle: "get_text_from_image".tr(),
      value: "gallery",
      icon: Iconsax.gallery),
  OptionClass(
      title: "url_text".tr(),
      subtitle: "get_text_from_url".tr(),
      value: "url",
      icon: Iconsax.global),
  OptionClass(
      title: "solve_text".tr(),
      subtitle: "Scan question to evaluate",
      value: "equation",
      icon: Iconsax.math),
  OptionClass(
      title: "object_text".tr(),
      subtitle: "identify_object".tr(),
      value: "identification",
      icon: Iconsax.scan)
];

List<OptionClass> generateOptionList = [
  OptionClass(title: "Summarize text", value: "summarize"),
  OptionClass(title: "Generate question", value: "question"),
  // OptionType( title: "Lesson note", value: "camera")
];

List<OptionClass> questionOptionList = [
  OptionClass(
      title: "Multiple choice question(Objective)",
      value: "Multiple choice question"),
  OptionClass(
      title: "Fill in the gap questions", value: "Fill in the gap questions"),
  OptionClass(title: "Theory questions", value: "Theory questions")
];

List<OptionClass> questionNumberList = [
  OptionClass(title: "5 questions", value: "5"),
  OptionClass(title: "10 questions", value: "10"),
  OptionClass(title: "15 questions", value: "15"),
  OptionClass(title: "20 questions", value: "20"),
  OptionClass(title: "30 questions", value: "30"),
  OptionClass(title: "40 questions", value: "40"),
  OptionClass(title: "50 questions", value: "50")
];

List<OptionClass> summaryNumberList = [
  OptionClass(title: "200 characters", value: "200"),
  OptionClass(title: "300 characters", value: "300"),
  OptionClass(title: "400 characters", value: "400"),
  OptionClass(title: "500 characters", value: "500"),
  OptionClass(title: "700 characters", value: "700"),
  OptionClass(title: "600 characters", value: "800"),
  OptionClass(title: "1000 characters", value: "1000"),
  OptionClass(title: "1200 characters", value: "1200"),
  OptionClass(title: "1500 characters", value: "1500"),
  OptionClass(title: "2000 characters", value: "2000"),
  OptionClass(title: "3000 characters", value: "3000"),
  OptionClass(title: "4000 characters", value: "4000"),
  OptionClass(title: "5000 characters", value: "5000"),
  OptionClass(title: "7000 characters", value: "7000"),
  OptionClass(title: "10000 characters", value: "10000"),
];

List<OptionClass> noteTypeList = [
  OptionClass(title: "Notes", value: "note"),
  OptionClass(title: "Summary", value: "summary"),
  OptionClass(title: "Questions", value: "questions"),
  OptionClass(title: "Quiz", value: "quiz"),
];
