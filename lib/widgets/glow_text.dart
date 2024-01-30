
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  const AppText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return GlowText(
      text,
      style: GoogleFonts.rowdies(
          fontSize: 16,
          color: Colors.white70
      ),
    );
  }
}