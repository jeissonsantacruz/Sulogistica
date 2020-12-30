import 'package:flutter/material.dart';
import 'package:sulogistica/dominio/modeloRespuesta_model.dart';


 // Patron provider que actuliza en tiempo real los valores en los widgets
class InformacionUsuario with ChangeNotifier {
  // Properties
  List<dynamic> _empresasValores = [ListaRespuesta('0', 'elegir')];
 
 String _ciudad ='Ciudad';
 String _empresa ='Empresa';
 String _oficina ='Oficina';
 String _seccion = 'Sección';

  //Getters & SETTERS
  get empresasValores {
    return _empresasValores;
  }

  set empresasValores(List<ListaRespuesta> empresas) {
    this._empresasValores = empresas;
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
   get seccion {
    return _seccion;
  }

  set seccion(String seccion) {
    this._seccion = seccion;
    notifyListeners();
  }
   get oficina {
    return _oficina;
  }

  set oficina(String oficina) {
    this._oficina = oficina;
    notifyListeners();
  }

}
