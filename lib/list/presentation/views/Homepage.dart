import 'package:flutter/material.dart';
import 'package:flutter_assignment/list/data/term_respository.dart';
import 'package:flutter_assignment/list/domain/entities/term_entity.dart';
import 'package:flutter_assignment/list/domain/usecase/GetAllTermsUseCase.dart';
import 'package:flutter_assignment/list/domain/usecase/add_term_usecase.dart';
import 'package:flutter_assignment/list/presentation/widgets/BottomSheet.dart';
import 'package:flutter_assignment/list/presentation/widgets/Card.dart';

import 'package:speech_to_text/speech_to_text.dart' as stt;

class Homepage extends StatefulWidget {
  final TermRepository termRepository;

  Homepage({Key? key, required this.termRepository}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late GetAllTermsUseCase getAllTermsUseCase;
  late stt.SpeechToText _speech;

  @override
  void initState() {
    super.initState();
    getAllTermsUseCase = GetAllTermsUseCase(repository: widget.termRepository);
    _speech = stt.SpeechToText();
  }

  final AddTermUseCase addTermUseCase = AddTermUseCase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F3F4),
      appBar: AppBar(
        backgroundColor: Colors.black87,
        elevation: 1,
        title: Text(
          "Terms and Condition",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<TermEntity>>(
          future: getAllTermsUseCase.execute(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            } else {
              final List<TermEntity> terms = snapshot.data ?? [];
              return ListView.builder(
                itemCount: terms.length + 1,
                itemBuilder: (context, index) {
                  if (index == terms.length) {
                    return _buildLoadMoreButton(context);
                  } else {
                    return _buildCard(terms[index].text);
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildCard(String cardText) {
    return ListCard(cardText: cardText);
  }

  Widget _buildLoadMoreButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        showModalBottomSheet(
          context: context,
          builder: (context) => AddTermBottomSheet(
            onAddTerm: (newTerm) async {
              await addTermUseCase.execute(
                  widget.termRepository.getAllTerms(), newTerm);
              setState(() {});
              Navigator.pop(context);
            },
          ),
        );
      },
      child: Text("Add More"),
    );
  }

  @override
  void dispose() {
    _speech.stop();
    super.dispose();
  }
}
