// domain/usecases/speech_to_text_usecase.dart
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechToTextUseCase {
  late stt.SpeechToText _speech;

  SpeechToTextUseCase() {
    _speech = stt.SpeechToText();
    _initSpeech();
  }

  void _initSpeech() async {
    await _speech.initialize();
  }

  void listenForSpeech({
    required void Function(String) onResult,
    required void Function(dynamic) onError,
  }) {
    if (!_speech.isListening) {
      try {
        _speech.listen(
          onResult: (result) {
            onResult(result.recognizedWords);
          },
        );
      } catch (e) {
        onError(e); // Pass the error to the callback
      }
    }
  }

  void stopListening() {
    _speech.stop();
  }
}
