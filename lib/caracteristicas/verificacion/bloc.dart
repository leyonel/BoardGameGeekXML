import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/caracteristicas/repositorio_verificacion.dart';
import 'package:flutter_application_1/dominio/problema.dart';
import 'package:flutter_application_1/dominio/registro_usuario.dart';
import 'package:flutter_application_1/dominio/variable_dominio.dart';

class Estado {}

class Creandose extends Estado {}

class SolicitandoNombre extends Estado {}

class EsperandoConfirmacion extends Estado {}

class MostrandoNombreConfirmado extends Estado {
  final RegistroUsuario registroUsuario;

  MostrandoNombreConfirmado(this.registroUsuario);
}

class MostrandoSolicitudActualizacion extends Estado {}

class MostrandoNombreNoConfirmado extends Estado {
  final NickFormado nick;

  MostrandoNombreNoConfirmado(this.nick);
}

class Evento {}

class Creado extends Evento {}

class NombreRecibido extends Evento {
  final NickFormado nick;
  NombreRecibido(this.nick);
}


class BlocVerificacion extends Bloc<Evento, Estado> {
  final repositorioVerificacion _repositorioVerificacion;
  BlocVerificacion(this._repositorioVerificacion) : super(Creandose()) {
    on<Creado>((event, emit) {
      emit(SolicitandoNombre());
    });
    on<NombreRecibido>((event, emit) async {
      emit(EsperandoConfirmacion());
      final resultado = await
          _repositorioVerificacion.obtenerRegistroUsuario(event.nick);
      resultado.match((l) {
        if (l is VersionIncorrectaXml) emit(MostrandoSolicitudActualizacion());
        if (l is UsuarioNoRegistrado)
          emit(MostrandoNombreNoConfirmado(event.nick));
      }, (r) {
        emit(MostrandoNombreConfirmado(r));
      });
    });
  }
}
