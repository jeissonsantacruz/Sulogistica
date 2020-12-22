import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';    
import 'package:sulogistica/dominio/modeloOficinas_model.dart';
import 'package:sulogistica/dominio/modeloSecciones_model.dart';

import 'package:sulogistica/dominio/modeloCiudades_model.dart';
import 'dart:convert';

import 'package:sulogistica/preferenciasdeusario.dart';


final String urlBase = 'http://190.121.138.85/';

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
  final prefs =  PreferenciasUsuario();

  Future<List> buscarrUsuario(String codigo, String funcionphp)  async {
    var data = {
      "funcionphp": funcionphp,
      "idUsuario": codigo
    };
    var dio = Dio();
    final encodedData = FormData.fromMap(data);
    // make POST request
    Response response =
        await dio.post(url, data: encodedData);
     final decodeData = jsonDecode(response.data);
    

    var listaValores = decodeData['empresasValores'];
    var listaIndices = decodeData['empresasIndices'];
    var _resultadoValores = List<String>.from(listaValores);
    var _resultadoIndices = List<String>.from(listaIndices);
    prefs.empresasValores= _resultadoValores;
    prefs.empresasIndices= _resultadoIndices;
    if (decodeData['cuantasEmpresas']!= 1) {

      prefs.idCasa=decodeData['idCasa'];
    prefs.oidCasa= decodeData['oidEmpresa'];
    prefs.oidUsuario=decodeData['oidUsuario'];
     prefs.oidEmpresa= decodeData['empresasIndices'][0];
    tomarDatos();

    }
    return listaValores;
  }
  Future<Map<dynamic,dynamic>> tomarDatos()  async {
    var data = {
      "funcionphp": 'tomarDatos',
      "idCasa":prefs.oidCasa +","+ prefs.idBase,
      "idEmpresa":prefs.oidEmpresa ,
      "idUsuario":prefs.oidUsuario,
    };
    var dio = Dio();
    final encodedData = FormData.fromMap(data);
    // make POST request
    Response response =
        await dio.post(url, data: encodedData);
     final decodeData = jsonDecode(response.data);
      prefs.idBase= decodeData['baseTercero'];
      prefs.empresaTercero=decodeData['empresaTercero'];
      prefs.origenOfic= decodeData['origenOfic'];
      prefs.oidOficinaTercero= decodeData['origenOfic'];
      listarCiudades(); 
   return decodeData;

  }
final String url1 = urlBase + 'controladores/funcionesCiudadesCorreo.php';
List<Ciudades> _ciudades = new List();
Future<List<Ciudades>>listarCiudades()  async {
    var data = {
      "funcionphp": 'listarCiudades',
      "idEmpresa":prefs.oidEmpresa,
      "idBase":prefs.idBase,
    };
    var dio = Dio();
    final encodedData = FormData.fromMap(data);
    // make POST request
    Response response =
        await dio.post(url1, data: encodedData);
     final decodeData = jsonDecode(response.data);
     var listaCiudades = decodeData['listaCiudades'] as List;
_ciudades = listaCiudades.map((i) => Ciudades.fromJson(i)).toList();
    for (var item in decodeData['listaCiudades']) {
      if (item['ciudad']== prefs.idBase){
        prefs.ciudad= item['nombreciudad'];
        return _ciudades;
      }
      
    }
  return _ciudades;
  }
  
}