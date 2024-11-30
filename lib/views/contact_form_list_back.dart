import 'package:app_facul/domain/entities/contact.dart';
import 'package:app_facul/domain/services/contact_service.dart';
import 'package:app_facul/my_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

part 'contact_form_list_back.g.dart';

// ignore: library_private_types_in_public_api
class ContactListBack = _ContactListBack with _$ContactListBack;

abstract class _ContactListBack with Store {
  // ignore: prefer_final_fields
  var _service = GetIt.I.get<ContactService>();

  //lista de contatos
  @observable
  Future<List<Contact>> list = Future.value([]);

  //método para atualizar a lista de contatos
  @action
  refreshList([dynamic value]) {
    list = _service.find();
  }

  _ContactListBack() {
    refreshList();
  }

  //método para chamar o form salvar/alterar
  goToForm(BuildContext context, [Contact? contact]) {
    Navigator.of(context)
        .pushNamed(MyApp.CONTACT_FORM, arguments: contact)
        .then(refreshList);
  }

  //excluir
  remove(int id) {
    _service.remove(id);
    refreshList();
  }
}
