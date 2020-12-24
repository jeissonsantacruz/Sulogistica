import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sulogistica/aplicacion/provider/providerUsuario_prrovider.dart';
import 'package:sulogistica/dominio/modeloCiudades_model.dart';
import 'package:sulogistica/dominio/modeloEmpresas_model.dart';

import '../../preferenciasdeusario.dart';



class LoginPagina extends StatefulWidget {
  @override
  _LoginPaginaState createState() => _LoginPaginaState();
}

class _LoginPaginaState extends State<LoginPagina> {
  @override
  void initState() {
    buscarUsuario();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     final userInfo = Provider.of<InformacionUsuario>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic DropDownList REST API'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(bottom: 100, top: 100),
            child: Text(
              'KDTechs',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
            ),
          ),
          //======================================================== State

          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 5),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        value: _myState,
                        iconSize: 30,
                        icon: (null),
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                        hint: userInfo.empresasValores[0]==null?Text('${userInfo.empresa}'):Text('${userInfo.empresasValores[0].valor.toString()}'),
                        onChanged: (String newValue) {
                          setState(() {
                            _myState = newValue;
                            print(_myState);
                            listarCiudades();

                          });
                        },
                        items: statesList?.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item.name),
                                value: item.valor.toString(),
                              );
                            })?.toList() ??
                            [],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),

          //======================================================== City

          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 5),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        value: _myCity,
                        iconSize: 30,
                        icon: (null),
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                        hint: Text('${userInfo.ciudad}'),
                        onChanged: (String newValue) {
                          setState(() {
                            _myCity = newValue;
                            print(_myCity);
                          });
                        },
                        items: citiesList?.map((item) {
                              return new DropdownMenuItem(
                               child: new Text(item.name),
                                value: item.valor.toString(),
                              );
                            })?.toList() ??
                            [],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //=============================================================================== Api Calling here

//CALLING STATE API HERE
// Get State information by API
  List statesList;
  String _myState;
  
  String stateInfoUrl = 'http://cleanions.bestweb.my/api/location/get_state';
  Future<String> _getStateList() async {
    await http.post(stateInfoUrl, headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    }, body: {
      "api_key": '25d55ad283aa400af464c76d713c07ad',
    }).then((response) {
      var data = json.decode(response.body);

//      print(data);
      setState(() {
        statesList = data['state'];
      });
    });
  }
  
  final String url = 'http://190.121.138.85/' + 'funcionesLogin.php';
  final prefs = PreferenciasUsuario();

  Future<int> buscarUsuario() async {
    // final userInfo = Provider.of<InformacionUsuario>(context);
    var data = {"funcionphp": 'buscarUsuario', "idUsuario": 16773145};
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
    List<Company> _resultado = [];
    
    
  
    setState(() {
        statesList = _llenarCompa(
          prefs.empresasValores, prefs.empresasIndices,null,_resultado);
          //  userInfo.empresa = _resultadoValores[0];
          tomarDatos();
      });
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
    prefs.empresaTercero = decodeData['empresaTercero'];
    prefs.idSeccion = decodeData['oidSeccion'];
    prefs.oidOficinaTercero = decodeData['oidOficinaTercero'];
print(decodeData);
    return decodeData;
  }
   final String url1 = 'http://190.121.138.85/' + 'controladores/funcionesCiudadesCorreo.php';
  List<Ciudades> _ciudades = new List();
  Future<List<Ciudades>> listarCiudades() async {
    var data = {
      "funcionphp": 'listarCiudades',
      "idEmpresa": prefs.empresaTercero,
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

    
    setState(() {
       List<Company> _resultado = [];
    
        citiesList = _llenarCompa(
                    prefs.ciuadadesIndices, prefs.ciudadesValores,prefs.idBase,_resultado);
                    
        
      });

  }

  // Get State information by API
  List citiesList;
  String _myCity;

  String cityInfoUrl =
      'http://cleanions.bestweb.my/api/location/get_city_by_state_id';
  Future<String> _getCitiesList() async {
    await http.post(cityInfoUrl, headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    }, body: {
      "api_key": '25d55ad283aa400af464c76d713c07ad',
      "state_id": _myState,
    }).then((response) {
      var data = json.decode(response.body);

      setState(() {
        citiesList = data['cities'];
      });
    });
  }

   _llenarCompa(prefValores, prefIndices,seleccion,_resultado) {
     final userInfo = Provider.of<InformacionUsuario>(context);
    var cont = 0;
    
    for (var item in prefValores) {
      
      _resultado.add(Company(item, prefIndices[cont]));
      cont++;
    }
    if (seleccion != null){
    for (var item in _resultado) {
     if(item.valor == seleccion){
        _resultado.insert(0, item);
      
        userInfo.ciudad=item.name;
        return _resultado.toSet().toList();
     }
      
    }
    }else{
      return _resultado;
    }
    
  }
}
