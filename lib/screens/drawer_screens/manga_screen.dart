import 'package:flutter/material.dart';

class MangaScreen extends StatefulWidget {
  const MangaScreen({super.key});

  @override
  State<MangaScreen> createState() => _TvMoviesScreenState();
}

class _TvMoviesScreenState extends State<MangaScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Manga"),
      ),
    );
  }
}
