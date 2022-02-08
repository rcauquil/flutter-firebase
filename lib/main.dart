import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foobar/services/redirection.dart';

final ThemeData theme = ThemeData();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Foo Bar",
      debugShowCheckedModeBanner: false,
      home: RedirectionService().builder,
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
    );
  }
}
