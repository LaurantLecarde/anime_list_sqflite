import 'package:anime_list_sqflite/widgets/my_snackbars.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class FinishedScreen extends StatefulWidget {
  const FinishedScreen({super.key});

  @override
  State<FinishedScreen> createState() => _WatchingScreenState();
}

class _WatchingScreenState extends State<FinishedScreen> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Text("Finished")),
    );
  }
}
