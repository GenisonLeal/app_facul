import 'package:app_facul/domain/entities/contact.dart';
import 'package:app_facul/domain/services/contact_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

part 'contact_form_back.g.dart';

class ContactFormBack = _ContactFormBack with _$ContactFormBack;

abstract class _ContactFormBack with Store{
  late Contact contact;
  final _service = GetIt.I.get<ContactService>();
  bool _nameIsValid = false; 
  bool _emailIsValid = false; 
  bool _phoneIsValid = false; 

  @action
  bool get isValid => _nameIsValid && _emailIsValid && _phoneIsValid;
  
  // Identifica se é um novo contato ou alteração.
  _ContactFormBack(BuildContext context){
    var parameter = ModalRoute.of(context)!.settings.arguments;
    contact = (parameter == null) 
    ? Contact(nome: '', telefone: '', email: '', urlAvatar: '') 
    : parameter as Contact;
  }

   // Salvar o contato. 
  save() async {
    await _service.save(contact);
  }

  //validações  
  String? validateName(String? name){
    try{
      _service.validateName(name!);  // Chama o serviço para validar o nome
      _nameIsValid = true;
      return null; 
    }catch(e){
      _nameIsValid = false;
      return e.toString();  // Retorna a mensagem de erro se ocorrer uma exceção
    }
  }
  
  String? validateEmail(String? email){
    try{
      _service.validateEmail(email!);
      _emailIsValid = true;
      return null;
    }catch(e){
      _emailIsValid = false;
      return e.toString();
    }
  }
  
  String? validatePhone(String? phone){
    try{
      _service.validatePhone(phone!);
      _phoneIsValid = true;
      return null;
    }catch(e){
      _phoneIsValid = false;
      return e.toString();
    }
  }


}