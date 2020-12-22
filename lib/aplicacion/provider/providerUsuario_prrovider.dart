import 'package:flutter/material.dart';
import 'package:sulogistica/dominio/modeloEmpresas_model.dart';
import 'package:sulogistica/dominio/modeloOficinas_model.dart';
import 'package:sulogistica/dominio/modeloSecciones_model.dart';

import 'package:sulogistica/dominio/modeloCiudades_model.dart';


class InformacionUsuario with ChangeNotifier {
  
  // Properties
  List<dynamic>  _empresasValores = [];
  List<dynamic>  _listaCiudades = [];
   List<dynamic>  _listaOficinas = [];
    List<dynamic>  _listaSecciones = [];

  //Getters & SETTERS
  get empresasValores {
    return _empresasValores;
  }
  set empresasValores( List<Company>  empresas ) {
    this._empresasValores = empresas;
    notifyListeners();
 
}
 get listaCiudades {
    return _listaCiudades;
  }
  set listaCiudades( List<Ciudades>  empresas ) {
    this._listaCiudades = empresas;
    notifyListeners();
 
}
 get listaOficinas {
    return _listaOficinas;
  }
  set listaOficinas( List<Oficinas>  empresas ) {
    this._listaOficinas = empresas;
    notifyListeners();
 
}
get listaSecciones {
    return _listaSecciones;
  }
  set listaSecciones( List<Secciones>  empresas ) {
    this._listaSecciones = empresas;
    notifyListeners();
 
}
}