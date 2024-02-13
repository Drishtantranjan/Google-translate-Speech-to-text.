import 'package:flutter/material.dart';
import 'package:flutter_assignment/list/domain/usecase/speech_to_text_usecase.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddTermBottomSheet extends StatefulWidget {
  final Function(String) onAddTerm;

  const AddTermBottomSheet({Key? key, required this.onAddTerm})
      : super(key: key);

  @override
  _AddTermBottomSheetState createState() => _AddTermBottomSheetState();
}

class _AddTermBottomSheetState extends State<AddTermBottomSheet> {
  TextEditingController _newTermController = TextEditingController();
  late SpeechToTextUseCase _speechToTextUseCase;

  @override
  void initState() {
    super.initState();
    _speechToTextUseCase = SpeechToTextUseCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _newTermController,
            decoration: InputDecoration(
              labelText: 'Enter new term and condition.',
            ),
          ),
          16.verticalSpace,
          ElevatedButton(
            onPressed: () {
              widget.onAddTerm(_newTermController.text);
              _newTermController.clear();
              Navigator.pop(context);
            },
            child: Text("Add Term"),
          ),
          ElevatedButton(
            onPressed: _startListening,
            child: Text("Speak to Add Term"),
          ),
        ],
      ),
    );
  }

  void _startListening() {
    _speechToTextUseCase.listenForSpeech(
      onResult: (recognizedWords) {
        setState(() {
          _newTermController.text = recognizedWords;
        });
      },
      onError: (error) {
        print("Speech recognition error: $error");
      },
    );
  }

  @override
  void dispose() {
    _newTermController.dispose();
    _speechToTextUseCase.stopListening();
    super.dispose();
  }
}
