import 'package:flutter/material.dart';

class TvMoviesScreen extends StatefulWidget {
  const TvMoviesScreen({super.key});

  @override
  State<TvMoviesScreen> createState() => _TvMoviesScreenState();
}

class _TvMoviesScreenState extends State<TvMoviesScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("TvMovies"),
      ),
    );
  }
}
