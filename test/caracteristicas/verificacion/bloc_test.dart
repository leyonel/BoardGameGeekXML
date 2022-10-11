import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_application_1/caracteristicas/repositorio_verificacion.dart';
import 'package:flutter_application_1/caracteristicas/verificacion/bloc.dart';
import 'package:flutter_application_1/dominio/variable_dominio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  blocTest<BlocVerificacion, Estado>(
    'emits [MyState] when MyEvent is added.',
    build: () => BlocVerificacion(RepositorioPruebasVerificacion()),
    act: (bloc) => bloc.add(Creado()),
    expect: () => [isA<SolicitandoNombre>()],
  );

  blocTest<BlocVerificacion, Estado>(
    'CUando NOmbre recibido es Benthor debo de tener Mostando nombre confirmado',
    build: () => BlocVerificacion(RepositorioPruebasVerificacion()),
    act: (bloc) => bloc.add(NombreRecibido(NickFormado.constructor('benthor'))),
    expect: () => [isA<EsperandoConfirmacion>(),isA<MostrandoNombreConfirmado>()],
  );

  blocTest<BlocVerificacion, Estado>(
    'CUando NOmbre recibido es AMLO debo de tener Mostando nombre no confirmado',
    build: () => BlocVerificacion(RepositorioPruebasVerificacion()),
    act: (bloc) => bloc.add(NombreRecibido(NickFormado.constructor('amlo'))),
    expect: () => [isA<EsperandoConfirmacion>(),isA<MostrandoNombreNoConfirmado>()],
  );

  blocTest<BlocVerificacion, Estado>(
    'CUando NOmbre recibido es incorrecto debo tener MostrarSolicitudActualizacion',
    build: () => BlocVerificacion(RepositorioPruebasVerificacion()),
    seed: ()=>SolicitandoNombre(),
    act: (bloc) => bloc.add(NombreRecibido(NickFormado.constructor('incorrecta'))),
    expect: () => [isA<EsperandoConfirmacion>(),isA<MostrandoSolicitudActualizacion>()],
  );

}
