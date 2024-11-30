import 'package:app_facul/database/sqlite/dao/contact_dao_impl.dart';
import 'package:app_facul/domain/interfaces/contact_dao.dart';
import 'package:app_facul/domain/services/contact_service.dart';
import 'package:get_it/get_it.dart';


setupInjection(){
  GetIt getIt = GetIt.I;

  getIt.registerSingleton<ContactDAO>(ContactDAOImpl());
  getIt.registerSingleton<ContactService>(ContactService());
}