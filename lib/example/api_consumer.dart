import "dart:convert";
import "package:http/http.dart" as http;

class ApiConsumer {

  Future<List> get(String uf) async {
    var response = await http.get(Uri.parse('https://brasilapi.com.br/api/ibge/municipios/v1/$uf?providers=dados-abertos-br,gov,wikipedia'));
    try{
      return jsonDecode(response.body);
    } catch(e) {
      return [];
    }
  }

}