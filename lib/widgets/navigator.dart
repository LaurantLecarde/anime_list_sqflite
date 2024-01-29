import 'package:flutter/cupertino.dart';

void navigator(BuildContext context, Widget to) {
  Navigator.of(context).push(CupertinoPageRoute(builder: (context) => to));
}