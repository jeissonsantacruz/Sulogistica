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
  get order {
    return _prefs.getString('order') ?? '';
  }

  set order(String value) {
    _prefs.setString('order', value);
  }

  get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  get tokenPhone {
    return _prefs.getString('tokenPhone') ?? '';
  }

  set pts(String value) {
    _prefs.setString('pts', value);
  }

  get pts {
    return _prefs.getString('pts') ?? '';
  }

  set tokenPhone(String value) {
    _prefs.setString('tokenPhone', value);
  }

  get name {
    return _prefs.getString('name') ?? '';
  }

  set name(String value) {
    _prefs.setString('name', value);
  }

  set email(String value) {
    _prefs.setString('email', value);
  }

  get email {
    return _prefs.getString('email') ?? '';
  }

  // GET y SET de la última página
  get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'login';
  }

  set ultimaPagina(String value) {
    _prefs.setString('ultimaPagina', value);
  }

  set id(String value) {
    _prefs.setString('id', value);
  }

  get id {
    return _prefs.getString('id') ?? '';
  }

  set direccion(String value) {
    _prefs.setString('direccion', value);
  }

  get direccion {
    return _prefs.getString('direccion') ?? '';
  }

  get payment {
    return _prefs.getString('payment') ?? '';
  }

  set payment(String value) {
    _prefs.setString('payment', value);
  }
}