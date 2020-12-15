import 'package:flutter/material.dart';


class InformacionUsuario with ChangeNotifier {
  
  // Properties
  int _phone = 0;
 

  //Getters & SETTERS
  get phone {
    return _phone;
  }
  set phone( int nombre ) {
    this._phone = nombre;
    notifyListeners();
 
}
}