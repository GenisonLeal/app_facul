import 'package:app_facul/views/contact_form.dart';
import 'package:app_facul/views/contact_list.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  // Definindo as rotas nomeadas para navegação
  static const HOME = '/';
  static const CONTACT_FORM =  'contact-form';

  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo', // Definindo o título do aplicativo
      theme: ThemeData(
        primarySwatch: Colors.blue, // Definindo o tema do aplicativo (cor principal)
      ),
      routes: {
      HOME : (context) => ContactList(), // Rota para a tela de lista de contatos
      CONTACT_FORM : (context) => ContactForm() // Rota para o formulário de contato
      },
    );
  }
}