import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/translator.dart';

class ListCard extends StatefulWidget {
  final String cardText;

  const ListCard({required this.cardText, Key? key}) : super(key: key);

  @override
  _ListCardState createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {
  late String englishText;
  late String translatedText;

  @override
  void initState() {
    super.initState();
    englishText = widget.cardText;
    translatedText = '';
  }

  void _translateText() async {
    final translator = GoogleTranslator();
    var translation = await translator.translate(englishText, to: 'hi');
    setState(() {
      translatedText = translation.text;
    });
  }

  void _openEditBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: TextEditingController(text: englishText),
                onChanged: (value) {
                  englishText = value;
                },
                decoration: InputDecoration(labelText: 'Edit term'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Implement the logic to save the edited term
                  setState(() {
                    Navigator.pop(context); // Close the bottom sheet
                  });
                },
                child: Text("Save"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black54,
      color: Colors.white,
      child: Column(
        children: [
          ListTile(
            title: Text(englishText),
          ),
          if (translatedText.isNotEmpty)
            ListTile(
              title: Text(translatedText),
            ),
          if (translatedText.isEmpty) // Conditionally render the button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        size: 15,
                      ),
                      onPressed: _openEditBottomSheet, // Call the edit method
                    ),
                  ),
                  10.horizontalSpace,
                  ElevatedButton(
                    onPressed: _translateText,
                    child: Text("Read in Hindi"),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
