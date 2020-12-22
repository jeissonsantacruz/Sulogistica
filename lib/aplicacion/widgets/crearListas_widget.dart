import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sulogistica/aplicacion/provider/providerUsuario_prrovider.dart';
import 'package:sulogistica/arquitectura/serviciosLogin_services.dart';
import 'package:sulogistica/dominio/modeloEmpresas_model.dart';
import 'package:sulogistica/dominio/modeloOficinas_model.dart';
import 'package:sulogistica/dominio/modeloSecciones_model.dart';

import 'package:sulogistica/dominio/modeloCiudades_model.dart';
import '../../preferenciasdeusario.dart';
 
class CrearListas extends StatefulWidget {
  final List lista;
  final String texto;
  final  model;
  CrearListas({this.lista,this.texto,this.model}) : super();
 
  @override
  CrearListasState createState() => CrearListasState(lista:lista,texto:texto,model:model);
}
 
 


class CrearListasState extends State<CrearListas> {

  final List lista;
  final String texto;
  final model;
  CrearListasState({this.lista,this.texto,this.model});
  

  List<DropdownMenuItem<Company>> _dropdownMenuItems;
  Company _selectedCompany;
  
 
   
  List<DropdownMenuItem<Company>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Company>> items = List();
    for (Company company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }
 
  onChangeDropdownItem(Company selectedCompany) {
    final prefs =  PreferenciasUsuario();
    final userInfo = Provider.of<InformacionUsuario>(context);
    final buscarUsuario = ServiciosLogin();
    setState(() {
      _selectedCompany = selectedCompany;
     prefs.oidEmpresa= selectedCompany.valor;
    buscarUsuario.tomarDatos();
    buscarUsuario.listarCiudades().then((value) =>  userInfo.listaCiudades=value);
     
    });
  }
 
  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<InformacionUsuario>(context);
  
    _dropdownMenuItems = buildDropdownMenuItems(userInfo.empresasValores);
    return new DropdownButtonFormField(
              value: _selectedCompany,
              items: _dropdownMenuItems,
              onChanged: onChangeDropdownItem,
              decoration: InputDecoration(
                labelText: texto,
                labelStyle: TextStyle(
          color: const Color(0xFF0A2140),fontSize: 16)
              
                
              ),
              style: TextStyle(
          color: const Color(0xFF0A2140),fontSize: 16)
              
            );
  
  }
} 