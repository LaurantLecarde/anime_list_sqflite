import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

showMySnackBar(String title,String message,Color color, ContentType contentType){
  return SnackBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    behavior: SnackBarBehavior.floating,
    content: AwesomeSnackbarContent(
      title: title,
      message: message,
      color: color,
      contentType: contentType,
    ),
  );
}