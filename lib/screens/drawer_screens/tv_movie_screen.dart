import 'package:flutter/material.dart';

class TvMoviesScreen extends StatefulWidget {
  const TvMoviesScreen({super.key});

  @override
  State<TvMoviesScreen> createState() => _TvMoviesScreenState();
}

class _TvMoviesScreenState extends State<TvMoviesScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Text("TvMovies"),
      ),
    );
  }
}
