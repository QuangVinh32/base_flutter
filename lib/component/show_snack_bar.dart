import 'package:flutter/material.dart';
import 'package:shop_food_app/component/label.dart';

void showSnackBar(BuildContext context,
    {Widget? child, String? msg, int? delay}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  final snackBar = SnackBar(
    content: child ?? Label(msg ?? "", color: Colors.white),
    duration: Duration(milliseconds: delay ?? 1000),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showErrorSnackBar(BuildContext context,
    {Widget? child, String? msg, int? delay}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  final snackBar = SnackBar(
    backgroundColor: Colors.red,
    content: child ?? Label(msg ?? "", color: Colors.white),
    duration: Duration(milliseconds: delay ?? 1000),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showSuccessSnackBar(BuildContext context,
    {Widget? child, String? msg, int? delay}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  final snackBar = SnackBar(
    backgroundColor: Colors.green,
    content: child ?? Label(msg ?? "", color: Colors.white),
    duration: Duration(milliseconds: delay ?? 1000),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}