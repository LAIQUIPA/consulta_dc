import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
import 'package:intl/intl.dart';
import 'package:itse_validador/components/certificado_dialog.dart';

class Gsheets {
  static const _credentials = r'''
  {
    "type": "service_account",
    "project_id": "muniapp-402120",
    "private_key_id": "27eb7d6048415934608a92b26e1967ea68099977",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEuwIBADANBgkqhkiG9w0BAQEFAASCBKUwggShAgEAAoIBAQDVub0ObzsEqSUt\nWZB1bWsrMNCjdmQzL0UTxhm8fQ0J/Tr+iizUL3pSGR8hcthDKHrtdHmwZWcDrgXG\nDeF9N6eFeSpAcSvcowV7YrtyrtMktqYK163z3QBeYRaGks0ASfYBJFcc8IkATAcs\nqQytHkuSvBiMQ2Y4UrlyPv3gYh9o7DJaHSIOXRlT3WgW5fwjfVcrBcX1HObtyfJR\nFdzKCh5tT0Oi1tJZ59OsYoD5USsQ4/67pk9XkWzsmwgxeoffh+HX5OFcac8AtLUc\nO9WChmpea1FNzfi8br2kVXrgFbF2NL+engWYVij3uWTS1E2FsTlv9W8aXzTVjU1/\nwhLQKtqZAgMBAAECggEALKAfrYfkFtEKhjGRTDOQkPAcYEU0Hsvb7IkMjqK9ujw5\nuTQ4sAVJ0SKVsXI9XahyImqTjhVeMRKA+h2j23VncSMfg10d/2+6kUzIPuXqCFxq\nxxDJrYWTsiErhuXYEBthVlO0LMK8mGdHiDe0AeG1fenwZjkcet4rAoPMlrFmRY3K\nEM+Y/7GMliCYOyo3+15f/X7MidmKuGtU14P3e7XIixRz3/0hmf7E8mBLDBJowAsX\nWm/LQV7FDGhEtMACCRI/X5gO3UC+XF2QRbZbWPGmclXfvtIIeCE44EelZvW9RL4n\ntMQZ9Fqt8Ey2cuDBIZF90Fw6CutYkRkzVpZkIqExkQKBgQD3P5ZilCTQU9JeWYCI\nzx9Qs43syRQiy/yK0RHMDjb8axa8NRaZXBSoicjIxnNB7WiuCgYLW7gQ1OCB7eiX\nmhOINhIl/v9XlsJrif//w3q4T+Gfb7Flq6Sw++6galgdfU27LiVjHzNq4Abybs2M\nyQbjAFmVRkd8k9y4JZu1L/vKjwKBgQDdSmM+Z9afz636VDYsNaRhFy6f6dgKNn4P\nEf9xy/b4/BDjPT2vnc7/aXFu7nF2v+IlQ0PRBSpIWjrD+zG6OPPH0zkOVDgJdwse\noZmUWzOEfALPCgEzBAlDe0Sy0zi/QObI0YgmGBEdORjqR3SbIL3ONQ1TckLoSlZT\n8/jRJai8VwKBgQC4bRkK/UAcmXnA4PgslHriYpzJ9A9uCUSec2bYE/5V+LdjuiHa\nUUIjmWtIwCa3FZTQxS9PB6JcA75XjJPDia1qHBMbfoMO3ai2OKDZMgH3O7ari9AC\na68USUftJoYFsTLrHXfL4TkkTmlAKwBuNIFLkDZCT8MBHPY18e+cjmc95wKBgC4/\nusgzKY8S95iG+x94QpesIal4VRelVelOaKXe7AoTnG/xv6+xeq602elGWl5oMhp5\nmXXY74JZoUiOelEiUAjmY1lUTrXjtGY9ffycpwK8bFXbEG8aG9mHrM73CDgol1NH\nP34+r2z9HvDv6DX3vNOZEOTsz4D+8FXxeoIzrbVXAn8SaVriAxVb8LkKhQHCkI+w\nAwGDH7KVRfUC68+zQ+jHN+Auf+W4ZfUXl323SjPRdVrbCcga5fKp4ziqPdxd5ke0\na7X1ELTA89WAsV7s/akYVcRA+bYipSXZkyRsWG7NCos77gCCrBVo4zGrZRKsix4s\npCmxXsDAWplZumlTFCtO\n-----END PRIVATE KEY-----\n",
    "client_email": "muniapp@muniapp-402120.iam.gserviceaccount.com",
    "client_id": "104041216850047149762",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/muniapp%40muniapp-402120.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  }
  ''';

  //static const _spreadsheetId = '1Ax5ca4Lci2hluoO4ECy7YnpjatPsojzSkp5meK5t9fs';
  static const _spreadsheetId = '1N4Or6zbmPaN4BOvL-zS1Dszx5S98GxrFvEyKH3vR4J4';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _worksheet;
  static Spreadsheet? _ss;

  //AL INICIALIZAR
  Future initSheets() async {
    _ss = await _gsheets.spreadsheet(_spreadsheetId);
  }

  //Obtener datos de la fila exp del txtfield
  Future getDataList(String exp, String year, BuildContext context) async {
    //final ss = await _gsheets.spreadsheet(_spreadsheetId);
    _worksheet = _ss?.worksheetByTitle(year);
    //sig
    List? datalist = await _worksheet?.values.rowByKey(exp);
    if (datalist == null) {
      // ignore: use_build_context_synchronously
      return showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          //content: Text('NO EXISTE ESE CERTIFICADO'),
          alignment: Alignment.center,
          title: Text('NO EXISTE DATOS CON ESE EXPEDIENTE',
              textAlign: TextAlign.center),
        ),
      );
    }
    /*for (var i = 0; i <= 9; i++) {
      print(datalist![i]);
    }*/
    //return agregar;
    // ignore: use_build_context_synchronously
    return certificadoDialog(context,
        onCLosed: (_) {}, dataList: datalist, exp: exp, year: year);
  }
}

void displayMessage(String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(message),
    ),
  );
}

tranformarFecha(String fecha) {
  var epoch = DateTime(1899, 12, 30);
  DateTime currentDate = epoch.add(Duration(days: int.parse(fecha)));
  var fechaFinal = DateFormat('dd-MM-yyyy').format(currentDate);
  //print(fechaFinal);
  return fechaFinal;
}
