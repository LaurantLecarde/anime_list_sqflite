import 'package:flutter/cupertino.dart';

void navigator(BuildContext context, Widget to) {
  Navigator.of(context).push(CupertinoPageRoute(builder: (context) => to));
}
void popNavigator(BuildContext context){
  Navigator.of(context).pop();
}