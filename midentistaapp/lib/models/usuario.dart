class Usuario {
  final int id;
  final String name;
  final String email;
  final String password;
  final int edad;
  final int telefono;
  final String domicilio;
  final int dentista_id;

  const Usuario({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.edad,
    required this.telefono,
    required this.domicilio,
    required this.dentista_id,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      edad: json['edad'],
      telefono: json['telefono'],
      domicilio: json['domicilio'],
      dentista_id: json['dentista_id'],
    );
  }
}
