import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:littafy/constant/constants.dart';
import 'package:littafy/custom/option_tile.dart';
import 'package:littafy/src/generator/presentation/controller/generator_controller.dart';
import 'package:littafy/src/generator/presentation/views/save_note_view.dart';
import 'package:littafy/utils/size_config.dart';
import 'package:littafy/utils/textToQuizConverter.dart';

class ActionOptionView extends StatefulWidget {
  const ActionOptionView({super.key});

  @override
  State<ActionOptionView> createState() => _ActionOptionViewState();
}

class _ActionOptionViewState extends State<ActionOptionView> {
  final generatorController = Get.put(GeneratorController());
  final int totalPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  nextPage() {
    _pageController.nextPage(
        duration: const Duration(milliseconds: 500), curve: Curves.easeInCubic);
  }

  prevPage() {
    _pageController.previousPage(
        duration: const Duration(milliseconds: 500), curve: Curves.easeInCubic);
  }

  @override
  Widget build(BuildContext context) {
    return GetX<GeneratorController>(builder: (generatorController) {
      return Scaffold(
        body: SafeArea(
          child: generatorController.isLoading.value
              ? Center(
                  child: Image.asset(
                    "${assetImage}ai_loader.gif",
                    height: MySize.size100,
                  ),
                )
              : Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            prevPage();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Hero(
                                tag: "generate",
                                child: Icon(
                                  Icons.chevron_left,
                                  size: MySize.size30,
                                )),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      flex: 2,
                      child: PageView(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        onPageChanged: (int page) {
                          _currentPage = page;
                          setState(() {});
                        },
                        children: <Widget>[
                          GenerateFrame(
                              child: ListView.builder(
                            itemCount: generatorController.option1List.length,
                            itemBuilder: (BuildContext context, int index) {
                              final result =
                                  generatorController.option1List[index];
                              return FadeInRight(
                                delay: Duration(milliseconds: 50 * (index + 1)),
                                child: OptionTile(
                                  text: result.title!.tr,
                                  onTap: () {
                                    print(result.title);
                                    print(result.subtitle);
                                    print(result.value);

                                    generatorController
                                        .selectOption1(result.value);
                                    nextPage();
                                    // Navigator.of(context).push(
                                    //   MaterialPageRoute(
                                    //     builder: (context) => const HomePage(),
                                    //   ),
                                    // );
                                  },
                                ),
                              );
                            },
                          )),
                          GenerateFrame(
                            child: ListView.builder(
                              itemCount: generatorController.option2List.length,
                              itemBuilder: (BuildContext context, int index) {
                                final result =
                                    generatorController.option2List[index];
                                return FadeInRight(
                                  delay:
                                      Duration(milliseconds: 50 * (index + 1)),
                                  child: OptionTile(
                                    text: result.title!.tr,
                                    onTap: () {
                                      generatorController
                                          .selectOption2(result.value);
                                      nextPage();
                                      // generatorController. textSelectionMethod(context, result.value!),
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                          GenerateFrame(
                              child: ListView.builder(
                            itemCount: generatorController.option3List.length,
                            itemBuilder: (context, int index) {
                              final result =
                                  generatorController.option3List[index];
                              return FadeInRight(
                                delay: Duration(milliseconds: 50 * (index + 1)),
                                child: OptionTile(
                                  text: result.title!,
                                  onTap: () async {
                                    // List<McqQuiz> qq=[];
                                    generatorController
                                        .textOutputController.value.text = "";

                                    await generatorController
                                        .selectOption3(context, result.value)
                                        .then((value) {
                                      print(
                                          "PRINT: ${generatorController.textOutputController.value.text}");
                                      // final getQuest= QuizGenerator.convertTriviaToJson(generatorController.textOutputController.value.text);

                                      if (generatorController.option2.value ==
                                          "quiz") {
                                        print("QUIIZZ");
                                        final getQuest =
                                            QuizGenerator.convertTriviaToJson(
                                                generatorController
                                                    .textOutputController
                                                    .value
                                                    .text);
                                        showSaveDialog(context, true);
                                        // Navigator.push(this.context,
                                        //     MaterialPageRoute(builder: (context) =>  QuizScreen(
                                        //         quizTitle: "New Quiz",
                                        //         quizList: getQuest)));
                                      } else {
                                        Navigator.pop(this.context);
                                      }
                                    });
                                  },
                                ),
                              );
                            },
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      );
    });
  }

  showSaveDialog(context, isQuiz) {
    showModalBottomSheet(
        context: this.context,
        isScrollControlled: true,
        useRootNavigator: true,
        // backgroundColor: AppTheme.white,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState2) {
            return FractionallySizedBox(
              heightFactor: 0.8,
              child: Padding(
                padding: EdgeInsets.all(MySize.size22),
                child: SaveNoteView(isQuiz: isQuiz),
              ),
            );
          });
        });
  }
}

class GenerateFrame extends StatelessWidget {
  GenerateFrame({super.key, required this.child});

  Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MySize.screenWidth,
        padding: EdgeInsets.symmetric(horizontal: MySize.size15),
        decoration: BoxDecoration(
            // color: AppTheme.white,
            borderRadius: BorderRadius.circular(20)),
        child: child);
  }
}
