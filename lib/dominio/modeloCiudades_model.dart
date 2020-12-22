// To parse this JSON data, do
//
//     final ciudades = ciudadesFromJson(jsonString);

import 'dart:convert';

Ciudades ciudadesFromJson(String str) => Ciudades.fromJson(json.decode(str));

String ciudadesToJson(Ciudades data) => json.encode(data.toJson());

class Ciudades {
    Ciudades({
        this.oid,
        this.cuidad,
        this.nombreciudad,
    });

    String oid;
    String cuidad;
    String nombreciudad;

    factory Ciudades.fromJson(Map<String, dynamic> json) => Ciudades(
        oid: json["oid"],
        cuidad: json["cuidad"],
        nombreciudad: json["nombreciudad"],
    );

    Map<String, dynamic> toJson() => {
        "oid": oid,
        "cuidad": cuidad,
        "nombreciudad": nombreciudad,
    };
}
