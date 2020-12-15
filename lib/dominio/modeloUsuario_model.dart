// To parse this JSON data, do
//
//     final listaEmpresas = listaEmpresasFromJson(jsonString);

import 'dart:convert';

ListaEmpresas listaEmpresasFromJson(String str) => ListaEmpresas.fromJson(json.decode(str));

String listaEmpresasToJson(ListaEmpresas data) => json.encode(data.toJson());

class ListaEmpresas {
    ListaEmpresas({
        this.oidUsuario,
        this.oidtuasuario,
        this.idEmpresa,
        this.oidEmpresa,
        this.idCasa,
        this.oidCasa,
        this.empresasIndices,
        this.empresasValores,
        this.cuantasEmpresas,
        this.esValido,
        this.casaElecta,
        this.casasIndices,
        this.casasValores,
    });

    String oidUsuario;
    String oidtuasuario;
    String idEmpresa;
    String oidEmpresa;
    String idCasa;
    String oidCasa;
    List<String> empresasIndices;
    List<String> empresasValores;
    int cuantasEmpresas;
    String esValido;
    int casaElecta;
    List<String> casasIndices;
    List<String> casasValores;

    factory ListaEmpresas.fromJson(Map<String, dynamic> json) => ListaEmpresas(
        oidUsuario: json["oidUsuario"],
        oidtuasuario: json["oidtuasuario"],
        idEmpresa: json["idEmpresa"],
        oidEmpresa: json["oidEmpresa"],
        idCasa: json["idCasa"],
        oidCasa: json["oidCasa"],
        empresasIndices: List<String>.from(json["empresasIndices"].map((x) => x)),
        empresasValores: List<String>.from(json["empresasValores"].map((x) => x)),
        cuantasEmpresas: json["cuantasEmpresas"],
        esValido: json["esValido"],
        casaElecta: json["casaElecta"],
        casasIndices: List<String>.from(json["casasIndices"].map((x) => x)),
        casasValores: List<String>.from(json["casasValores"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "oidUsuario": oidUsuario,
        "oidtuasuario": oidtuasuario,
        "idEmpresa": idEmpresa,
        "oidEmpresa": oidEmpresa,
        "idCasa": idCasa,
        "oidCasa": oidCasa,
        "empresasIndices": List<dynamic>.from(empresasIndices.map((x) => x)),
        "empresasValores": List<dynamic>.from(empresasValores.map((x) => x)),
        "cuantasEmpresas": cuantasEmpresas,
        "esValido": esValido,
        "casaElecta": casaElecta,
        "casasIndices": List<dynamic>.from(casasIndices.map((x) => x)),
        "casasValores": List<dynamic>.from(casasValores.map((x) => x)),
    };
}
