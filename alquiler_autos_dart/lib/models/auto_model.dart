class Auto {
  String marca;
  String modelo;
  int precio;
  bool disponible;
  String imagen;
  int anio;
  bool alquilado;

  Auto({
    required this.marca,
    required this.modelo,
    required this.precio,
    required this.disponible,
    required this.imagen,
    required this.anio,
    this.alquilado = false,
  });
}
