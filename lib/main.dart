import 'package:flutter/material.dart';
import 'package:flutter_application_1/caracteristicas/repositorio_verificacion.dart';
import 'package:flutter_application_1/caracteristicas/verificacion/bloc.dart';
import 'package:flutter_application_1/caracteristicas/vistas/vista-NombreNoConfirmado.dart';
import 'package:flutter_application_1/caracteristicas/vistas/vista-cargando.dart';
import 'package:flutter_application_1/caracteristicas/vistas/vista-solicitandoNombre.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'caracteristicas/vistas/vista-NombreConfirmado.dart';
import 'caracteristicas/vistas/vista-solicitud-actualizacion.dart';

void main() {
  runApp(const MiAplicacionInyectada());
}

class MiAplicacionInyectada extends StatelessWidget {
  const MiAplicacionInyectada({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) {
        BlocVerificacion blocVerificacion=BlocVerificacion(RepositorioReal());
        Future.delayed(Duration(seconds: 1),() {
          blocVerificacion.add(Creado());
        });
        return blocVerificacion;
  
      },
      child: Aplicacion(),
    );
    
  }
}


class Aplicacion extends StatelessWidget {
  const Aplicacion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplicacion',
      home: Scaffold(
        body: Builder(builder:((context) {
          var estado =context.watch<BlocVerificacion>().state;
          if(estado is Creandose){
            return  VistaCargando();
          }
          if(estado is SolicitandoNombre){
            return VistaSolicitandoNombre();
          }
          if(estado is MostrandoSolicitudActualizacion){
            return const VistaMostrandoSolicitudActualizacion();
          }
          if(estado is MostrandoNombreConfirmado){
            return NombreConfirmado(estado.registroUsuario);
          }
          if(estado is MostrandoNombreNoConfirmado){
            return NombreNoConfirmado(estado.nick);
          }
          if(estado is EsperandoConfirmacion){
            return VistaCargando();
          }
          return const Text('Huye');
        }),
      ),
    ));
  }
}