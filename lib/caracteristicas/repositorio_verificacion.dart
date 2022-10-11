import 'package:flutter_application_1/dominio/registro_usuario.dart';
import 'package:flutter_application_1/dominio/variable_dominio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_application_1/dominio/problema.dart';
import 'package:xml/xml.dart';
import 'package:http/http.dart' as http;
abstract class repositorioVerificacion {
  Future <Either<Problema, RegistroUsuario>> obtenerRegistroUsuario(NickFormado nick);
}

List campos = [
  'yearregistered',
  'firstname',
  'stateorprovince',
  'country',
  'lastname'
];

class RepositorioReal extends repositorioVerificacion{
  @override
  Future<Either<Problema, RegistroUsuario>> obtenerRegistroUsuario(NickFormado nick) async{
    final resultado = await _obtenerXmlReal(nick.valor);
    return resultado.match((l) => Left(l), (r) {
      XmlDocument documento = XmlDocument.parse(r);
      final registro = obtenerRegistroUsuarioDesdeXML(documento);
      return registro.match((l) =>  Left(l), (r) => Right(r));
    });
  }
  
  Future <Either<Problema,String>>_obtenerXmlReal(String valor) async {
    Uri direccion = Uri.https('www.boardgamegeek.com', 'xmlapi2/user', {'name':valor});
    final respuesta = await http.get(direccion);
    if(respuesta.statusCode!=200){
      return Left(ServidorNoAlcanzado());
    }
    return Right(respuesta.body);
  }

}


class RepositorioPruebasVerificacion extends repositorioVerificacion {
  final String _benthor = """ <?xml version="1.0" encoding="utf-8"?>
      <user id="597373" name="benthor" termsofuse="https://boardgamegeek.com/xmlapi/termsofuse">
										<firstname value="Benthor" />	
                    		<lastname value="Benthor" />	
                    		<avatarlink value="N/A" />	
                        		<yearregistered value="2012" />			
                    <lastlogin value="2022-05-31" />	
                    		<stateorprovince value="" />		
                        	<country value="" />		
                          	<webaddress value="" />		
                            	<xboxaccount value="" />	
                              		<wiiaccount value="" />		
                                  	<psnaccount value="" />	
                                    		<battlenetaccount value="" />	
                                        		<steamaccount value="" />		
                                            	<traderating value="0" />	
				</user> """;

  final String _incorrecta = """ <?xml version="1.0" encoding="utf-8"?>
      <user id="597373" name="benthor" termsofuse="https://boardgamegeek.com/xmlapi/termsofuse">
										<firstsname value="Benthor" />	
                    		<lashgvcfgcame value="Benthor" />	
                    		<avataralink value="N/A" />	
                        		<yearsregistered value="2012" />			
                    <lastlogin vaaalue="2022-05-31" />	
                    		<statfeorpcarovince value="" />		
                        	<coundtry value="" />		
                          	<webadfdress value="" />		
                            	<xboxacccount value="" />	
                              		<wiicaccount value="" />		
                                  	<psnaxccount value="" />	
                                    		<battxlenetaccount value="" />	
                                        		<stecaamaccount value="" />		
                                            	<traderacating value="0" />	
				</user> """;

  final String _amlo =
      """<?xml version="1.0" encoding="utf-8"?><user id="" name="" termsofuse="https://boardgamegeek.com/xmlapi/termsofuse">
										<firstname value="" />			<lastname value="" />			<avatarlink value="N/A" />			<yearregistered value="" />			<lastlogin value="" />			<stateorprovince value="" />			<country value="" />			<webaddress value="" />			<xboxaccount value="" />			<wiiaccount value="" />			<psnaccount value="" />			<battlenetaccount value="" />			<steamaccount value="" />			<traderating value="362" />	
				</user> """;

  
    
    
    // const campoValor = 'value';

    // var x = documento.findAllElements(campo).first.getAttribute(campoValor);

    // return documento.findAllElements(campo).first.getAttribute(campoValor) ??
    //     '';
  

  @override
  Future <Either<Problema, RegistroUsuario>> obtenerRegistroUsuario(NickFormado nick) {
    if (nick.valor == 'benthor') {
      final documento = XmlDocument.parse(_benthor);
      return Future.value(obtenerRegistroUsuarioDesdeXML(documento));
    }
    if (nick.valor == 'amlo') {
      final documento = XmlDocument.parse(_amlo);
      return Future.value(obtenerRegistroUsuarioDesdeXML(documento));
    }
    if (nick.valor == 'incorrecta') {
      final documento = XmlDocument.parse(_incorrecta);
      return Future.value(obtenerRegistroUsuarioDesdeXML(documento));
    }

    return Future.value(Left(UsuarioNoRegistrado()));
  }
}

Either<Problema, RegistroUsuario> obtenerRegistroUsuarioDesdeXML(
      XmlDocument documento) {
    const campoAnio = 'yearregistered';
    const campoValor = 'value';
    const campoNombre = 'firstname';
    const campoEstado = 'stateorprovince';
    const campoPais = 'country';
    const campoApellidos = 'lastname';

    
    final anioRegistrado = obtenerValorCampo(documento, campoAnio);

    

    Either <Problema,String> nombre = obtenerValorCampo(documento, campoNombre);
    Either <Problema,String> pais = obtenerValorCampo(documento, campoPais);
    Either <Problema,String> estado = obtenerValorCampo(documento, campoEstado);
    Either <Problema,String> apellido = obtenerValorCampo(documento, campoApellidos);

    if([anioRegistrado, nombre, pais, estado, apellido]
        .any((element) => element.isLeft())){
          return left(VersionIncorrectaXml());
        }
    final valoresRegistro = [anioRegistrado, apellido, estado, nombre, pais]
      .map((e) => e.getOrElse((l) => ''))
      .toList();
      if(valoresRegistro[0].isEmpty){
        return left(UsuarioNoRegistrado());
      }    
      return Right(
        RegistroUsuario.constructor(
          propuestaAnio: valoresRegistro[0], 
          propuestaNombre: valoresRegistro[3], 
          propuestaApellido: valoresRegistro[1], 
          propuestaPais: valoresRegistro[4], 
          propuestaEstado: valoresRegistro[2])
      );
      

    // return Right(RegistroUsuario.constructor(
    //   propuestaAnio: anioRegistrado,
    //   propuestaNombre: nombre,
    //   propuestaApellido: apellido,
    //   propuestaEstado: estado,
    //   propuestaPais: pais,
    // ));
  }

  Either<Problema,String> obtenerValorCampo(XmlDocument documento, String campo) {
    const atributoValor = 'value';
    final valoresEncontrados = documento.findAllElements(campo);
    if(valoresEncontrados.isEmpty) return Left(VersionIncorrectaXml());

    final String? valorARegresar = 
      valoresEncontrados.first.getAttribute(atributoValor);

    if(valorARegresar == null){
      return Left(VersionIncorrectaXml());
    }   
    return Right(valorARegresar);

   }