// import 'package:file_picker/file_picker.dart' as filepicker;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:littafy/constant/constants.dart';
import 'package:littafy/src/generator/presentation/controller/generator_controller.dart';
import 'package:littafy/src/generator/presentation/views/appDrawer.dart';
import 'package:littafy/src/generator/presentation/views/get_text_Option.dart';
import 'package:littafy/utils/app_theme.dart';
import 'package:littafy/utils/size_config.dart';
// import 'package:pdf_text/pdf_text.dart';
// import 'package:firebase_ml_vision/firebase_ml_vision.dart';

String inputString = '''
 **Question 5:**
 /Einstein received the Nobel Prize in Physics for:**
 - - Developing the theory of relativity
 - - Discovering the law of the photoelectric effect*
 - - Inventing the atomic bomb
 - - Creating the first computer

/What is the primary focus of chemistry?
a) The study of living organisms
b) The study of the solar system
c) *The study of matter and the ways in which different forms of matter combine with each other
d) The study of the Earth's atmosphere

/Which of the following is not a state of matter?
a) Solid
b) Liquid
c) Gas
d) *Plasma

/What is the purpose of the scientific method?
a) To determine new knowledge about the universe through observation and experiment
b) To establish laws and theories without any experimental evidence
c) *To provide a rigorous process for scientists to determine new knowledge about the universe
d) To make predictions about the future of the universe

/Which of the following is a characteristic of a scientific law?
a) A scientific law is a hypothesis that has been repeatedly tested and confirmed
b) *A scientific law describes a relationship between observed phenomena without explaining the reason for the relationship
c) A scientific law is a theory that has been proven true beyond all doubt
d) A scientific law is a statement that can be used to make accurate predictions about the future

/What is the importance of studying chemistry?
a) Chemistry is only relevant for researchers and scientists
b) Chemistry is not important for understanding the world around us
c) *Chemistry helps us understand the world around us, as everything we interact with is a chemical
d) Chemistry is only useful for certain fields, such as medicine or engineering
''';

String quizText2 = '''
 /1. What is the correct pronunciation of Francesc Fàbregas Soler's name in Catalan?
 - [sɛsk faßreyes]* 
 - [faßreyas] 
 - [faßraygas] 
 - [sɛsk faßregas] 
 
 /2. What position did Fàbregas play on the field?
 - Striker 
 - Goalkeeper 
 - Central midfielder* 
 - Defender 
 
 /3. Which club did Fàbregas leave when he was 16 years old?
 - Barcelona* 
 - Arsenal 
 - Chelsea 
 - Real Madrid 
 
 /4. In which year did Fàbregas return to London after leaving Barcelona?
 - 2013 
 - 2014* 
 - 2015 
 - 2016 
 
 /5. What major international trophy did Fàbregas win with the Spanish national team in 2010?
 - European Championship 
 - FIFA World Cup* 
 - Confederations Cup 
 - Copa América
''';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final generatorController = Get.put(GeneratorController());

  @override
  void initState() {
    super.initState();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        endDrawer: const AppDrawer(),
        drawerEnableOpenDragGesture: true,
        // endDrawerEnableOpenDragGesture: true,
        // floatingActionButton: FloatingActionButton(
        //   elevation: 0,
        //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        //   onPressed: () async {
        //    // final getQuest= QuizGenerator.convertTriviaToJson(inputString);
        //    //  Navigator.of(context).push(
        //    //    MaterialPageRoute(
        //    //      builder: (context)  =>  QuizScreen(
        //    //        "New Quiiz"
        //    //          quizList: getQuest ),
        //    //    ),
        //    //  );
        //   },
        //   child: const Icon(Iconsax.add),
        // ),
        appBar: AppBar(
          // backgroundColor: AppTheme.white,
          // surfaceTintColor: AppTheme.white,
          actions: [
            GestureDetector(
              onTap: () {
                scaffoldKey.currentState?.openEndDrawer();
                print("object");
              },
              child: Padding(
                padding: EdgeInsets.only(right: MySize.size20),
                child: const Icon(Iconsax.menu),
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Obx(
            () => Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: MySize.screenHeight,
                  padding: EdgeInsets.only(
                    // top: MySize.size30,
                    left: MySize.size25,
                    right: MySize.size25,
                  ),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      Text(
                        "hello",
                        style: AppTheme.title4,
                      ).tr(),
                      Text(
                        "${currentUser!.firstName}",
                        style: AppTheme.title3,
                      ),
                      SizedBox(
                        height: MySize.size20,
                      ),
                      SizedBox(
                        height: MySize.size20,
                      ),
                      GetTextOption(
                        isInputView: false,
                      ),
                    ],
                  ),
                ),
                if (generatorController.isLoading.value)
                  Container(
                    height: MySize.screenHeight,
                    width: MySize.screenWidth,
                    color: AppTheme.primaryColor.withOpacity(.3),
                    child: Center(
                      child: Image.asset(
                        "${assetImage}ai_loader.gif",
                        height: MySize.size50,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ));
  }

  getStarted(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        backgroundColor: AppTheme.white,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState2) {
            return FractionallySizedBox(
              heightFactor: 0.8,
              child: Padding(
                padding: EdgeInsets.all(MySize.size22),
                child: GetTextOption(),
              ),
            );
          });
        });
  }
}
