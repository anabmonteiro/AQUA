import 'package:aqua/servicos/servico_bluetooth.dart';
import 'package:aqua/telas/tela_configuracao.dart';
import 'package:aqua/telas/tela_notificacao.dart';
import 'package:aqua/widgets/navbar.dart';
import 'package:aqua/widgets/universal_card.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math';

import 'package:scoped_model/scoped_model.dart';

class TelaPontos extends StatefulWidget {
  const TelaPontos({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TelaPontosState();
  }
}

class _TelaPontosState extends State<TelaPontos> {
  late ConfettiController _confettiController;
  
  Color cardColor = Colors.blue;
  Widget trocaIcon = const Text(
    '20',
    style: TextStyle(
      color: Color.fromARGB(255, 255, 255, 255),
      decoration: TextDecoration.none,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      fontSize: 18.0,
    ),
  );
  Color coletadoColor = Colors.blue;
  String coletadoTexto = 'Coletar';
  Color coletadoTextoColor = Colors.white;
  String pontos = '140';
  double coletadoSize= 12;

  
  void changeColorAndText() {
    setState(() {
      coletadoSize = 10;
      pontos = '160';
      coletadoTextoColor = const Color.fromRGBO(133, 135, 137, 1);
      coletadoTexto = 'Coletado';
      coletadoColor = Colors.white;
      cardColor = const Color.fromARGB(
          255, 255, 255, 255); 
      trocaIcon = const Icon(
        Icons.check_rounded,
        size: 30,
        color: Color.fromRGBO(133, 135, 137, 1),
      ); 
    });
  }

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

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
              centerTitle: true,
              title: const Text(
                'Meus Pontos',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notification_add_outlined),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScopedModel<ServicoBluetooth>(
                                model: task, child: const TelaNotificacao())));
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.settings_outlined),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScopedModel<ServicoBluetooth>(
                                model: task, child: const TelaConfiguracao())));
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  width: 360,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            pontos,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              decoration: TextDecoration.none,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 90.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: SvgPicture.asset(
                              'assets/icones/moedas_pontos.svg',
                              height: 27,
                              width: 27,
                              colorFilter: const ColorFilter.mode(
                                  Color.fromRGBO(255, 147, 30, 1),
                                  BlendMode.srcIn),
                            ),
                            // Cor do ícone
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: UniversalCard(
                          width: 360,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(23)),
                          title: const Padding(
                            padding: EdgeInsets.fromLTRB(12, 6, 12, 12),
                            child: Text(
                              'Check-in semanal',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                decoration: TextDecoration.none,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.normal,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  changeColorAndText();
                                  _confettiController.play();
                                },
                                child: UniversalCard(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 9, 0, 0),
                                  width: 64,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: cardColor,
                                          ),
                                          child: Center(
                                            child: trocaIcon,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 9, 0, 0),
                                        child: SizedBox(
                                          width: 64,
                                          height: 17,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(
                                                                10)),
                                                shape: BoxShape.rectangle,
                                                color: coletadoColor),
                                            child: Center(
                                              child: Text(
                                                coletadoTexto,
                                                style: TextStyle(
                                                  color: coletadoTextoColor,
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: coletadoSize,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              UniversalCard(
                                padding: const EdgeInsets.fromLTRB(0, 9, 0, 0),
                                width: 64,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color.fromARGB(
                                                255, 133, 135, 137)),
                                        child: const Center(
                                          child: Text(
                                            '20',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              decoration: TextDecoration.none,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 9, 0, 0),
                                      child: SizedBox(
                                        width: 64,
                                        height: 17,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10)),
                                              shape: BoxShape.rectangle,
                                              color: Color.fromARGB(
                                                  255, 133, 135, 137)),
                                          child: const Center(
                                            child: Text(
                                              'Coletar',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                decoration: TextDecoration.none,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              UniversalCard(
                                padding: const EdgeInsets.fromLTRB(0, 9, 0, 0),
                                width: 64,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color.fromARGB(
                                                255, 133, 135, 137)),
                                        child: const Center(
                                          child: Text(
                                            '20',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              decoration: TextDecoration.none,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 9, 0, 0),
                                      child: SizedBox(
                                        width: 64,
                                        height: 17,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10)),
                                              shape: BoxShape.rectangle,
                                              color: Color.fromARGB(
                                                  255, 133, 135, 137)),
                                          child: const Center(
                                            child: Text(
                                              'Coletar',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                decoration: TextDecoration.none,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              UniversalCard(
                                padding: const EdgeInsets.fromLTRB(0, 9, 0, 0),
                                width: 64,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color.fromARGB(
                                                255, 133, 135, 137)),
                                        child: const Center(
                                          child: Text(
                                            '20',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              decoration: TextDecoration.none,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 9, 0, 0),
                                      child: SizedBox(
                                        width: 64,
                                        height: 17,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10)),
                                              shape: BoxShape.rectangle,
                                              color: Color.fromARGB(
                                                  255, 133, 135, 137)),
                                          child: const Center(
                                            child: Text(
                                              'Coletar',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                decoration: TextDecoration.none,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 27, 0, 0),
                            child: Text(
                              'Recompensas',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                decoration: TextDecoration.none,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Row(
                        children: [
                          Text(
                            'Troque seus pontos por cupons de desconto!',
                            style: TextStyle(
                              color: Color.fromARGB(200, 255, 255, 255),
                              decoration: TextDecoration.none,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Image.asset(
                                'assets/images/cupom/cupom_desconto.png'),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Image.asset(
                                'assets/images/cupom/cupom_desconto.png'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar:  ScopedModel<ServicoBluetooth>(
                model: task,
                child: const Navbar(
                  index: 2,
                ))),
        ConfettiWidget(
           blastDirection: pi, // Direção horizontal
          numberOfParticles: 30,
          confettiController: _confettiController,
          blastDirectionality: BlastDirectionality.explosive,
          shouldLoop: false,
          colors: const [
            Colors.green,
            Colors.blue,
            Colors.pink,
            Colors.orange,
            Colors.purple
          ],
        ),
      ],
    );
  }
}
