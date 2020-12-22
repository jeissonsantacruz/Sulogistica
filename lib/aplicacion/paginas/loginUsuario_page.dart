/* Flutter dependencies */
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sulogistica/aplicacion/provider/providerUsuario_prrovider.dart';
import 'package:sulogistica/aplicacion/widgets/crearListas_widget.dart';
import 'package:sulogistica/aplicacion/widgets/recuperContrasena_widget.dart';
import 'package:sulogistica/arquitectura/serviciosLogin_services.dart';
import 'package:sulogistica/dominio/modeloEmpresas_model.dart';
import 'package:sulogistica/preferenciasdeusario.dart';

//contiene la pagina de login
class LoginPagina extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPagina> {
  // Controladores del formulario

  TextEditingController codigoController = new TextEditingController();
  TextEditingController contraController = new TextEditingController();



  @override
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
                controller:codigoController,
                onEditingComplete: _submitCodigo,
              ),
              CrearListas(
              lista: userInfo.empresasValores,
              texto: 'Empresa',
              model: Company,
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
            ),
            CrearListas(
              lista: [],
              texto: 'Oficina',
            ),
            CrearListas(
              lista: [],
              texto: 'Sección',
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
                        leading: Icon(FontAwesomeIcons.signInAlt,color: Colors.white,),
                        title: Text("Iniciar sesión",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600))),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CrearListas()));
                },
              )),
        ]);
  }
  _submitCodigo (){
  final userInfo = Provider.of<InformacionUsuario>(context);
   final prefs =  PreferenciasUsuario();
  List<Company>_resultado = [];
   final buscarUsuario = ServiciosLogin();
   buscarUsuario.buscarrUsuario(codigoController.text, 'buscarUsuario');
   var cont = 0;
   for (var item in prefs.empresasValores ) {
    _resultado.add(Company(item,prefs.empresasIndices[cont]));
    cont ++;
  }
  userInfo.empresasValores=_resultado;
}
}


// Clase que personaliza la Tareta de los campos del formulario
class MyCustomCard extends StatelessWidget {
  final List<Widget> widgets;

  MyCustomCard({this.widgets});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        child: Container(
            child: Column(children: widgets)));
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
