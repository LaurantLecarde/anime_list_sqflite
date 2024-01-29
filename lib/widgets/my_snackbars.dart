import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

final mySaveSnackBar = SnackBar(
  elevation: 0,
  behavior: SnackBarBehavior.floating,
  backgroundColor: Colors.transparent,
  content: AwesomeSnackbarContent(
    color: Colors.green,
    title: 'Good',
    message:
    'Your anime has been saved ✅',
    contentType: ContentType.success,
  ),
);

final myFailureSnackBar = SnackBar(
  elevation: 0,
  behavior: SnackBarBehavior.floating,
  backgroundColor: Colors.transparent,
  content: AwesomeSnackbarContent(
    title: 'OOPS..',
    message:
    'You made some mistake(s) ❌',
    contentType: ContentType.failure,
  ),
);

final myHelpSnackBar = SnackBar(
  elevation: 0,
  behavior: SnackBarBehavior.floating,
  backgroundColor: Colors.transparent,
  content: AwesomeSnackbarContent(
    title: 'Help!',
    message:
     "That's our help 🆘",
    contentType: ContentType.help,
  ),
);

final myWarningSnackBar = SnackBar(
  elevation: 0,
  behavior: SnackBarBehavior.floating,
  backgroundColor: Colors.transparent,
  content: AwesomeSnackbarContent(
    title: 'Warning!',
    message:
    'Be careful... Next time try not to make any mistake ‼️',
    contentType: ContentType.warning,
  ),
);