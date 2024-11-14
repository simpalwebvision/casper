import 'dart:async';
import 'dart:developer';

import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/common_appbar.dart';
import 'package:caspro_enterprises/Widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'complaint_proceed_controller.dart';

class ComplaintProceed extends StatefulWidget {
  const ComplaintProceed({super.key});

  @override
  State<ComplaintProceed> createState() => _ComplaintProceedState();
}

class _ComplaintProceedState extends State<ComplaintProceed> {
  final controller = Get.put(ComplaintProceedController());
  String _wordsSpoken = "";
  final SpeechToText _speech = SpeechToText();
  bool _speechEnabled = false;
  // int _wordCount = 0;
  String _selectedLanguage = 'hi_IN';
  Timer? _listeningTimer;

  final List<Map<String, String>> _languages = [
    {'Hindi': 'hi_IN'},
    {'English': 'en_US'},
  ];

  @override
  void initState() {
    super.initState();
    _initializeSpeech();
    _loadSavedText();
  }

  Future<void> _initializeSpeech() async {
    _speechEnabled = await _speech.initialize(
      onStatus: (status) => log("Speech status: $status"),
      onError: (error) => log("Speech error: $error"),
    );
    setState(() {});
  }

  void _startListening() async {
    if (_speechEnabled) {
      await _speech.listen(
        onResult: _onSpeechResult,
        localeId: _selectedLanguage,
      );

      // Set a timer to automatically stop listening after 60 seconds.
      _listeningTimer?.cancel();
      _listeningTimer = Timer(const Duration(seconds: 60), () {
        if (_speech.isListening) {
          _stopListening();
        }
      });

      setState(() {});
    }
  }

  void _stopListening() async {
    await _speech.stop();
    _listeningTimer?.cancel();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    if (result.finalResult) {
      setState(() {
        _wordsSpoken += "${result.recognizedWords} ";
        // _wordCount = _wordsSpoken.trim().split(RegExp(r'\s+')).length;
      });
    }
  }

  void _clearWords() {
    setState(() {
      _wordsSpoken = "";
      // _wordCount = 0;
    });
    _saveText("");
  }

  void _saveText(String text) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('saved_text', text);
  }

  void _loadSavedText() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _wordsSpoken = prefs.getString('saved_text') ?? "";
      // _wordCount = _wordsSpoken.trim().split(RegExp(r'\s+')).length;
    });
  }

  @override
  void dispose() {
    _speech.cancel();
    _listeningTimer?.cancel();
    Get.delete<ComplaintProceedController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context: context, heading: "Complaint"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.zero,
              shadowColor: Colors.grey.shade200,
              elevation: 4,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Remarks",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Divider(height: 20, thickness: 1.5),
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        _wordsSpoken.isEmpty
                            ? "Speak to add remarks..."
                            : _wordsSpoken,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    // const SizedBox(height: 8),
                    // Text(
                    //   "Word Count: $_wordCount",
                    //   style: GoogleFonts.poppins(
                    //     fontSize: 12,
                    //     color: Colors.grey.shade600,
                    //   ),
                    // ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton(
                          backgroundColor: _speech.isListening
                              ? Colors.redAccent
                              : Colors.blue,
                          onPressed: _speech.isListening
                              ? _stopListening
                              : _startListening,
                          child: Icon(
                            _speech.isListening ? Icons.mic_off : Icons.mic,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 16),
                        IconButton(
                          icon: const Icon(
                            Icons.clear,
                            color: Colors.red,
                          ),
                          onPressed: _clearWords,
                          iconSize: 35,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Center(
                        child: Text(
                          _speech.isListening
                              ? "Listening..."
                              : _speechEnabled
                                  ? "Tap microphone to start"
                                  : "Speech not available",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: _speech.isListening
                                ? Colors.redAccent
                                : Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: _selectedLanguage,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedLanguage = newValue!;
                          });
                        },
                        items: _languages
                            .map((lang) => DropdownMenuItem<String>(
                                  value: lang.values.first,
                                  child: Text(
                                    lang.keys.first,
                                    style: GoogleFonts.poppins(fontSize: 14),
                                  ),
                                ))
                            .toList(),
                        dropdownColor: Colors.white,
                        iconEnabledColor: Colors.blue,
                        style: GoogleFonts.poppins(
                          color: Colors.black87,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            AppButton(
              backColor: Colors.blue,
              child: Text(
                "Submit",
                style: GoogleFonts.poppins(color: Colors.white),
              ),
              onPressed: () {
                // _saveText(_wordsSpoken);
                // Handle additional submit actions here

                controller.updateComplaint(_wordsSpoken);
              },
            ),
          ],
        ),
      ),
    );
  }
}
