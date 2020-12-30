import 'package:flutter/material.dart';
import 'package:pdf_flutter/pdf_flutter.dart';
// Plugins

import 'appBar_widget.dart';

// Clase que crea un Web view para recuperar la contraseña

class PoliticaDeDatos extends StatelessWidget {
 
  @override

  Widget build(BuildContext context) {
     final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppBar(
        onPressed: (){
          Navigator.of(context).pop();
        },
      ),
      body: PDF.network('http://190.121.138.85/informacion/manuales/suweb/Pol%C3%ADtica_de_Manejo_de_Datos_Personales_-_GRUPO_SULOGISTICA_S.A_MAY_2019.pdf' , height: size.height,
        width: size.width,
        )
    );
  }
}