import 'package:flutter/material.dart';
import 'package:paakofinie_to_do_app/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paakofinie Todo',
      theme: ThemeData(
          primaryColor: const Color.fromRGBO(37, 43, 103, 1),
          appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromRGBO(37, 43, 103, 1), elevation: 0)),
      home: const HomeView(),
    );
  }
}
