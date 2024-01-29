import 'package:flutter/material.dart';

class FinishedScreen extends StatefulWidget {
  const FinishedScreen({super.key});

  @override
  State<FinishedScreen> createState() => _WatchingScreenState();
}

class _WatchingScreenState extends State<FinishedScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Finish"),),
    );
  }
}
