
import 'package:flutter/material.dart';
import 'package:flutter_application_1/dominio/variable_dominio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../verificacion/bloc.dart';

class NombreNoConfirmado extends StatelessWidget {
  final NickFormado nick;
  const NombreNoConfirmado(this.nick,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Nombre no confirmado ${nick.valor}"),
        TextButton(onPressed: (){
          final elBloc = context.read<BlocVerificacion>();
              elBloc.add(Creado());
        }, child: const Text("Regresar"))
      ],
    );
  }
}