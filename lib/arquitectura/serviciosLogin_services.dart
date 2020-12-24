import 'package:dio/dio.dart';
import 'package:sulogistica/dominio/modeloOficinas_model.dart';

import 'package:sulogistica/dominio/modeloCiudades_model.dart';
import 'dart:convert';

import 'package:sulogistica/preferenciasdeusario.dart';

final String urlBase = 'http://190.121.138.85/';


class ServiciosLogin {
  final String url = urlBase + 'funcionesLogin.php';
  final prefs = PreferenciasUsuario();

  Future<int> buscarUsuario(String codigo, String funcionphp) async {
    var data = {"funcionphp": funcionphp, "idUsuario": codigo};
    var dio = Dio();
    final encodedData = FormData.fromMap(data);
    // make POST request
    Response response = await dio.post(url, data: encodedData);

    final decodeData = jsonDecode(response.data);

    var listaValores = decodeData['empresasValores'];
    var listaIndices = decodeData['empresasIndices'];

    var _resultadoValores = List<String>.from(listaValores);
    var _resultadoIndices = List<String>.from(listaIndices);

    prefs.empresasValores = _resultadoValores;
    prefs.empresasIndices = _resultadoIndices;
    if (decodeData['cuantasEmpresas'] == 1) {

      prefs.idCasa = decodeData['idCasa'];
      prefs.oidCasa = decodeData['oidCasa'];
      prefs.oidUsuario = decodeData['oidUsuario'];
      prefs.oidEmpresa = decodeData['idEmpresa'];
      print(decodeData);
      return 1;
      
    }
    
    return 0;
    
  }

  Future<Map<dynamic, dynamic>> tomarDatos() async {
    var data = {
    "funcionphp": 'tomarDatos',
      "idCasa":"800157847,38190",
      "idEmpresa": "38190",
      "idUsuario":"66778",
      "origen" :0
    };
    var dio = Dio();
    final encodedData = FormData.fromMap(data);
    // make POST request
    Response response = await dio.post(url, data: encodedData);
    final decodeData = jsonDecode(response.data);

    prefs.idBase = decodeData['baseTercero'];
    prefs.empresaTercero = decodeData['oidEmpresaTercero'];
    prefs.idSeccion = decodeData['oidSeccion'];
    prefs.oidOficinaTercero = decodeData['oidOficinaTercero'];
print(decodeData);
    return decodeData;
  }

  final String url1 = urlBase + 'controladores/funcionesCiudadesCorreo.php';
  List<Ciudades> _ciudades = new List();
  Future<List<Ciudades>> listarCiudades() async {
    var data = {
      "funcionphp": 'listarCiudades',
      "idEmpresa": prefs.oidEmpresa,
      "idBase": prefs.idBase,
    };
    var dio = Dio();
    final encodedData = FormData.fromMap(data);
    // make POST request
    Response response = await dio.post(url1, data: encodedData);
    final decodeData = jsonDecode(response.data);

    var listaValores = decodeData['ciudadesIndices'];
    var listaIndices = decodeData['ciudadesValores'];

    var _resultadoValores = List<String>.from(listaValores);
    var _resultadoIndices = List<String>.from(listaIndices);

    prefs.ciudadesValores = _resultadoValores;
    prefs.ciuadadesIndices = _resultadoIndices;

    
    return _ciudades;
  }
   final String urlOficinas = urlBase + 'controladores/funcionesOficinas.php';
  List<Oficinas> _oficinas = new List();
  Future<List<Oficinas>> listarOficinas() async {
    var data = {
      "funcionphp": 'listarOficinas',
      "oidEmpresa": prefs.empresaTercero,
      "idCiudad": prefs.idBase,
      "idOficina":prefs.oidOficinaTercero,
      "tipoRetorno":2
    };
    var dio = Dio();
    final encodedData = FormData.fromMap(data);
    // make POST request
    Response response = await dio.post(urlOficinas, data: encodedData);
    final decodeData = jsonDecode(response.data);

    var listaValores = decodeData['oficinasValores'];
    var listaIndices = decodeData['oficinasIndices'];

    var _resultadoValores = List<String>.from(listaValores);
    var _resultadoIndices = List<String>.from(listaIndices);

    prefs.oficinasValores = _resultadoValores;
    prefs.oficinasIndices = _resultadoIndices;

    
    return _oficinas;
  }

   final String urlSecciones = urlBase + 'funcionesLogin.php';
  
  Future<List<Oficinas>> listarSecciones() async {
    var data = {
      "funcionphp": 'listarSecciones',
      "oidOficina":prefs.oidOficinaTercero,
      "idSeccion":prefs.idSeccion
    };
    var dio = Dio();
    final encodedData = FormData.fromMap(data);
    // make POST request
    Response response = await dio.post(urlSecciones, data: encodedData);
    final decodeData = jsonDecode(response.data);

    var listaValores = decodeData['seccionesIndices'];
    var listaIndices = decodeData['seccionesValores'];

    var _resultadoValores = List<String>.from(listaValores);
    var _resultadoIndices = List<String>.from(listaIndices);

    prefs.seccionesValores = _resultadoValores;
    prefs.seccionesIndices = _resultadoIndices;
    
    
    return _oficinas;
  }
}
