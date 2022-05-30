class Cita {
  final String fecha;
  final int hora;
  final bool is_atendido;
  final int user_id;
  final int id;
  final String tipo_cita;

  const Cita({
    required this.user_id,
    required this.hora,
    required this.fecha,
    required this.is_atendido,
    required this.id,
    required this.tipo_cita,
  });

  factory Cita.fromJson(Map<String, dynamic> json) {
    return Cita(
      fecha: json['fecha'],
      hora: json['hora'],
      is_atendido: json['is_atendido'],
      user_id: json['user_id'],
      id: json['id'],
      tipo_cita: json['tipo_cita'],
    );
  }
}
