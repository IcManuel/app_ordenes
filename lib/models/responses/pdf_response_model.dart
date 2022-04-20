class PdfResponse {
  PdfResponse({
    this.nombre,
    this.base64,
    this.ok,
  });

  String? nombre;
  bool? ok;
  String? base64;

  factory PdfResponse.fromJson(Map<String, dynamic> json) => PdfResponse(
        nombre: json["nombre"],
        base64: json["base64"],
        ok: json["ok"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre!,
        "base64": base64!,
      };
}
