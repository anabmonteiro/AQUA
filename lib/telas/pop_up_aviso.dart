import 'package:aqua/telas/tela_meus_aquarios.dart';
import 'package:flutter/material.dart';

class PopUpAviso extends StatelessWidget {
  const PopUpAviso({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromRGBO(82, 84, 87, 0.98),
      surfaceTintColor: Colors.transparent,
      title: const Text(
        'ATENÇÃO',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 24),
            child: Icon(
              Icons.error_outline_rounded,
              size: 71,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 24),
            child: Text(
                'Por questões de segurança e incompatibilidade, informamos que é contraindicado colocar dois bettas em um mesmo aquário',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(217, 217, 217, 0.35),
              foregroundColor: Colors.white,
              textStyle: const TextStyle(
                decoration: TextDecoration.none,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 20.0,
              ),
              fixedSize: const Size(210, 46),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
            child: const Text('Concordo'),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
            child: Text('Saiba mais',
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                )),
          )
        ],
      ),
    );
  }
}
