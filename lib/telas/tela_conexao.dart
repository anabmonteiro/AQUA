import 'package:aqua/telas/tela_selecionar_aquario.dart';
import 'package:flutter/material.dart';

class TelaConexao extends StatelessWidget {
  final bool userData;
const TelaConexao({ super.key , required this.userData});

  @override
  Widget build(BuildContext context){
    print(userData);
    return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/fundo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
               TelaSelecionarAquario(checkAvailability: true, userData: userData)
            ],
          );
  }
}