import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../verificacion/bloc.dart';

class VistaMostrandoSolicitudActualizacion extends StatelessWidget {
  const VistaMostrandoSolicitudActualizacion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text('Actualizate'),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: () {
              final elBloc = context.read<BlocVerificacion>();
              elBloc.add(Creado());
            },
            child: const Text('Regresar'),
          )
        ],
      ),
    );
  }
}
