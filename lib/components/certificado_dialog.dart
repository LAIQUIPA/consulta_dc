//import 'dart:ffi';

import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
//import 'package:flutter_svg/flutter_svg.dart';

//import 'sign_in_form.dart';

Future<Object?> certificadoDialog(BuildContext context,
    {required ValueChanged onCLosed,
    required dataList,
    required String exp,
    required String year}) {
  return showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: "Main",
    barrierColor: Colors.black.withOpacity(0.5),
    context: context,
    transitionDuration: const Duration(milliseconds: 1000),
    transitionBuilder: (_, animation, __, child) {
      Tween<Offset> tween;
      tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
      return SlideTransition(
        position: tween.animate(
          CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        ),
        child: child,
      );
    },
    pageBuilder: (context, _, __) => Center(
      child: Container(
        height: 580,
        //width: 400,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.amber.shade50.withOpacity(0.94),
          border: Border.all(color: Colors.blue.shade200, width: 10),
          borderRadius: const BorderRadius.all(Radius.circular(40)),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            clipBehavior: Clip.none,
            children: [
              //logo Municipalidad
              Positioned(
                left: 0,
                right: 0,
                top: -70,
                child: Icon(
                  Icons.bookmark,
                  size: 60,
                  color: Colors.blue[400],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: -30,
                child: Image.asset(
                  "lib/images/LOGOPN.png",
                  width: 80,
                  height: 80,
                ),
              ),

              //Datos del certificado
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //certificado tipo
                      Text(
                        "CERTIFICADO DE INSPECCION TECNICA DE SEGURIDAD EN EDIFICACIONES",
                        textAlign: TextAlign.center,
                        /*style: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: FontWeight.bold),*/
                      ),
                      //Numero de certificado
                      Center(
                        child: Text(
                          //"N° ${dataList[31].toString()}-${ObtenerYear(dataList[32])}",
                          'N° ${dataList[0]} - ${ObtenerYear(dataList[7])}',
                          textAlign: TextAlign.center,
                          /*style: GoogleFonts.poppins(
                              fontSize: 20, fontWeight: FontWeight.bold),*/
                        ),
                      ),
                      const Row(
                        children: [
                          Expanded(child: Divider(color: Colors.blue)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "•",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          Expanded(
                              child: Divider(
                            color: Colors.blue,
                          )),
                        ],
                      ),

                      //NOMBRE COMERCIAL
                      Center(
                        child: Column(
                          children: [
                            Text(
                              '"${dataList[1]}"',
                              textAlign: TextAlign.center,
                              /*style: GoogleFonts.poppins(
                                  fontSize: 24, fontWeight: FontWeight.bold),*/
                            ),
                            Text(
                              '(Nombre Comercial)',
                              /*style: GoogleFonts.poppins(
                                  fontSize: 7, fontStyle: FontStyle.italic),*/
                            ),
                          ],
                        ),
                      ),

                      //Direccion
                      FilaFormato(
                        textoprevio: 'Dirección :',
                        certDatos: dataList[2].toString().trim(),
                      ),

                      //DISTRITO, PROVINCIA, DEPARTAMENTO
                      const FilaFormato(
                          textoprevio: 'Distrito: ', certDatos: 'PUNTA NEGRA'),
                      const Row(
                        children: [
                          FilaFormato(
                              textoprevio: 'Provincia: ', certDatos: 'LIMA'),
                          SizedBox(
                            width: 12,
                          ),
                          FilaFormato(
                              textoprevio: 'Departamento: ', certDatos: 'LIMA'),
                        ],
                      ),

                      //Solicitado Por:
                      FilaFormato(
                          textoprevio: 'Solicitado por: ',
                          certDatos: dataList[3]),

                      //Aforo
                      FilaFormato(
                          textoprevio: 'Aforo: ', certDatos: dataList[4]),

                      //Giro
                      FilaFormato(
                          textoprevio: 'Giro: ', certDatos: dataList[5]),

                      //Exp
                      FilaFormato(
                          textoprevio: 'Exp: ', certDatos: '$exp-$year'),

                      //Resolucion
                      FilaFormato(
                          textoprevio: 'Resolución: ',
                          certDatos:
                              //'${dataList[7]}-${ObtenerYear(dataList[8])}-SGGRD-GDT/MDPN'),
                              '${dataList[6]}-${ObtenerYear(dataList[7])}-SGGRD-GDT/MDPN'),

                      //FECHA EXPEDICION, RENOV, CADUC
                      FilaFormato(
                          textoprevio: 'Fecha de Expedición: ',
                          certDatos: tranformarFecha(dataList[7])),
                      FilaFormato(
                          textoprevio: 'Fecha de Renovación: ',
                          certDatos: tranformarFecha(dataList[8])),
                      FilaFormato(
                          textoprevio: 'Fecha de Caducidad: ',
                          certDatos: tranformarFecha(dataList[9])),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ).then(onCLosed);
}

ObtenerYear(String fecha) {
  var epoch = DateTime(1899, 12, 30);
  DateTime currentDate = epoch.add(Duration(days: int.parse(fecha)));
  var fechaFinal = DateFormat('yyyy').format(currentDate);
  print(fechaFinal);
  return fechaFinal;
}

tranformarFecha(String fecha) {
  var epoch = DateTime(1899, 12, 30);
  DateTime currentDate = epoch.add(Duration(days: int.parse(fecha)));
  var fechaFinal = DateFormat('dd-MM-yyyy').format(currentDate);
  print(fechaFinal);
  return fechaFinal;
}

class FilaFormato extends StatelessWidget {
  final String textoprevio;
  final String certDatos;

  const FilaFormato({
    super.key,
    required this.textoprevio,
    required this.certDatos,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Text(
          textoprevio,
          /*style: GoogleFonts.poppins(fontSize: 14),*/
        ),
        Text(
          certDatos,
          /*style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold),*/
        ),
      ],
    );
  }
}
