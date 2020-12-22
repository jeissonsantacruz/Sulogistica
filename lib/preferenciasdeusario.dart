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
  get origenOfic{
    return _prefs.getString('origenOfic' ?? '')
  ;}

  set origenOfic(String value){
    _prefs.setString('origenOfic', value);

  }
  get ciudad{
    return _prefs.getString('ciudad' ?? '')
  ;}

  set ciudad(String value){
    _prefs.setString('ciudad', value);

  }
  
 
}