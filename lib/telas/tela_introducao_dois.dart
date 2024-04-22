// ignore_for_file: unused_import

import 'package:aqua/telas/autenticador.dart';
import 'package:aqua/telas/tela_cadastro_aquario.dart';
import 'package:aqua/telas/tela_conexao.dart';
import 'package:aqua/telas/tela_introducao_dois.dart';
import 'package:flutter/material.dart';

class TelaIntroducaoDois extends StatelessWidget {
  const TelaIntroducaoDois({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: SafeArea(
                top: true,
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Image.asset(
                        'assets/images/introducao/segunda_introducao.png'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: '2º Passo: ',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 147, 30),
                        decoration: TextDecoration.none,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w100,
                        fontSize: 24.0,
                      ),
                    ),
                    TextSpan(
                      text: 'conect o\n bluetooth ao seu \naparelho Aqua',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        decoration: TextDecoration.none,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w100,
                        fontSize: 24.0,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Autenticador(),
                        ));
                  },
                  child: const Text(
                    'Pular',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
