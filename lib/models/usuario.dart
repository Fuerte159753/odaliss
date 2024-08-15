class Usuario {
  int? id;
  String nombre;
  String apellidos;
  String correo;
  String contrasena;

  Usuario({
    this.id,
    required this.nombre,
    required this.apellidos,
    required this.correo,
    required this.contrasena,
  });

  bool validarContrasena() {
    return contrasena.length >= 8;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'apellidos': apellidos,
      'correo': correo,
      'contrasena': contrasena,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'],
      nombre: map['nombre'],
      apellidos: map['apellidos'],
      correo: map['correo'],
      contrasena: map['contrasena'],
    );
  }

  // Método copyWith
  Usuario copyWith({
    int? id,
    String? nombre,
    String? apellidos,
    String? correo,
    String? contrasena,
  }) {
    return Usuario(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      apellidos: apellidos ?? this.apellidos,
      correo: correo ?? this.correo,
      contrasena: contrasena ?? this.contrasena,
    );
  }
}