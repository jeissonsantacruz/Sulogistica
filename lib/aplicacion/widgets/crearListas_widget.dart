// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sulogistica/aplicacion/provider/providerUsuario_prrovider.dart';
// import 'package:sulogistica/arquitectura/serviciosLogin_services.dart';
// import 'package:sulogistica/dominio/modeloEmpresas_model.dart';
// import 'package:sulogistica/dominio/modeloOficinas_model.dart';
// import 'package:sulogistica/dominio/modeloSecciones_model.dart';

// import 'package:sulogistica/dominio/modeloCiudades_model.dart';
// import '../../preferenciasdeusario.dart';
 
// class CrearListas1 extends StatefulWidget {
//   final List lista;
//   final String texto;
//   CrearListas1({this.lista,this.texto}) : super();
 
//   @override
//   CrearListas1State createState() => CrearListas1State(lista:lista,texto:texto);
// }
 
 


// class CrearListas1State extends State<CrearListas1> {

//   final List lista;
//   final String texto;

//   CrearListas1State({this.lista,this.texto});
  

//   List<DropdownMenuItem<Company>> _dropdownMenuItems;
//   Company _selectedCompany;
  
 
   
//   List<DropdownMenuItem<Company>> buildDropdownMenuItems(List companies) {
//     List<DropdownMenuItem<Company>> items = List();
//     for (Company company in companies) {
//       items.add(
//         DropdownMenuItem(
//           value: company,
//           child: Text(company.name),
//         ),
//       );
//     }
//     return items;
//   }
 
//   onChangeDropdownItem(Company selectedCompany) {
//      final prefs =  PreferenciasUsuario();
//     final userInfo = Provider.of<InformacionUsuario>(context);
//     final serviciosLogin = ServiciosLogin();
//     setState(() {
//     _selectedCompany = selectedCompany;
//      prefs.oidEmpresa= selectedCompany.valor;
//      serviciosLogin.tomarDatos();
//             serviciosLogin.listarCiudades();
//                 userInfo.listaCiudades=_llenarModelo(prefs.ciudadesValores,
//                     prefs.ciuadadesIndices);

//                     print(userInfo.listaCiudades);
//           });
//     // buscarUsuario.listarCiudades().then((value) =>  userInfo.listaCiudades=value);
     
    
//   }
  
//   _llenarModelo(prefValores, prefIndices) {
//     List<Company> _resultado = [];
//     var cont = 0;
//     for (var item in prefValores) {
//       _resultado.add(Company(item, prefIndices[cont]));
//       cont++;
//     }
//     return _resultado;
//   }

 
//   @override
//   Widget build(BuildContext context) {
//     final userInfo = Provider.of<InformacionUsuario>(context);
     
//     _dropdownMenuItems = buildDropdownMenuItems(lista);
//     return new DropdownButtonFormField(
//               value: _selectedCompany,
//               items: _dropdownMenuItems,
//               onChanged: onChangeDropdownItem,
//               decoration: InputDecoration(
//                 labelText: texto,
//                 labelStyle: TextStyle(
//           color: const Color(0xFF0A2140),fontSize: 16)
              
                
//               ),
//               style: TextStyle(
//           color: const Color(0xFF0A2140),fontSize: 16)
              
//             );
  
//   }
// } 