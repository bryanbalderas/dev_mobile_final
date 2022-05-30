class Dentista {
  final int id;
  final String nombre;
  final int telefono;

  const Dentista({
    required this.id,
    required this.nombre,
    required this.telefono,
  });

  factory Dentista.fromJson(Map<String, dynamic> json) {
    return Dentista(
      id: json['id'],
      nombre: json['nombre'],
      telefono: int.parse(json['telefono']),
    );
  }
}
