import 'package:aqua/servicos/servico_bluetooth.dart';
import 'package:aqua/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class TelaBibliotecaFiltro extends StatelessWidget {
  const TelaBibliotecaFiltro({super.key});

  @override
  Widget build(BuildContext context) {
    final ServicoBluetooth task =
        ServicoBluetooth.of(context, rebuildOnChange: false);
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
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text(
              'Peixe Betta:',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Alimentação e cuidados\n principais',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(217, 217, 217, 1),
                          decoration: TextDecoration.none,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 6, 0, 34),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'A criação de peixes Betta é muito simples,\n mas deve-se atentar a pequenos detalhes.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromRGBO(217, 217, 217, 1),
                            decoration: TextDecoration.none,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    'O peixe-betta é um peixe cuja boca é voltada para cima, fazendo-o se alimentar pela superície da água. Além disso, por se tratar de um peixe carnívoro, poucas porções tendem a satisfazê-los. ',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Color.fromRGBO(217, 217, 217, 1),
                      decoration: TextDecoration.none,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal,
                      fontSize: 13.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/biblioteca/imagem_um.png', width: 250,)
                        
                      ],
                    ),
                  ),
                  const Text(
                    'Em seu habitat natural, os bettas se alimentam de pequenas larvas que ficam na superfície de pântanos e arrozais. ',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Color.fromRGBO(217, 217, 217, 1),
                      decoration: TextDecoration.none,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal,
                      fontSize: 13.0,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                    child: Text(
                      'Um fato interessante é que o estômago do peixinho é aproximadamente do tamanho de seu olho, preferindo alimentar-se no período diurno, de duas a três vezes ao dia e, como já dito, em pequenas quantidades.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Color.fromRGBO(217, 217, 217, 1),
                        decoration: TextDecoration.none,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                    child: Text(
                      'A ração do peixe deve ser pequena para flutuar no aquário, respeitando o comportamento natural do peixe. Não há quantidade exata, mas é recomendado que seja dado o suficiente para o betta comer em cerca de dois a três minutos. ',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Color.fromRGBO(217, 217, 217, 1),
                        decoration: TextDecoration.none,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 12, 0, 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/biblioteca/imagem_dois.png', width: 250,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
           bottomNavigationBar: ScopedModel<ServicoBluetooth>(
                model: task,
                child: const Navbar(
                  index: 0,
                ))
        ),
      ],
    );
  }
}
