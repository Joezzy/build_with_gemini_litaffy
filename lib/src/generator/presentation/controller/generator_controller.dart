import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:littafy/constant/constants.dart';
import 'package:littafy/constant/optionType.dart';
import 'package:littafy/di/appModule.dart';
import 'package:littafy/local/db_helper.dart';
import 'package:littafy/src/generator/domain/usecases/ai_use_cases.dart';
import 'package:littafy/src/generator/presentation/controller/note_controller.dart';
import 'package:littafy/src/generator/presentation/views/scanner_view.dart';
import 'package:littafy/src/generator/presentation/views/text_input_view.dart';
import 'package:littafy/utils/custom_dialog.dart';
import 'package:littafy/utils/usecase.dart';
import 'package:mime/mime.dart';
import 'package:read_pdf_text/read_pdf_text.dart';
import 'package:share_plus/share_plus.dart';

class GeneratorController extends GetxController {
  final noteController = Get.put(NoteController());

  var textInputController = TextEditingController().obs;
  var textOutputController = TextEditingController().obs;
  var urlInputController = TextEditingController().obs;
  var noteTitleController = TextEditingController().obs;
  var isInput = true.obs;
  var isLoading = false.obs;
  var outputText = "".obs;
  RxString? noteType;

  var titleController = TextEditingController().obs;
  var assetDbHelper = AssetDbHelper();

  var option1List = <OptionClass>[].obs;
  var option2List = <OptionClass>[].obs;
  var option3List = <OptionClass>[].obs;
  var option1 = "".obs;
  var option2 = "".obs;
  var option3 = "".obs;

  void getGeneratorOptionMethod() async {
    option1List.value = await assetDbHelper.getOptions();
  }

  void selectOption1(option) async {
    print("option1: $option");
    option1.value = option;
    option2List.value =
        await assetDbHelper.searchItem("generator_option2", "gen_key", option);
  }

  void selectOption2(option) async {
    print("option2: $option");

    option2.value = option;
    option3List.value = await assetDbHelper.searchItem(
        "generator_option3", "gen_key", option1.value);
  }

  Future selectOption3(context, option) async {
    print("option3: $option");

    option3.value = option;
    await getValues(context);
  }

  Future pickPDFText() async {
    var filePickerResult = await FilePicker.platform.pickFiles();
    try {
      if (filePickerResult != null) {
        String textInput =
            await ReadPdfText.getPDFtext(filePickerResult.files.single.path!);
        textInputController.value.text =
            textInputController.value.text + textInput;
        isLoading.value = false;
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
    }
  }

  File? _image;
  final picker = ImagePicker();

  Future getImageFromGallery(context, String method) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    try {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        final mimeType = lookupMimeType(pickedFile.path);
        print("mimeType:: $mimeType");

        if (method == "gallery") {
          await readTextFromImage(_image);
          isLoading.value = false;
        } else if (method == "equation") {
          await geminiVisionMethod(
              context, _image!, "Solve the problem in the image");
          isLoading.value = false;
        } else if (method == "identification") {
          await geminiVisionMethod(
              context, _image!, "Identify the object in the image");
          isLoading.value = false;
        }
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
    }
  }

  Future<void> readTextFromImage(File? image) async {
    final inputImage = InputImage.fromFile(image!);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    String recognisedText = "";

    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        print("block: $block");
        print("line.text: ${line.text}");
        recognisedText += "${line.text}\n";
      }
    }

    String textInput = recognizedText.text;
    textInputController.value.text =
        "${textInputController.value.text}\n$textInput";
    textRecognizer.close();
    textInputController.value.selection =
        TextSelection.collapsed(offset: textInputController.value.text.length);
  }

  Future scanTextWithCamera(context) async {
    final textInput = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const TextScanner(),
      ),
    );
    if (textInput != null) {
      textInputController.value.text =
          textInputController.value.text + textInput;
      isLoading.value = false;
    } else {
      isLoading.value = false;
    }
  }

  textSelectionMethod(context, String method, bool isInputView) async {
    isLoading.value = true;

    if (isInputView) Navigator.pop(context);

    print("method: $method");
    if (method == "pdf") {
      await pickPDFText();
    } else if (method == "gallery") {
      await getImageFromGallery(context, "gallery");
    } else if (method == "camera") {
      await scanTextWithCamera(context);
    } else if (method == "url") {
    } else if (method == "equation") {
      await getImageFromGallery(context, "equation");
    } else if (method == "identification") {
      await getImageFromGallery(context, "identification");
    }

    if (isInputView && textInputController.value.text.isNotEmpty) {
    } else {
      if (!isInputView) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const TextInputView(),
          ),
        );
      }
    }
  }

  var level = 1.obs;

  String command = "";
  Future getValues(context) async {
    bool isQuiz = false;
    print("option1.value ${option1.value}");
    print("option2.value ${option2.value}");
    print("option3.value ${option3.value}");

    if (option1.value == "generate") {
      if (option2.value == "Multiple choice question" ||
          option2.value == "quiz") {
        command =
            "Generate ${option3.value} Multiple choice question ,start each question with '/',each question must have 4 choices and 1 answer, start each choice with '-' and end correct choice with '*' symbol , from content:  ${textInputController.value.text}";
        // if(option2.value=="Quiz" )
        isQuiz = true;
      } else {
        command =
            "Generate ${option3.value} ${option2.value},from content:  ${textInputController.value.text}";
      }
    } else {
      command =
          "Summarize system to ${option2.value} in ${option3.value} characters, from content:  ${textInputController.value.text}";
    }

    print(command);
    await geminiTextMethod(context, command, isQuiz);
  }

  //////
  final model = GenerativeModel(
    model: 'gemini-pro',
    apiKey: geminiKey,
  );

  final _visionModel = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: geminiKey,
  );


  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  final FocusNode _textFieldFocus = FocusNode();
  final List<({Image? image, String? text, bool fromUser})> _generatedContent =
      <({Image? image, String? text, bool fromUser})>[];

  final aiUseCases = getIt<AiUseCases>();

// Google GEMINI

  Future<void> geminiVisionMethod(context, File file, String prompt) async {
    isLoading.value = true;
    try {
      Uint8List bytes = file.readAsBytesSync();

      final content = [
        Content.multi([
          TextPart(prompt),
          DataPart('image/jpeg', bytes),
        ])
      ];
      var response = await _visionModel.generateContent(content);
      var text = response.text;
      if (text == null) {
        Dialogs.alertBox(context, appName, "No response");
        return;
      } else {
        generatedText.value = text.toString();
        print("response:=: ${generatedText.value}");
        outputText.value = text.toString();
        isInput.value = false;
        textOutputController.value.text = text.toString();
        isLoading.value = false;
      }
    } catch (e) {
      Dialogs.alertBox(context, appName, e.toString());

      isLoading.value = false;
    } finally {
      _textController.clear();
      isLoading.value = false;
      _textFieldFocus.requestFocus();
    }
  }

  Future geminiTextMethod(context, String prompt, bool isQuiz) async {
    isLoading.value = true;
    print("START_HERE, isQuiz:  $isQuiz");

    try {
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      final text = response.text;
      if (text == null) {
        Dialogs.alertBox(context, appName, "No response");
        isLoading.value = false;

        return;
      } else {
        isLoading.value = false;
        generatedText.value = text.toString();
        print("gemRes:=: ${generatedText.value}");
        outputText.value = text.toString();
        isInput.value = false;
        textOutputController.value.text = text.toString();
        isLoading.value = false;

        //
        // if(isQuiz){
        //   SchedulerBinding.instance!.addPostFrameCallback((_) {
        //     Navigator.of(context).push( MaterialPageRoute(builder: (context) =>  QuizScreen(
        //         quizTitle: "New Quiz",
        //         quizList: getQuest),
        //     ),
        //     );          });
        //
        //
        //
        //
        // }
        // else{
        //   Navigator.pop(context);
        // }
      }
    } catch (e) {
      Dialogs.alertBox(context, appName, e.toString());
      isLoading.value = false;
    } finally {
      _textController.clear();
      isLoading.value = false;
      _textFieldFocus.requestFocus();
    }
  }

  var generatedText = "".obs;

  Future saveNoteMethod(context) async {
    await noteController.addNoteMethod(
        context,
        noteTitleController.value.text.isEmpty
            ? "No title"
            : noteTitleController.value.text,
        isInput.value
            ? textInputController.value.text
            : textOutputController.value.text,
        noteType!.value);
    noteTitleController.value.text = "";
  }

  copyText() {
    Clipboard.setData(
      ClipboardData(
        text: isInput.value
            ? textInputController.value.text
            : textOutputController.value.text,
      ),
    );
  }

  shareText() {
    Share.share(
        isInput.value
            ? textInputController.value.text
            : textOutputController.value.text,
        subject: appName);
  }

  shareNotes(title, content) {
    Share.share(content, subject: title);
  }

  Future getArticleMethod(context, bool isInputView) async {
    print(isInputView);
    isLoading.value = true;
    // Navigator.pop(context);

    final result = await aiUseCases
        .getArticleUseCase(Params(urlInputController.value.text.trim()));
    result.fold((failure) {
      Dialogs.alertBox(context, "Failed", failure.message);
      isLoading.value = false;
    }, (success) {
      textInputController.value.text = success.message;
      urlInputController.value.clear();
      isLoading.value = false;
      if (!isInputView) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const TextInputView(),
          ),
        );
      } else {
        Navigator.pop(context);
        Navigator.pop(context);
      }
    });
  }
}
