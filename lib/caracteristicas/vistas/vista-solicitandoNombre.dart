import 'package:flutter/material.dart';
import 'package:flutter_application_1/caracteristicas/verificacion/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dominio/variable_dominio.dart';

class VistaSolicitandoNombre extends StatefulWidget {
  const VistaSolicitandoNombre({Key? key}) : super(key: key);

  @override
  State<VistaSolicitandoNombre> createState() => _VistaSolicitandoNombreState();
}

class _VistaSolicitandoNombreState extends State<VistaSolicitandoNombre> {
  bool _usuarioValidado = false;
  late final TextEditingController controlador;

  @override
  void initState() {
    controlador = TextEditingController();
    controlador.addListener(escuchadorValidador);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controlador.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final elBloc = context.read<BlocVerificacion>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter a search term',
          ),
          controller: controlador,
        ),
        Container(
            child: _usuarioValidado
                ? null
                : TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.grey),
                    ),
                    onPressed: null,
                    child: const Text('Ingresar'),
                  )),
        Container(
            child: !_usuarioValidado
                ? null
                : TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    onPressed: () {
                      elBloc.add(NombreRecibido(NickFormado.constructor(controlador.text)));
                    },
                    child: const Text('Ingresar'),
                  )),
        Container(
          child: Text(controlador.text),
        )
      ]),
    );
  }

  void escuchadorValidador() {
    setState(() {
      try {
        NickFormado.constructor(controlador.text);
        _usuarioValidado = true;
      } catch (e) {
        _usuarioValidado = false;
      }
    });
  }
}
