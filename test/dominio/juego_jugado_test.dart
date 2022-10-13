import 'package:flutter_application_1/dominio/juego_jugado.dart';
import 'package:flutter_application_1/dominio/problema.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Mismo nombre diferente id son diferentes', () {
    JuegoJugado j1 =
        JuegoJugado.constructor(nombrePropuesto: 'uno', idPropuesto: '1');
    JuegoJugado j2 =
        JuegoJugado.constructor(nombrePropuesto: 'uno', idPropuesto: '2');

    expect(j1 == j2, equals(false));
  });

  test('Mismo nombre mismo id son iguales', () {
    JuegoJugado j1 =
        JuegoJugado.constructor(nombrePropuesto: 'uno', idPropuesto: '1');
    JuegoJugado j2 =
        JuegoJugado.constructor(nombrePropuesto: 'uno', idPropuesto: '1');

    expect(j1 == j2, equals(true));
  });

  test('No se permite id vacio', () {
    expect(
        () => JuegoJugado.constructor(nombrePropuesto: 'j1', idPropuesto: ''),
        throwsA(isA<JuegoJugadoMalFormado>()));
  });

  test('No se permite nombre vacio', () {
    expect(() => JuegoJugado.constructor(nombrePropuesto: '', idPropuesto: '1'),
        throwsA(isA<JuegoJugadoMalFormado>()));
  });
}
