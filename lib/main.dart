import 'package:flutter/material.dart';
import 'package:flutter_assignment/list/data/term_respository.dart';
import 'package:flutter_assignment/list/presentation/views/Homepage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  final TermRepository termRepository = TermRepository();

  runApp(MyApp(termRepository: termRepository));
}

class MyApp extends StatelessWidget {
  final TermRepository termRepository;

  const MyApp({Key? key, required this.termRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black54),
          useMaterial3: false,
        ),
        home: Homepage(termRepository: termRepository),
      ),
    );
  }
}
