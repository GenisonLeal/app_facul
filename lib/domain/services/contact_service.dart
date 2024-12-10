import 'package:app_facul/domain/entities/contact.dart';
import 'package:app_facul/domain/exception/domain_layer_exception.dart';
import 'package:app_facul/domain/interfaces/contact_dao.dart';
import 'package:get_it/get_it.dart';

class ContactService{
 final _dao = GetIt.I.get<ContactDAO>();
 // Salva ou atualiza um contato após validações.
save(Contact contact){
  validateName(contact.nome);
  validateEmail(contact.email);
  validatePhone(contact.telefone);
  _dao.save(contact);
}
// Remove um contato pelo ID.
remove(int id){
  _dao.remove(id);
}
// Retorna a lista de contatos.
Future<List<Contact>> find(){
  return _dao.find();
}
// nome → seja obrigatório, tenha no mínimo 3 caracteres e no máximo 50 
validateName(String name){
  var min = 3; 
  var max = 50; 

  if(name.length < min){
  throw DomainLayerException('O nome deve possuir pelo menos $min caracteres.');
}else if(name.length > max){
  throw DomainLayerException('O nome deve possuir no máximo $max caracteres.');
}
}
// e-mail → seja obrigatório e tenha @ 
validateEmail(String email){
  if(!email.contains('@')){
  throw DomainLayerException('O e-mail deve possuir @.');
}
}
// telefone → seja obrigatório e tenha o formato (99) 9 9999-9999 
validatePhone(String phone){
  var format = RegExp(r'^\([1-9]{2}\) [9] [6-9]{1}[0-9]{3}\-[0-9]{4}$'); // (99) 9 9999-9999
  if(!format.hasMatch(phone)){
  throw DomainLayerException('Formato inválido. O formato deve ser (99) 9 9999-9999.');
}
}


}