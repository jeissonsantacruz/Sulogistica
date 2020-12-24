/* Flutter dependencies */
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sulogistica/aplicacion/provider/providerUsuario_prrovider.dart';
import 'package:sulogistica/aplicacion/widgets/recuperContrasena_widget.dart';
import 'package:sulogistica/arquitectura/serviciosLogin_services.dart';
import 'package:sulogistica/dominio/modeloCiudades_model.dart';
import 'package:sulogistica/dominio/modeloEmpresas_model.dart';
import 'package:sulogistica/preferenciasdeusario.dart';

//contiene la pagina de login
class LoginPagina2 extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPagina2> {
  // Controladores del formulario

  TextEditingController codigoController = new TextEditingController();
  TextEditingController contraController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          color: Colors.white70,
          padding: EdgeInsets.only(
              left: size.height * 0.02,
              right: size.height * 0.02,
              top: size.height * 0.1),
          child: SingleChildScrollView(
              child: Column(children: <Widget>[
            _loginImagen(context),
            _formulario(context),
          ]))),
    );
  }

  // Widget que dibuja logo sulogistica
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

  // widget  que pinta los formularios
  Widget _formulario(BuildContext context) {
    final userInfo = Provider.of<InformacionUsuario>(context);

    final size = MediaQuery.of(context).size;
    return ListView(
        shrinkWrap: true,
        padding:
            EdgeInsets.only(bottom: size.height * 0.5, left: size.width * 0.05),
        children: <Widget>[
          MyCustomTitle(
            icono: FontAwesomeIcons.userAlt,
            titulo: 'Datos del usuario',
          ),
          MyCustomCard(
            widgets: [
              TextField(
                decoration: InputDecoration(
                    labelText: 'Código',
                    labelStyle: new TextStyle(color: const Color(0xFF0A2140))),
                controller: codigoController,
                onEditingComplete: _submitCodigo,
              ),
              CrearListas(
                lista: userInfo.empresasValores,
                texto: 'Empresa',
                buildDropdownMenuItems: buildDropdownMenuItems,
                onChangeDropdownItem: onChangeDropdownItem,
              ),
            ],
          ),

          MyCustomTitle(
            icono: FontAwesomeIcons.mapMarkerAlt,
            titulo: 'ubicación actual',
          ),

          MyCustomCard(widgets: <Widget>[
            CrearListas(
              lista: userInfo.listaCiudades,
              texto: 'Ciudad',
              buildDropdownMenuItems: buildDropdownMenuItems,
              onChangeDropdownItem: onChangeDropdownItem,
            ),
            CrearListas(
              lista: userInfo.listaOficinas,
              texto: 'Oficina',
              buildDropdownMenuItems: buildDropdownMenuItems,
              onChangeDropdownItem: onChangeDropdownItem,
            ),
            CrearListas(
              lista: userInfo.listaSecciones,
              texto: 'Sección',
              buildDropdownMenuItems: buildDropdownMenuItems,
              onChangeDropdownItem: onChangeDropdownItem,
            ),
          ]),
          MyCustomTitle(
            titulo: 'Verificación',
            icono: FontAwesomeIcons.key,
          ),
          MyCustomCard(
            widgets: <Widget>[
              TextField(
                decoration: InputDecoration(
                    labelText: 'Contraseña',
                    labelStyle: new TextStyle(color: const Color(0xFF0A2140))),
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
                onPressed:(){}
              )),
        ]);
  }

  _submitCodigo() {
    final prefs = PreferenciasUsuario();
    final userInfo = Provider.of<InformacionUsuario>(context);
    final serviciosLogin = ServiciosLogin();

    var res =
        serviciosLogin.buscarUsuario(codigoController.text, 'buscarUsuario');
    res.then((value) async {
    List<Company> _resultado = [];
      userInfo.empresasValores = _llenarCompa(
          prefs.empresasValores, prefs.empresasIndices,null,_resultado);
      if (value == 1) {
        serviciosLogin.tomarDatos().then((value)   {
           List<Ciudades> _resultado = [];
            serviciosLogin.listarCiudades().then((value) {
                 userInfo.listaCiudades = _llenarCiudades(
                    prefs.ciuadadesIndices, prefs.ciudadesValores,prefs.idBase,_resultado);
            });
         
            // serviciosLogin.listarOficinas();
          
            // userInfo.listaOficinas = _llenarCompa(
            //       prefs.oficinasIndices, prefs.oficinasValores,prefs.oidOficinaTercero);
            //        serviciosLogin.listarSecciones();
            //   userInfo.listaOficinas = _llenarCompa(
            //       prefs.seccionesIndices, prefs.seccionesValores,prefs.idSeccion);
            });
            
            
      }
    });
  }

  _llenarCompa(prefValores, prefIndices,seleccion,_resultado) {
    var cont = 0;
    
    final userInfo = Provider.of<InformacionUsuario>(context);
    for (var item in prefValores) {
      
      _resultado.add(Company(item, prefIndices[cont]));
      cont++;
    }
    if (seleccion != null){
    for (var item in _resultado) {
     if(item.valor == seleccion){
        _resultado.insert(0, item);
        return _resultado;
     }
      
    }
    }else{
      return _resultado;
    }
    
  }
  _llenarCiudades(prefValores, prefIndices,seleccion,_resultado) {
    var cont = 0;
    
    final userInfo = Provider.of<InformacionUsuario>(context);
    for (var item in prefValores) {
      
      _resultado.add(Ciudades(item, prefIndices[cont]));
      cont++;
    }
    if (seleccion != null){
    for (var item in _resultado) {
     if(item.valor == seleccion){
        _resultado.insert(1, item);
        return _resultado;
     }
      
    }
    }else{
      return _resultado;
    }
    return _resultado;
  }
  


  dynamic _selectedCompany;

  List<DropdownMenuItem> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem> items = List();
    for (var company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(dynamic selectedCompany) {
    final prefs = PreferenciasUsuario();
    final userInfo = Provider.of<InformacionUsuario>(context);
    final serviciosLogin = ServiciosLogin();
    
    setState(() {
    List<Ciudades> _resultado = [];
    
      _selectedCompany = selectedCompany;
      prefs.oidEmpresa = selectedCompany.valor;
      serviciosLogin.tomarDatos()
      .whenComplete(() {
        serviciosLogin.listarCiudades().whenComplete(() {
        userInfo.listaCiudades = _llenarCiudades(
            prefs.ciuadadesIndices, prefs.ciudadesValores,prefs.idBase,_resultado);
      });

      });

      
      print(selectedCompany);
    });
  }
}

class CrearListas extends StatelessWidget {
  final List lista;
  final String texto;
  final Function buildDropdownMenuItems;
  final Function onChangeDropdownItem;
  final modelo;

  CrearListas(
      {this.lista,
      this.texto,
      this.buildDropdownMenuItems,
      this.onChangeDropdownItem,
      this.modelo,
    });

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<dynamic>> _dropdownMenuItems;

    _dropdownMenuItems = buildDropdownMenuItems(lista);
    dynamic _selectedCompany;
    _selectedCompany = lista[0];

    return new DropdownButtonFormField(
        value: _selectedCompany,
        items: _dropdownMenuItems,
        onChanged: onChangeDropdownItem,
        decoration: InputDecoration(
            labelText: texto,
            labelStyle:
                TextStyle(color: const Color(0xFF0A2140), fontSize: 16)),
        style: TextStyle(color: const Color(0xFF0A2140), fontSize: 16));
  }
}

// Clase que personaliza la Tareta de los campos del formulario
class MyCustomCard extends StatelessWidget {
  final List<Widget> widgets;

  MyCustomCard({this.widgets});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0, child: Container(child: Column(children: widgets)));
  }
}

class MyCustomTitle extends StatelessWidget {
  final IconData icono;
  final String titulo;

  MyCustomTitle({this.icono, this.titulo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40),
      child: ListTile(
        leading: Icon(
          icono,
          color: Color(0xFF0A2140),
        ),
        title: Text(
          titulo,
          style: TextStyle(
              fontSize: 20,
              color: Color(0xFF0A2140),
              fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}