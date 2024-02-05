import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void navigator(BuildContext context, Widget to) {
  Navigator.of(context).push(CupertinoPageRoute(builder: (context) => to));
}
void popNavigator(BuildContext context){
  Navigator.of(context).pop();
}
void snackbarScaffold(BuildContext context,SnackBar snackBar){
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}