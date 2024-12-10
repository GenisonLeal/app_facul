import 'package:app_facul/domain/entities/contact.dart';

abstract class ContactDAO{

  save(Contact contact); // Salva ou atualiza um contato.

  remove(int id); // Remove um contato pelo ID.

  Future<List<Contact>> find(); // Retorna uma lista de contatos.

}