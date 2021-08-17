import 'package:connectivity/connectivity.dart';


//classe de teste conexão
class Conexao {
  teste() async {
    final hasconection = await Connectivity().checkConnectivity();
    final message = 'teste conexao ok';


  }
}
