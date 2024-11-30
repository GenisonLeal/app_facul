import 'package:app_facul/injection.dart';
import 'package:flutter/material.dart';
import 'package:app_facul/my_app.dart';

void main()  {
  setupInjection();
  runApp(const MyApp());
}