class PdfResponse {
  PdfResponse({
    required this.nombre,
    required this.base64,
  });

  String nombre;
  String base64;

  factory PdfResponse.fromJson(Map<String, dynamic> json) => PdfResponse(
        nombre: json["nombre"],
        base64: json["base64"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "base64": base64,
      };
}
