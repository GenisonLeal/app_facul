import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:app_facul/views/contact_form_back.dart';

class ContactForm extends StatelessWidget {
  final _form = GlobalKey<FormState>();

  ContactForm({super.key});

  // Campo para o nome do contato
  Widget fieldName(ContactFormBack back) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 16.0), // Espaçamento entre os campos
      child: TextFormField(
        validator: back.validateName, // Validação do nome
        onSaved: (newValue) {
          // Atribui o valor de 'newValue' ao 'back.contact.nome', mas de forma segura
          if (newValue != null) {
            back.contact.nome = newValue;
          }
        },
        initialValue:
            back.contact.nome, // Usa o valor inicial do 'contact.nome'
        // Decoração do campo de texto
        decoration: const InputDecoration(
            labelText: 'Nome:',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.person)),
      ),
    );
  }

  // Campo para o e-mail do contato
  Widget fieldEmail(ContactFormBack back) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 16.0), // Espaçamento entre os campos
    child: TextFormField(
        validator:
            back.validateEmail, // Validação do e-mail
        onSaved: (newValue) => back.contact.email =
            newValue!, // Atribui o valor de 'newValue' ao 'back.contact.nome', mas de forma segura
        initialValue:
            back.contact.email, // Usa o valor inicial do 'contact.email'
        // Decoração do campo de texto
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.email),
            labelText: 'E-mail:'),
    ),
    );
  }

  // Campo para o telefone do contato com máscara
  Widget fieldPhone(ContactFormBack back) {
    var mask = MaskTextInputFormatter(mask: '(##) # ####-####');
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 16.0), // Espaçamento entre os campos
    child: TextFormField(
        validator: back.validatePhone, // Validação do telefone
        onSaved: (newValue) => back.contact.telefone = newValue!,
        initialValue: back.contact.telefone,
        inputFormatters: [mask], // Aplica a máscara ao campo
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.phone),
            labelText: 'Telefone:',
            hintText: '(99) 9 9999-9999'),
    ),
    );
  }

  // Campo para o URL da imagem do contato
  Widget fieldURLImage(ContactFormBack back) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 16.0), // Espaçamento entre os campos
    child:TextFormField(
        onSaved: (newValue) => back.contact.urlAvatar = newValue!,
        initialValue: back.contact.urlAvatar,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.image),
            labelText: 'Endereço Foto:',
            hintText: 'http://www.site.com'),
    ),
    );
  }
  
  // Botão para salvar o contato
  Widget saveButton(BuildContext context, ContactFormBack back) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: ElevatedButton(
        onPressed: () {
          _form.currentState!.validate();
          _form.currentState!.save();
          if (back.isValid) {
            back.save();
            Navigator.of(context).pop(); // Fecha a tela de cadastro
          }
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: const Color(0xFF3A9E9F), // Cor do texto e ícone
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Bordas arredondadas
          ),
          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 30.0),
          elevation: 5, // Sombra
        ),
        child: const Text(
          'Salvar',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var back = ContactFormBack(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cadastro de Contato',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF3A9E9F),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              fieldName(back),
              fieldEmail(back),
              fieldPhone(back),
              fieldURLImage(back),
              saveButton(context, back), // Exibe o botão de salvar
            ],
          ),
        ),
      ),
    );
  }
}
