// ignore_for_file: prefer_const_constructors

import 'package:app_facul/domain/entities/contact.dart';
import 'package:app_facul/views/contact_form_list_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ContactList extends StatelessWidget {
  final _back = ContactListBack();

  ContactList({super.key});

  CircleAvatar circleAvatar(String url) {
    return (Uri.tryParse(url)!.isAbsolute)
        ? CircleAvatar(backgroundImage: NetworkImage(url))
        : const CircleAvatar(child: Icon(Icons.person));
  }

  Widget iconEditButton(VoidCallback onPressed) {
    return IconButton(
      icon: const Icon(Icons.edit),
      color: const Color.fromARGB(255, 138, 137, 137),
      onPressed: onPressed,
    );
  }

  Widget iconRemoveButton(BuildContext context, Function remove) {
    return IconButton(
        icon: const Icon(Icons.delete),
        color: Colors.red,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text('Excluir'),
                    content: const Text('Confirma a Exclusão?'),
                    actions: [
                      TextButton(
                        child: const Text('Não'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Sim'),
                        onPressed: () async {
                          try {
                            await remove(); // Chama a função de remoção
                            Navigator.of(context)
                                .pop(); // Fecha o dialog após a remoção
                          } catch (e) {
                            // Exibe um erro caso ocorra uma exceção
                            print('Erro ao remover o contato: $e');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Erro ao remover o contato: $e'),
                              ),
                            );
                            Navigator.of(context)
                                .pop(); // Fecha o dialog mesmo se houver erro
                          }
                        },
                      ),
                    ],
                  ));
        });
  }

  // Função para exibir os detalhes do contato
  void _showContactDetails(BuildContext context, Contact contato) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(contato.nome),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Telefone: ${contato.telefone}"),
              Text("E-mail: ${contato.email}"),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Contatos',style: TextStyle(fontWeight: FontWeight.w600)),
          backgroundColor: const Color(0xFF3A9E9F),
          elevation: 4.0, // Adiciona uma leve sombra à AppBar
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
            child: ElevatedButton(onPressed: () {
                _back.goToForm(context);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 255, 255, 255), backgroundColor: Color.fromARGB(255, 255, 255, 255), // Cor do ícone do botão
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0), // Bordas arredondadas
                ),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                elevation: 5, // Sombra
              ),
              child: Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Icon(Icons.add, color: Color(0xFF3A9E9F)), // Ícone de adicionar
                  const SizedBox(width: 5),
                  const Text(
                    'Adicionar',
                    style: TextStyle(color: Color(0xFF3A9E9F), fontWeight: FontWeight.bold),
                ),
                ],
              ),
            ),
          ),
        ],
      ),
        body:  Padding(
        padding: const EdgeInsets.all(16.0), // Padding geral
        child: Observer(builder: (context) {
          return FutureBuilder(
              future: _back.list,
              builder: (context, futuro) {
                if (!futuro.hasData) {
                  return const CircularProgressIndicator();
                } else {
                  List<Contact>? lista = futuro.data;
                  return ListView.builder(
                    itemCount: lista!.length,
                    itemBuilder: (context, i) {
                      var contato = lista[i];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        elevation: 3.0, // Sombra no card
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                       child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                        leading: GestureDetector(
                          onTap: () {
                            _showContactDetails(context,
                                contato); // Exibe os dados ao clicar na foto
                          },
                          child: circleAvatar(contato.urlAvatar),
                        ),
                        title: GestureDetector(
                          onTap: () {
                            _showContactDetails(context,
                                contato); // Exibe os dados ao clicar no nome
                          },
                          child: Text(contato.nome,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                          
                        ),
                        subtitle: GestureDetector(
                          onTap: () {
                            _showContactDetails(context,
                                contato); // Exibe os dados ao clicar no telefone
                          },
                          child: Text(contato.telefone,
                          style: TextStyle(color: Colors.grey[600], fontSize: 14.0),
                          ),
                        ),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              iconEditButton(() {
                                _back.goToForm(context, contato);
                              }),
                              iconRemoveButton(context, () {
                                if (contato.id != null) {
                                  _back.remove(contato.id!);
                                } else {
                                  // Caso o id seja nulo, exibir um alerta ou tomar uma ação alternativa
                                  print('Erro: O id do contato é nulo.');
                                }
                              }),
                            ],
                          ),
                        ),
                       ),
                      );
                    },
                  );
                }
              });
        }),
    ),
    );
  }
}
