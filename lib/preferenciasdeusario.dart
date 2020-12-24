import 'package:shared_preferences/shared_preferences.dart';

/*
  Recordar instalar el paquete de:
    shared_preferences:
  Inicializar en el main
    final prefs = new PreferenciasUsuario();
    await prefs.initPrefs();
    
    Recuerden que el main() debe de ser async {...
*/

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del token
  get ciudadesValores {
    return _prefs.getStringList('ciudadesValores') ?? '';
  }

  set ciudadesValores(List<String> value) {
    _prefs.setStringList('ciudadesValores', value);
  }
  get ciuadadesIndices {
    return _prefs.getStringList('ciuadadesIndices') ?? '';
  }

  set ciuadadesIndices(List<String> value) {
    _prefs.setStringList('ciuadadesIndices', value);
  }
  get seccionesValores {
    return _prefs.getStringList('seccionesValores') ?? '';
  }

  set seccionesValores(List<String> value) {
    _prefs.setStringList('seccionesValores', value);
  }
  get seccionesIndices {
    return _prefs.getStringList('seccionesIndices') ?? '';
  }

  set seccionesIndices(List<String> value) {
    _prefs.setStringList('seccionesIndices', value);
  }
   get oficinasValores {
    return _prefs.getStringList('oficinasValores') ?? '';
  }

  set oficinasValores(List<String> value) {
    _prefs.setStringList('oficinasValores', value);
  }
  get oficinasIndices {
    return _prefs.getStringList('oficinasIndices') ?? '';
  }

  set oficinasIndices(List<String> value) {
    _prefs.setStringList('oficinasIndices', value);
  }
   get empresasValores {
    return _prefs.getStringList('empresasValores') ?? '';
  }

  set empresasValores(List<String> value) {
    _prefs.setStringList('empresasValores', value);
  }
  get empresasIndices {
    return _prefs.getStringList('empresasIndices') ?? '';
  }

  set empresasIndices(List<String> value) {
    _prefs.setStringList('empresasIndices', value);
  }

  
  get oidUsuario{
    return _prefs.getString('oidUsuario' ?? '')
  ;}

  set oidUsuario(String value){
    _prefs.setString('oidUsuario', value);

  }
  
   get oidCasa{
    return _prefs.getString('oidCasa' ?? '')
  ;}

  set oidCasa(String value){
    _prefs.setString('oidCasa', value);

  }
  get idCasa{
    return _prefs.getString('idCasa' ?? '')
  ;}

  set idCasa(String value){
    _prefs.setString('idCasa', value);

  }
   get oidEmpresa{
    return _prefs.getString('oidEmpresa' ?? '')
  ;}

  set oidEmpresa(String value){
    _prefs.setString('oidEmpresa', value);

  }
   get idBase{
    return _prefs.getString('idBase' ?? '')
  ;}

  set idBase(String value){
    _prefs.setString('idBase', value);

  }
   get empresaTercero{
    return _prefs.getString('empresaTercero' ?? '')
  ;}

  set empresaTercero(String value){
    _prefs.setString('empresaTercero', value);

  }
   get oidOficinaTercero{
    return _prefs.getString('oidOficinaTercero' ?? '')
  ;}

  set oidOficinaTercero(String value){
    _prefs.setString('oidOficinaTercero', value);

  }
  get idSeccion{
    return _prefs.getString('idSeccion' ?? '')
  ;}

  set idSeccion(String value){
    _prefs.setString('idSeccion', value);

  }
   get logeado{
    return _prefs.getString('logeado' ?? false)
  ;}

  set logeado(bool value){
    _prefs.setBool('logeado', value);

  }
  

 
  
 
}