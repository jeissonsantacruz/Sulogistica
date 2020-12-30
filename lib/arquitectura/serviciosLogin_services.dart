import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:sulogistica/preferenciasdeusario.dart';

final String urlBase = 'http://190.121.138.85/';

// Clase que contiene los servicios de la clase login
class ServiciosLogin {
  final String url = urlBase + 'funcionesLogin.php';
  final prefs = PreferenciasUsuario();

  final String urlLogin = urlBase + 'funcionesLogin.php';

  Future<Map<dynamic,dynamic>> iniciarSesion(
      String usuario,
      String clave,
      String cmbCasa,
      String cmbEmpresa,
      String cmbCiudad,
      String cmbOficina,
      String cmbSeccion) async {
    var datosForm={
        "usuario": usuario,
        "clave": clave,
        "cmbCasa": cmbCasa,
        "cmbEmpresa": cmbEmpresa,
        "cmbCiudad": cmbCiudad,
        "cmbOficina": cmbOficina,
        "cmbSeccion": cmbSeccion
      };
     
    var data = {
      "funcionphp": "iniciarSesion",
      "datosForm": json.encode(datosForm)
    };
    var dio = Dio();
    final encodedData = FormData.fromMap(data);
    // make POST request
    Response response = await dio.post(urlLogin, data: encodedData);
    final decodeData = jsonDecode(response.data);
    print(decodeData);

  
    return decodeData;
  }
}
