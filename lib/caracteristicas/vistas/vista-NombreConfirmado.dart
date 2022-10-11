import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/dominio/registro_usuario.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../verificacion/bloc.dart';

class NombreConfirmado extends StatelessWidget {
  final RegistroUsuario registro;
  const NombreConfirmado(this.registro,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Nombre: ${registro.nombre}'),
        Text('Apellido: ${registro.apellido}'),
        Text('Año de registro: ${registro.anioRegistro}'),
        Text('Pais: ${registro.pais}'),
        Text('Estado: ${registro.estado}'),
        TextButton(onPressed: (){
            final elBloc = context.read<BlocVerificacion>();
              elBloc.add(Creado());

        }, child: Text("Regresar"))
      ],
    );
  }
}