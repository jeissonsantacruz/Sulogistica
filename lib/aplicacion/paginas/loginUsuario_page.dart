import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sulogistica/aplicacion/provider/providerUsuario_prrovider.dart';
import 'package:sulogistica/aplicacion/widgets/recuperContrasena_widget.dart';
import 'package:sulogistica/dominio/modeloCiudades_model.dart';
import 'package:sulogistica/dominio/modeloEmpresas_model.dart';
import 'package:sulogistica/dominio/modeloOficinas_model.dart';

import '../../preferenciasdeusario.dart';

class LoginPagina extends StatefulWidget {
  @override
  _LoginPaginaState createState() => _LoginPaginaState();
}

class _LoginPaginaState extends State<LoginPagina> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController codigoController = new TextEditingController();
  TextEditingController contraController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<InformacionUsuario>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100, left: 30, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(bottom: 100, top: 100),
                child: _loginImagen(context),
              ),
              //======================================================== State
              TextFormField(
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Código',
                    fillColor: Colors.white,
                    labelStyle: new TextStyle(color: Colors.white)),
                controller: codigoController,
                onEditingComplete: buscarUsuario,
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          elevation: 0,
                          focusColor: Colors.greenAccent,
                          value: _myState,
                          style: TextStyle(
                              color: const Color(0xFF0A2140), fontSize: 16),
                          hint: Text(
                            '${userInfo.empresa}',
                            style: TextStyle(color: Color(0xFF0A2140)),
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              _myState = newValue;
                              print(_myState);

                              tomarDatos(prefs.idCasa + ',' + prefs.oidCasa);
                              listarCiudades().whenComplete(() {
                                listarOficinas().whenComplete(() {
                                  listarSecciones();
                                });
                              });
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
                  ],
                ),
              ),

              //======================================================== City
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          child: DropdownButton<String>(
                            value: _myCity,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                            hint: Text(
                              '${userInfo.ciudad}',
                              style: TextStyle(color: Color(0xFF0A2140)),
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                _myCity = newValue;
                                print(_myCity);
                                listarOficinas();
                                listarSecciones();
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
              Container(
                 padding: EdgeInsets.only(top: 5),
                  color: Colors.white,
                  child: DropdownButtonHideUnderline(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 48.0),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: _myOficina,
                        style: TextStyle(
                          color: Color(0xFF0A2140),
                          fontSize: 16,
                        ),
                        hint: Text(
                          '${userInfo.oficina}',
                          style: TextStyle(color: Color(0xFF0A2140)),
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            _myOficina = newValue;
                            print(_myOficina);
                            listarSecciones();
                          });
                        },
                        items: oficinaList?.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item.name),
                                value: item.valor.toString(),
                              );
                            })?.toList() ??
                            [],
                      ),
                    ),
                  )),
              Container(
               padding: EdgeInsets.only(top: 5),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: false,
                          child: DropdownButton<String>(
                            value: _mySeccion,
                            iconSize: 30,
                            icon: (null),
                            style: TextStyle(
                              color: Color(0xFF0A2140),
                              fontSize: 16,
                            ),
                            hint: Text(
                              '${userInfo.seccion}',
                              style: TextStyle(color: Color(0xFF0A2140)),
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                _mySeccion = newValue;
                                print(_mySeccion);
                              });
                            },
                            items: seccionesList?.map((item) {
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
              MyCustomCard(
                widgets: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Contraseña',
                        
                        labelStyle:
                            new TextStyle(color: const Color(0xFF0A2140),fontSize: 16)),
                    controller: contraController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                      child: new Text('¿Olvidaste tú contraseña?',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          )),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RecuperarContrasena()));
                      }),
                ],
              ),
              SizedBox(height: 20),
              // boton para iniciar sesion
              Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(
                      bottom: size.height * 0.04, left: 30, right: 30, top: 15),
                  child: RaisedButton(
                      elevation: 5.0,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                      ),
                      padding: EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: BoxDecoration(
                            color: Color(0xFF0A2140),
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(
                              size.width * 0.1,
                              size.height * 0.005,
                              size.width * 0.1,
                              size.height * 0.005),
                          child: ListTile(
                              leading: Icon(
                                FontAwesomeIcons.signInAlt,
                                color: Colors.white,
                              ),
                              title: Text("Iniciar sesión",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600))),
                        ),
                      ),
                      onPressed: () {

                        prefs.logeado = true;
                      })),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginImagen(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.05,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/suweb.png'),
          ),
        ));
  }

  //=============================================================================== Api Calling here

//CALLING STATE API HERE
// Get State information by API
  List statesList;
  List oficinaList;
  List seccionesList;
  String _mySeccion;
  String _myOficina;
  String _myState;

  final String url = 'http://190.121.138.85/' + 'funcionesLogin.php';
  final prefs = PreferenciasUsuario();

  Future<int> buscarUsuario() async {
    var data = {
      "funcionphp": 'buscarUsuario',
      "idUsuario": codigoController.text
    };
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
    prefs.idCasa = decodeData['idCasa'];
    prefs.oidCasa = decodeData['oidCasa'];
    prefs.oidUsuario = decodeData['oidUsuario'];

    if (decodeData['cuantasEmpresas'] == 1) {
      print(decodeData);

      setState(() {
        List<Company> _resultado = [];
        _myState = prefs.empresasIndices[0];
        statesList = _llenarCompa(prefs.empresasValores, prefs.empresasIndices,
            null, _resultado, 'empresas');
        tomarDatos(prefs.oidCasa);
        listarCiudades().whenComplete(() {
          listarOficinas().whenComplete(() {
            listarSecciones();
          });
        });
      });

      return 1;
    }
    List<Company> _resultado = [];

    setState(() {
      statesList = _llenarCompa(prefs.empresasValores, prefs.empresasIndices,
          null, _resultado, 'empresas');
      //  userInfo.empresa = _resultadoValores[0];
    });
  }

  Future<Map<dynamic, dynamic>> tomarDatos(String idcasaempresa) async {
    var data = {
      "funcionphp": 'tomarDatos',
      "idCasa": idcasaempresa,
      "idEmpresa": _myState,
      "idUsuario": prefs.oidUsuario,
      "origen": 0
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

  final String url1 =
      'http://190.121.138.85/' + 'controladores/funcionesCiudadesCorreo.php';
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

      citiesList = _llenarCompa(prefs.ciuadadesIndices, prefs.ciudadesValores,
          prefs.idBase, _resultado, 'ciudad');
    });
  }

  // Get State information by API
  List citiesList;
  String _myCity;
  final String urlOficinas =
      'http://190.121.138.85/' + 'controladores/funcionesOficinas.php';
  List<Oficinas> _oficinas = new List();
  Future<List<Oficinas>> listarOficinas() async {
    var data = {
      "funcionphp": 'listarOficinas',
      "oidEmpresa": prefs.empresaTercero,
      "idCiudad": prefs.idBase,
      "idOficina": prefs.oidOficinaTercero,
      "tipoRetorno": 2
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

    setState(() {
      List<Company> _resultado = [];

      oficinaList = _llenarCompa(prefs.oficinasValores, prefs.oficinasIndices,
          prefs.oidOficinaTercero, _resultado, 'oficina');
    });
  }

  final String urlSecciones = 'http://190.121.138.85/' + 'funcionesLogin.php';

  Future<List<Oficinas>> listarSecciones() async {
    var data = {
      "funcionphp": 'listarSecciones',
      "oidOficina": prefs.oidOficinaTercero,
      "idSeccion": prefs.idSeccion
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

    setState(() {
      List<Company> _resultado = [];

      seccionesList = _llenarCompa(
          prefs.seccionesIndices,
          prefs.seccionesValores,
          prefs.idSeccion + ',' + prefs.idSeccion,
          _resultado,
          'seccion');
    });

    return _oficinas;
  }

  _llenarCompa(prefValores, prefIndices, seleccion, _resultado, String campo) {
    final userInfo = Provider.of<InformacionUsuario>(context);
    var cont = 0;

    for (var item in prefValores) {
      _resultado.add(Company(item, prefIndices[cont]));
      cont++;
    }
    if (seleccion != null) {
      for (var item in _resultado) {
        if (item.valor == seleccion) {
          _resultado.insert(0, item);

          switch (campo) {
            case 'ciudad':
              {
                userInfo.ciudad = item.name;
                break;
              }
            case 'oficina':
              {
                userInfo.oficina = item.name;

                break;
              }
            case 'seccion':
              {
                userInfo.seccion = item.name;
              }
          }
          print(_resultado);
          return _resultado.toSet().toList();
        }
      }
    } else {
      return _resultado;
    }
    return _resultado;
  }
}

class MyCustomCard extends StatelessWidget {
  final List<Widget> widgets;

  MyCustomCard({this.widgets});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0, child: Container(child: Column(children: widgets)));
  }
}
