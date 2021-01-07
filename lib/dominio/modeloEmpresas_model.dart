// To parse this JSON data, do
//
//     final listaEmpresas = listaEmpresasFromJson(jsonString);

import 'dart:convert';

ListaEmpresas listaEmpresasFromJson(String str) => ListaEmpresas.fromJson(json.decode(str));

String listaEmpresasToJson(ListaEmpresas data) => json.encode(data.toJson());

class ListaEmpresas {
    ListaEmpresas({
        this.empresasValores,
    });

    String empresasValores;

    factory ListaEmpresas.fromJson(Map<String, dynamic> json) => ListaEmpresas(
        empresasValores: json["empresasValores"],
    );

    Map<String, dynamic> toJson() => {
        "empresasValores": empresasValores,
    };
}
