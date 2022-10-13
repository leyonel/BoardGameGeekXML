import 'package:flutter_application_1/dominio/problema.dart';

class JuegoJugado {
  final String nombre;
  final String id;

  JuegoJugado._({required this.nombre, required this.id});

  factory JuegoJugado.constructor(
      {required String nombrePropuesto, idPropuesto}) {
    if (nombrePropuesto.trim().isEmpty) throw JuegoJugadoMalFormado();
    if (idPropuesto.trim().isEmpty) throw JuegoJugadoMalFormado();
    return JuegoJugado._(nombre: nombrePropuesto, id: idPropuesto);
  }

  @override
  bool operator ==(covariant JuegoJugado other) {
    if (identical(this, other)) return true;

    return other.nombre == nombre && other.id == id;
  }

  @override
  int get hashCode => nombre.hashCode ^ id.hashCode;
}
