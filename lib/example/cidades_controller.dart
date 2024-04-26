import 'package:tiede_builder_pkg/tiede_builder_pkg.dart';
import 'api_consumer.dart';

class Cidades extends TiedeNotify{

  List cidades = [];
  String uf = 'MG';

  getCidades({String uf = 'MG'}) async {
    this.uf = uf;
    cidades.clear();
    notify(isLoading: true);

    ApiConsumer().get(uf).then((value) {
      cidades = value;
      print('get ok');
      notify();
    });
  }

}