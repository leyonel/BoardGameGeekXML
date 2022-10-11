import 'package:flutter_application_1/dominio/registro_usuario.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Registro usuario...', (tester) async {
      final RegistroUsuario r = RegistroUsuario.constructor(
          propuestaAnio: "2012",
          propuestaNombre: 'x',
          propuestaApellido: 's',
          propuestaPais: 'p',
          propuestaEstado: 'm');
      expect(r.anioRegistro, equals(2012)
     );
    });
  }

