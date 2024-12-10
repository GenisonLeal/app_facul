import 'package:app_facul/domain/entities/contact.dart';
import 'package:app_facul/domain/interfaces/contact_dao.dart';
import 'package:sqflite/sqflite.dart';

import '../connection.dart';

class ContactDAOImpl implements ContactDAO{
  Database? _db; // Variável privada para armazenar a instância do banco de dados.

  @override
  Future<List<Contact>> find() async {
    _db = await  Connection.get();
    List<Map<String, dynamic>> resultado =  await _db!.query('contact'); // Consulta os contatos e mapeia para objetos Contact
    // Converte os resultados do banco para uma lista de objetos Contact.
    List<Contact> lista = List.generate( resultado.length, (i){
      var linha = resultado[i];
      return Contact(
        id : linha['id'],
        nome: linha['nome'],
        telefone: linha['telefone'],
        email: linha['email'],
        urlAvatar:  linha['url_avatar']
      );
    }
    );

    return lista;
  }

  @override
   // Remove contato pelo ID
  remove(int id) async {
    _db = await  Connection.get(); // Obtém a conexão com o banco.
    var sql ='DELETE FROM contact WHERE id = ?'; // Query SQL para remover um contato pelo ID.
    _db!.rawDelete(sql, [id]); // Executa a query.
    }
  
    @override
  save(Contact contact) async {
    _db = await  Connection.get();
    String sql;
    // Insere novo contato
    if(contact.id == null){
      sql = 'INSERT INTO contact (nome, telefone,email,url_avatar) VALUES (?,?,?,?)';
      _db!.rawInsert(sql,[contact.nome,contact.telefone,contact.email,contact.urlAvatar]);
    }else{
      sql = 'UPDATE contact SET nome = ?, telefone =?, email = ?, url_avatar= ? WHERE id = ?';
      _db!.rawUpdate(sql,[contact.nome, contact.telefone, contact.email, contact.urlAvatar, contact.id]); // Atualiza contato existente
    }
  }

}