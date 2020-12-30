import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sulogistica/aplicacion/paginas/homeUsuario.dart';
import 'package:sulogistica/aplicacion/provider/providerUsuario_prrovider.dart';
import 'package:sulogistica/aplicacion/widgets/politicaDatos_widget.dart';
import 'package:sulogistica/aplicacion/widgets/recuperContrasena_widget.dart';
import 'package:sulogistica/arquitectura/serviciosLogin_services.dart';
import 'package:sulogistica/dominio/modeloRespuesta_model.dart';

import '../../preferenciasdeusario.dart';

// Pagina del login
class LoginPagina extends StatefulWidget {
  @override
  _LoginPaginaState createState() => _LoginPaginaState();
}

class _LoginPaginaState extends State<LoginPagina> {
  // spinit del loading
  final spinkit = SpinKitFadingCircle(
    size: 60,
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
            color: index.isEven ? Color(0xFFC11C36) : Color(0xFF0A2140)),
      );
    },
  );
  // controladores del codigo y contraseña del usuario
  TextEditingController codigoController = new TextEditingController();
  TextEditingController contraController = new TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<InformacionUsuario>(context);
    final size = MediaQuery.of(context).size;
    // Verifica si el usuario tiene informacion para volver a logearse
    if (prefs.seccion != null) {
      userInfo.empresa = prefs.empresa;
      codigoController.text = prefs.codigo;
      userInfo.ciudad = prefs.ciudad;
      userInfo.oficina = prefs.oficina;
      userInfo.seccion = prefs.seccion;
    }

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
                margin: EdgeInsets.only(bottom: 30, top: 100),
                child: _loginImagen(context),
              ),
              //======================================================== Codigo
              TextFormField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.blueGrey,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.blueGrey,
                          width: 1.0,
                        ),
                      ),
                      hintText: 'Código',
                      labelStyle: new TextStyle(color: Colors.white)),
                  controller: codigoController,
                  onEditingComplete: () {
                    prefs.codigo = codigoController.text;
                    setState(() => loading = true);
                    buscarUsuario();
                  }),
              SizedBox(height: 10),
              loading
                  ? spinkit
                  : Column(
                      children: [
                        //======================================================== Empresa
                        Container(
                          padding: EdgeInsets.only(top: 5, left: 15),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    elevation: 0,
                                    focusColor: Colors.greenAccent,
                                    value: _myEmpresa,
                                    style: TextStyle(
                                        color: const Color(0xFF0A2140),
                                        fontSize: 16),
                                    hint: Text(
                                      '${userInfo.empresa}',
                                      style:
                                          TextStyle(color: Color(0xFF0A2140)),
                                    ),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        _myEmpresa = newValue;
                                        prefs.empresa = userInfo.empresa;
                                        print(_myEmpresa);
                                        setState(() => loading = true);
                                        tomarDatos(
                                            prefs.idCasa + ',' + prefs.oidCasa);

                                        listarCiudades().whenComplete(() {
                                          listarOficinas().whenComplete(() => listarSecciones())
                                          ;
                                        });
                                      });
                                    },
                                    items: empresasList?.map((item) {
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
                        //======================================================== Ciudad
                        SizedBox(height: 30),
                        Container(
                          padding: EdgeInsets.only(top: 5, left: 15),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: DropdownButtonHideUnderline(
                                  child: ButtonTheme(
                                    child: DropdownButton<String>(
                                      value: _myCiudad,
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                      ),
                                      hint: Text(
                                        '${userInfo.ciudad}',
                                        style:
                                            TextStyle(color: Color(0xFF0A2140)),
                                      ),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          _myCiudad = newValue;
                                          prefs.idBase = _myCiudad;
                                          print(_myCiudad);
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
                        //======================================================== Oficina
                        SizedBox(height: 10),
                        Container(
                            padding: EdgeInsets.only(top: 5, left: 15),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blueGrey),
                                borderRadius: BorderRadius.circular(10)),
                            child: DropdownButtonHideUnderline(
                              child: ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxHeight: 48.0),
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
                                      prefs.oidOficinaTercero=_myOficina;
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
                        //======================================================== Seccion
                        SizedBox(height: 10,),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.only(top: 5, left: 15),
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
                                        style:
                                            TextStyle(color: Color(0xFF0A2140)),
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
                      ],
                    ),

              SizedBox(height: 20),
               //======================================================== Contraseña Text field
              MyCustomCard(
                widgets: <Widget>[
                  TextField(
                    obscureText: true,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        labelText: 'Contraseña',
                        labelStyle: new TextStyle(
                            color: const Color(0xFF0A2140), fontSize: 20)),
                    controller: contraController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                   //======================================================== Link para recuperar Contraseña
                  InkWell(
                      child: new Text('Olvidé mi contraseña',
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
               //======================================================== Iniciar sesion boton
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
                      setState(() => loading = true);
                      final serviciosLogin = ServiciosLogin();

                      if (prefs.oficina == null) {
                        _onAlertButtonsPressed(
                            context,
                            'Por favor seleccione todos los campos!',
                            'Información incompleta');
                      } else {
                        var res = serviciosLogin.iniciarSesion(
                            codigoController.text,
                            contraController.text,
                            prefs.idCasa + ',' + prefs.oidCasa,
                            _myEmpresa,
                            prefs.idBase,
                            prefs.oidOficinaTercero,
                            prefs.idSeccion + ',' + prefs.seccionTercero);

                        res.then((respuesta) {
                          if (respuesta['enlace'] !=
                              '\/controladores\/principal.php') {
                            _onAlertButtonsPressed(context,
                                respuesta['msgError'], "Usuario no válido");
                          } else {
                            prefs.logeado = true;
                            setState(() => loading = false);
                             Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeUsuario()));
                          }
                        });
                      }
                      setState(() => loading = false);
                    },
                  )),
              SizedBox(height: 20,),
               //======================================================== Ver Política de datos
              InkWell(
                  child: new Text('Política de manejo de datos',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      )),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PoliticaDeDatos()));
                  }),
            ],
          ),
        ),
      ),
    );
  }
  
  
  //======================================================== Widget que dibuja el " SuWeb"

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

  //======================================================== Pop Up de alertas 

  _onAlertButtonsPressed(context, String msg, String titulo) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: titulo,
      desc: msg,
      buttons: [
        DialogButton(
          child: Text(
            "Entendido",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => Navigator.pop(context),
          color: Colors.orange,
        ),
      ],
    ).show();
  }

  //=============================================================================== POST LLAMADAS


// Listas de respuesta de cada POST
  List<ListaRespuesta> empresasList = [];
  List<ListaRespuesta>  oficinaList =[];
  List<ListaRespuesta>  seccionesList=[];
  List<ListaRespuesta>  citiesList=[];
  // Valores selecionados del usuario
  String _mySeccion;
  String _myOficina;
  String _myEmpresa;
  String _myCiudad;

  final String url = 'http://190.121.138.85/' + 'funcionesLogin.php';
  final prefs = PreferenciasUsuario();
   //=============================================================================== POST BUSCAR USuARIO

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
        List<ListaRespuesta> _resultado = [ListaRespuesta('0', 'elegir')];
        _myEmpresa = prefs.empresasIndices[0];
        empresasList = _llenarCompa(
            _resultadoValores, _resultadoIndices, null, _resultado, 'empresas');
        tomarDatos(prefs.oidCasa);

        listarCiudades().whenComplete(() {
          listarOficinas().whenComplete(() => listarSecciones());
        });
      });

      return 1;
    }
    List<ListaRespuesta> _resultado = [ListaRespuesta('0', 'elegir')];
    setState(() => loading = false);
    setState(() {
      empresasList = _llenarCompa(prefs.empresasValores, prefs.empresasIndices,
          null, _resultado, 'empresas');
      //  userInfo.empresa = _resultadoValores[0];
    });
    return 1;
  }
  
   //=============================================================================== POST BUSCAR USUARIO

  Future<int> tomarDatos(String idcasaempresa) async {
    var data = {
      "funcionphp": 'tomarDatos',
      "idCasa": idcasaempresa,
      "idEmpresa": _myEmpresa,
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
    prefs.seccionTercero = decodeData['seccionTercero'];
    prefs.oidOficinaTercero = decodeData['oidOficinaTercero'];
    prefs.oficinaOrigen = decodeData['origenOfic'];
    print(decodeData);
    return 1;
  }

   //=============================================================================== POST LISTAR CIUDADES

  final String urlCiudades ='http://190.121.138.85/' + 'controladores/funcionesCiudadesCorreo.php';
  Future<int> listarCiudades() async {
    var data = {
      "funcionphp": 'listarCiudades',
      "idEmpresa": prefs.empresaTercero,
      "idBase": prefs.idBase,
    };
    var dio = Dio();
    final encodedData = FormData.fromMap(data);
    // make POST request
    Response response = await dio.post(urlCiudades, data: encodedData);
    final decodeData = jsonDecode(response.data);

    if (decodeData['ciudadesIndices'] != null) {
      var listaValores = decodeData['ciudadesIndices'];
      var listaIndices = decodeData['ciudadesValores'];
      
      var _resultadoValores = List<String>.from(listaValores);
      var _resultadoIndices = List<String>.from(listaIndices);
      
      prefs.ciudadesValores = _resultadoValores;
      prefs.ciuadadesIndices = _resultadoIndices;
      
      setState(() {
        List<ListaRespuesta> _resultado = [ListaRespuesta('0', 'elegir')];
      
        citiesList = _llenarCompa(prefs.ciuadadesIndices, prefs.ciudadesValores,
            prefs.idBase, _resultado, 'ciudad');
      });
    }

    return 1;
  }
    
    //=============================================================================== POST LISTAR OFICINAS

  final String urlOficinas ='http://190.121.138.85/' + 'controladores/funcionesOficinas.php';
  Future<int> listarOficinas() async {
    var data = {
      "funcionphp": 'listarOficinas',
      "oidEmpresa": prefs.oficinaOrigen,
      "idCiudad": prefs.idBase,
      "idOficina": prefs.oidOficinaTercero,
      "tipoRetorno": 2
    };
    var dio = Dio();
    final encodedData = FormData.fromMap(data);
    // make POST request
    Response response = await dio.post(urlOficinas, data: encodedData);
    final decodeData = jsonDecode(response.data);
    if(decodeData['oficinasValores'] != null){
    var listaValores = decodeData['oficinasValores'];
    var listaIndices = decodeData['oficinasIndices'];

    var _resultadoValores = List<String>.from(listaValores);
    var _resultadoIndices = List<String>.from(listaIndices);

    prefs.oficinasValores = _resultadoValores;
    prefs.oficinasIndices = _resultadoIndices;
    setState(() {
      List<ListaRespuesta> _resultado = [ListaRespuesta('0', 'elegir')];

      oficinaList = _llenarCompa(_resultadoValores, _resultadoIndices,
          prefs.oidOficinaTercero, _resultado, 'oficina');
    });
    }
    
    return 1;
  }
  
  //=============================================================================== POST LISTAR SECCIONES
  final String urlSecciones = 'http://190.121.138.85/' + 'funcionesLogin.php';
  Future<int> listarSecciones() async {
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
    
    if (decodeData['seccionesIndices'] != null) {
      var listaValores = decodeData['seccionesIndices'];
      var listaIndices = decodeData['seccionesValores'];
      
      var _resultadoValores = List<String>.from(listaValores);
      var _resultadoIndices = List<String>.from(listaIndices);
      
      prefs.seccionesValores = _resultadoValores;
      prefs.seccionesIndices = _resultadoIndices;
      
      setState(() {
        List<ListaRespuesta> _resultado = [ListaRespuesta('', 'elegir')];
      
        seccionesList = _llenarCompa(_resultadoIndices, _resultadoValores,
            decodeData["seccionElecta"].toString(), _resultado, 'seccion');
      });
      setState(() => loading = false);
    }
    return 1;
  }

 // Funcion que llena una lista con objetos de tipo Lista Respuesta ( el cual se utiliza para mostar las listas resultantes de los POST)
 // retorna una lista de objetos de ListaEmpresa
  _llenarCompa(prefValores, prefIndices, seleccion, _resultado, String campo) {
    final userInfo = Provider.of<InformacionUsuario>(context);
    var cont = 0;
    // Recorre los valores y indices devultos por el POST y los agrega a una lista resultado de objetos
    for (var item in prefValores) {
      _resultado.add(ListaRespuesta(item, prefIndices[cont]));
      cont++;
    }
    // Case que actualiza el valor del campo
    if (seleccion != null) {
      for (var item in _resultado) {
        if (item.valor == seleccion) {
          _resultado.insert(0, item);

          switch (campo) {
            case 'ciudad':
              {
                userInfo.ciudad = item.name;
                // prefs.ciudad = item.name;
                break;
              }
            case 'oficina':
              {
                userInfo.oficina = item.name;
               prefs.oficina = item.name;
                break;
              }
            case 'seccion':
              {
                userInfo.seccion = item.name;
                // prefs.seccion = item.name;
              }
          }
          print('entre' + ':' + item.name);
          return _resultado.toSet().toList();
        }
      }
    } else {
      userInfo.empresa = prefValores[0];
      // prefs.empresa = userInfo.empresa;
       return _resultado.toSet().toList();
    }
    return _resultado.toSet().toList();
  }
}


// clase utilizada para dibujar el campo de la ontraseña con stilos 
class MyCustomCard extends StatelessWidget {
  final List<Widget> widgets;

  MyCustomCard({this.widgets});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0, child: Container(child: Column(children: widgets)));
  }
}
