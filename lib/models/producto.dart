class Producto {
  final int? id;
  final String descripcion;
  final String categoria;
  final int cantidad;
  final String urlImagen;

  Producto({
    this.id,
    required this.descripcion,
    required this.categoria,
    required this.cantidad,
    required this.urlImagen,
  });

  // Convertir un Producto en un Map para insertar en la base de datos
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'descripcion': descripcion,
      'categoria': categoria,
      'cantidad': cantidad,
      'urlImagen': urlImagen,
    };
  }

  // Convertir un Map en un Producto
  factory Producto.fromMap(Map<String, dynamic> map) {
    return Producto(
      id: map['id'],
      descripcion: map['descripcion'],
      categoria: map['categoria'],
      cantidad: map['cantidad'],
      urlImagen: map['urlImagen'],
    );
  }
}