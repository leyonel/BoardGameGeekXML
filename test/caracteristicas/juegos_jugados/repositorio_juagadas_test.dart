import 'package:flutter_application_1/caracteristicas/juegos_jugados/repositorio_juagadas.dart';
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
      expect(resultado.length(), equals(5));
    });
  });
}
