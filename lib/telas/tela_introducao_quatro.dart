// ignore_for_file: unused_import

import 'package:aqua/telas/autenticador.dart';
import 'package:aqua/telas/tela_cadastro_aquario.dart';
import 'package:aqua/telas/tela_conexao.dart';
import 'package:aqua/telas/tela_introducao_dois.dart';
import 'package:flutter/material.dart';

class TelaIntroducaoQuatro extends StatelessWidget {
  const TelaIntroducaoQuatro({super.key});

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
                        'assets/images/introducao/quarta_introducao.png'),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30),
              child: 
               
                
                    Text(
                       'Ponto para cuidar dos\n seus aquários e pets à\n distância?',
                       textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        decoration: TextDecoration.none,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w100,
                        fontSize: 24.0,
                      ),
                   
                ),
              
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Autenticador()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 147, 30),
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                      ),
                      fixedSize: const Size(236, 46),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            50.0), // Adjust the radius as needed
                      ),
                    ),
                    child: const Text('Pronto'),
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
