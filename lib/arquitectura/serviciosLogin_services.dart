import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:sulogistica/dominio/modeloEmpresas_model.dart';


final String urlBase = 'https://www.su-web.net/';

class SendDataProvider {
  final String url = urlBase + 'editInfoUser';

  Future<Map<String, dynamic>> sendData(
      int phone, String name, String email, String publi) async {
    Map<String, String> headers = {"Content-Type": "application/json"};
    var data = {
      "phone": phone,
      "name": name,
      "email": email,
      "publicityMethod": publi
    };
    final encodedData = json.encode(data);

    // make POST request
    http.Response response =
        await http.put(url, headers: headers, body: encodedData);
    final decodeData = jsonDecode(response.body);

    return decodeData;
  }
}

class ServiciosLogin {
  final String url = urlBase + 'funcionesLogin.php';
  
  List<ListaEmpresas> _resultado = new List();

  Future<List<ListaEmpresas>> buscarrUsuario(String codigo)  async {
    Map<String, String> headers = {"Content-Type": "application/json"};
    var data = {
      "funcionphp": "buscarUsuario",
      "idUsuario": codigo
    };
    final encodedData = json.encode(data);
    // make POST request
    http.Response response =
        await http.post(url, headers: headers, body: encodedData);
     final decodeData = jsonDecode(response.body);
    var list = decodeData['content'] as List;
    _resultado = list.map((i) => ListaEmpresas.fromJson(i)).toList();
    return _resultado;
  }
}