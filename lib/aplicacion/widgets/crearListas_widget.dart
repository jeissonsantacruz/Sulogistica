import 'package:flutter/material.dart';
import 'package:sulogistica/dominio/modeloEmpresas_model.dart';
 
class CrearListas extends StatefulWidget {
  final List<ListaEmpresas> lista;
  final String texto;
  CrearListas({this.lista,this.texto}) : super();
 
  @override
  CrearListasState createState() => CrearListasState(lista:lista,texto:texto);
}
 
 
class CrearListasState extends State<CrearListas> {

  final List<ListaEmpresas>  lista;
  final String texto;
  CrearListasState({this.lista,this.texto});
  //

  List<DropdownMenuItem<ListaEmpresas>> _dropdownMenuItems;
  ListaEmpresas _selectedCompany;
 
  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(lista);
  
    super.initState();
  }
 
  List<DropdownMenuItem<ListaEmpresas>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<ListaEmpresas>> items = List();
    for (ListaEmpresas company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.empresasValores),
        ),
      );
    }
    return items;
  }
 
  onChangeDropdownItem(ListaEmpresas selectedCompany) {
    setState(() {
      _selectedCompany = selectedCompany;
    });
  }
 
  @override
  Widget build(BuildContext context) {
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