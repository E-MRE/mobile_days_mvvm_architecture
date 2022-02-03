import 'package:flutter/material.dart';
import 'package:mobile_days_mvvm_architecture/presentation/screens/anime/view/anime_search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: AnimeSearchScreen(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      ),
    );
  }
}
