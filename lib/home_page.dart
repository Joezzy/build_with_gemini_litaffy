import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

String TTS_INPUT =
    "In the first law, an object will not change its motion unless a force acts on it. "
    // "In the second law, the force on an object is equal to its mass times its acceleration. "
    // "In the third law, when two objects interact, they apply forces to each other of equal magnitude and opposite direction."
    ;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FlutterTts _flutterTts = FlutterTts();

  List<Map> _voices = [];
  Map? _currentVoice;

  int? _currentWordStart, _currentWordEnd;

  @override
  void initState() {
    super.initState();
    initTTS();
  }

  void initTTS() async {
    await _flutterTts.setLanguage('en-US');
    await _flutterTts.setSpeechRate(.4);
    await _flutterTts.setVolume(1.0);

    // _flutterTts.setProgressHandler((text, start, end, word) {
    //   setState(() {
    //     _currentWordStart = start;
    //     _currentWordEnd = end;
    //   });
    // });
    _flutterTts.getVoices.then((data) {
      try {
        List<Map> voices = List<Map>.from(data);
        setState(() {
          _voices = voices;
          // voices.where((voice) => voice["name"].contains("en")).toList();
          _currentVoice = _voices[4];
          setVoice(_currentVoice!);
        });
      } catch (e) {
        print(e);
      }
    });
  }

  void setVoice(Map voice) {
    _flutterTts.setVoice({"name": voice["name"], "locale": voice["locale"]});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _flutterTts.speak(TTS_INPUT);
        },
        child: const Icon(
          Icons.speaker_phone,
        ),
      ),
    );
  }

  Widget _buildUI() {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _speakerSelector(),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 20,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: TTS_INPUT.substring(0, _currentWordStart),
                ),
                if (_currentWordStart != null)
                  TextSpan(
                    text: TTS_INPUT.substring(
                        _currentWordStart!, _currentWordEnd),
                    style: const TextStyle(
                      color: Colors.white,
                      backgroundColor: Colors.purpleAccent,
                    ),
                  ),
                if (_currentWordEnd != null)
                  TextSpan(
                    text: TTS_INPUT.substring(_currentWordEnd!),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _speakerSelector() {
    return DropdownButton(
      value: _currentVoice,
      items: _voices
          .map(
            (_voice) => DropdownMenuItem(
              value: _voice,
              child: Text(
                _voice["name"],
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        setState(() {
          _currentVoice = value;
          setVoice(value!);
          print(_currentVoice);
        });
      },
    );
  }
}
