import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:littafy/custom/btn.dart';
import 'package:littafy/src/generator/data/models/mcq_quiz.dart';
import 'package:littafy/src/generator/presentation/views/get_text_Option.dart';
import 'package:littafy/utils/app_theme.dart';
import 'package:littafy/utils/size_config.dart';

class QuizScreen extends StatefulWidget {
  final List<McqQuiz> quizList;
  final String quizTitle;
  final bool fromGenerator;

  QuizScreen(
      {required this.quizList,
      required this.quizTitle,
      this.fromGenerator = false});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestion = 0;
  int? selectedAnswer = null;
  int score = 0;
  bool showAnswer = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // await Future.delayed(const Duration(seconds: 3));
      Future.delayed(const Duration(milliseconds: 300), () {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentQuestion == widget.quizList.length) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
                child: RichText(
              text: TextSpan(
                // style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text: "You scored\n",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MySize.size30,
                        color: Colors.black),
                  ),
                  TextSpan(
                    text: "  $score / ${widget.quizList.length}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MySize.size50,
                        color: AppTheme.primaryColor),
                  ),
                ],
              ),
            )

                // Text(
                //   'You scored $score / ${widget.quizList.length}',
                //   style: const TextStyle(fontSize: 20),
                // ),
                ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: FillButton(
                  text: "Continue",
                  onPressed: () {
                    Navigator.pop(context);
                    if (widget.fromGenerator) {
                      Navigator.pop(context);
                    }
                  }),
            ),
          ],
        ),
      );
    }

    var options = widget.quizList[currentQuestion].options!;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MySize.size20),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      if (widget.fromGenerator) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Iconsax.close_circle,
                        size: MySize.size5 = 30,
                        color: Colors.redAccent,
                      ),
                    ),
                  )
                ],
              ),
              Text(
                "${widget.quizTitle}",
                style: TextStyle(
                    fontSize: MySize.size18, fontWeight: FontWeight.bold),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.quizList[currentQuestion].question!,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              ListView.builder(
                itemCount: options.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return options[index] != ""
                      ? SizedBox(
                          height: MySize.size100,
                          child: FadeInRight(
                            delay: const Duration(milliseconds: 100),
                            child: RecCard(
                              title: options[index].replaceAll("*", ""),
                              selected: selectedAnswer == index,
                              // icon: Icon(Icons.question_answer!,size: MySize.size28,),
                              onTap: () {
                                setState(() {
                                  selectedAnswer = index;
                                  print(options[index]);
                                  print(score);
                                  print(currentQuestion);
                                });
                              },
                            ),
                          ),
                        )
                      : null;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: FillButton(
                    text: showAnswer ? "Submit" : "Next",
                    onPressed: () {
                      setState(() {
                        if (currentQuestion == widget.quizList.length - 1) {
                          showAnswer = true;
                        }
                        if (selectedAnswer ==
                            int.parse(widget
                                .quizList[currentQuestion].correctAnswer!)) {
                          score++;
                        }
                        currentQuestion++;
                        selectedAnswer = null;
                      });
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
