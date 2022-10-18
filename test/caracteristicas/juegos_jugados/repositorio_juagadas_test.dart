import 'package:flutter_application_1/caracteristicas/juegos_jugados/repositorio_juagadas.dart';
import 'package:flutter_application_1/dominio/juego_jugado.dart';
import 'package:flutter_application_1/dominio/variable_dominio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Benthor jugo 5 juegos', () async {
    RepositorioJuegosJugadosPruebas repositorio =
        RepositorioJuegosJugadosPruebas();
    final resultado = await repositorio
        .obtenerJugadasRegistradas(NickFormado.constructor('Benthor'));
    resultado.match((l) {
      expect(true, equals(false));
    }, (r) {
      expect(r.length, equals(5));
    });
  });

  test('Takenoko es de los jugados por Benthor', () async {
    RepositorioJuegosJugadosPruebas repositorio =
        RepositorioJuegosJugadosPruebas();
    final resultado = await repositorio
        .obtenerJugadasRegistradas(NickFormado.constructor('Benthor'));
    final takenoko = JuegoJugado.constructor(
        nombrePropuesto: 'Takenoko', idPropuesto: '70919');
    resultado.match((l) {
      expect(true, equals(false));
    }, (r) {
      expect(r.contains(takenoko), equals(true));
    });
  });

  test('Monopoly NO es de los jugados por Benthor', () async {
    RepositorioJuegosJugadosPruebas repositorio =
        RepositorioJuegosJugadosPruebas();
    final resultado = await repositorio
        .obtenerJugadasRegistradas(NickFormado.constructor('Benthor'));
    final monopoly = JuegoJugado.constructor(
        nombrePropuesto: 'Monopoly', idPropuesto: '918');
    resultado.match((l) {
      // expect(true, equals(false));
      assert(false);
    }, (r) {
      expect(!r.contains(monopoly), equals(true));
    });
  });
}
