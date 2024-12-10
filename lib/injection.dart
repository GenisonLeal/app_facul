import 'package:app_facul/database/sqlite/dao/contact_dao_impl.dart';
import 'package:app_facul/domain/interfaces/contact_dao.dart';
import 'package:app_facul/domain/services/contact_service.dart';
import 'package:get_it/get_it.dart';

// Função para configurar a injeção de dependências
setupInjection(){
  GetIt getIt = GetIt.I;

  // Registra o ContactDAOImpl como a implementação concreta do ContactDAO
  getIt.registerSingleton<ContactDAO>(ContactDAOImpl());
  // Registra o ContactService como um singleton
  getIt.registerSingleton<ContactService>(ContactService());
}