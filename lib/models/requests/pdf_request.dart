// To parse this JSON data, do
//
//     final pdfRequest = pdfRequestFromJson(jsonString);

import 'dart:convert';

PdfRequest pdfRequestFromJson(String str) =>
    PdfRequest.fromJson(json.decode(str));

String pdfRequestToJson(PdfRequest data) => json.encode(data.toJson());

class PdfRequest {
  PdfRequest({
    required this.id,
    required this.empresa,
    required this.crear,
  });

  int id;
  int empresa;
  bool crear;

  factory PdfRequest.fromJson(Map<String, dynamic> json) => PdfRequest(
        id: json["id"],
        empresa: json["empresa"],
        crear: json["crear"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "empresa": empresa,
        "crear": crear,
      };
}
