import 'package:app_facul/views/contact_form.dart';
import 'package:app_facul/views/contact_list.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  static const HOME = '/';
  static const CONTACT_FORM =  'contact-form';

  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
      HOME : (context) => ContactList(),
      CONTACT_FORM : (context) => ContactForm()
      },
    );
  }
}