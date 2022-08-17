// To parse this JSON data, do
//
//     final covid = covidFromJson(jsonString);

import 'dart:convert';

Joks joksFromJson(String str) => Joks.fromJson(json.decode(str));

String joksToJson(Joks data) => json.encode(data.toJson());

class Joks {
  Joks({
     this.createddate,
     this.value,

  });

  String? createddate;
  String? value;


  factory Joks.fromJson(Map<String, dynamic> json) => Joks(
    createddate: json["created_at"],
    value: json["value"],

  );

  Map<String, dynamic> toJson() => {
    "created_at": createddate,
    "value": value,

  };
}
