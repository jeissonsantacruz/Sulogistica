import 'package:flutter/material.dart';
import 'package:sulogistica/dominio/modeloCiudades_model.dart';
import 'package:sulogistica/dominio/modeloEmpresas_model.dart';
import 'package:sulogistica/dominio/modeloOficinas_model.dart';
import 'package:sulogistica/dominio/modeloSecciones_model.dart';


class InformacionUsuario with ChangeNotifier {
  // Properties
  List<dynamic> _empresasValores = [Company('0', 'elegir')];
  List<dynamic> _listaCiudades = [Ciudades('0', 'elegir')];
  List<dynamic> _listaOficinas = [Oficinas('0', 'elegir')];
  List<dynamic> _listaSecciones = [Secciones('0', 'elegir')];
 String _ciudad ='Ciudad';
 String _empresa ='Empresa';

  //Getters & SETTERS
  get empresasValores {
    return _empresasValores;
  }

  set empresasValores(List<Company> empresas) {
    this._empresasValores = empresas;
    notifyListeners();
  }

  get listaCiudades {
    return _listaCiudades;
  }

  set listaCiudades(List<Ciudades> empresas) {
    this._listaCiudades = empresas;
    notifyListeners();
  }

  get listaOficinas {
    return _listaOficinas;
  }

  set listaOficinas(List<Oficinas> empresas) {
    this._listaOficinas = empresas;
    notifyListeners();
  }

  get listaSecciones {
    return _listaSecciones;
  }

  set listaSecciones(List<Secciones> empresas) {
    this._listaSecciones = empresas;
    notifyListeners();
  }
   get ciudad {
    return _ciudad;
  }

  set ciudad(String empresas) {
    this._ciudad = empresas;
    notifyListeners();
  }
  get empresa {
    return _empresa;
  }

  set empresa(String empresas) {
    this._empresa = empresas;
    notifyListeners();
  }

}
