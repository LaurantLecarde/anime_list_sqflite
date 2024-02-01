import 'package:anime_list_sqflite/screens/exe_screens/show_dialog.dart';
import 'package:anime_list_sqflite/widgets/drawer_hidden.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        primaryColor: Colors.black,
        canvasColor: Colors.blue,
        primaryColorLight: Colors.yellowAccent,
        useMaterial3: true,
      ),
      home: const MyHiddenDrawer(),
    );
  }
}
