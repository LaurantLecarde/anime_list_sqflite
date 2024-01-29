import 'package:flutter/material.dart';

class WatchingScreen extends StatefulWidget {
  const WatchingScreen({super.key});

  @override
  State<WatchingScreen> createState() => _WatchingScreenState();
}

class _WatchingScreenState extends State<WatchingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Watch"),),
    );
  }
}
