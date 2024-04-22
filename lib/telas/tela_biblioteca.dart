import 'package:aqua/servicos/servico_bluetooth.dart';
import 'package:aqua/telas/tela_configuracao.dart';
import 'package:aqua/telas/tela_notificacao.dart';
import 'package:aqua/widgets/biblioteca_filtro_alimentacao.dart';
import 'package:aqua/widgets/navbar.dart';
import 'package:aqua/widgets/universal_card.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class TelaBiblioteca extends StatefulWidget {
  const TelaBiblioteca({super.key});

  @override
  _TelaBibliotecaState createState() => _TelaBibliotecaState();
}

class _TelaBibliotecaState extends State<TelaBiblioteca> {
  Color cardColor = const Color.fromRGBO(0, 18, 25, 1);
  String iconColor = 'assets/images/biblioteca/icone_alimentacao.png';
  Color textColor = Colors.white;
  FontWeight grossuraFonte = FontWeight.w300;

  Widget listaImagens = Column(
    children: [
      Image.asset('assets/images/biblioteca/imagem_tres.png'),
      Image.asset('assets/images/biblioteca/imagem_quatro.png'),
      Image.asset('assets/images/biblioteca/imagem_cinco.png'),
      Image.asset('assets/images/biblioteca/imagem_seis.png'),
    ],
  );
  bool filtrado = false;
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
                'Biblioteca',
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
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Column(
                  children: [
                    const UniversalCard(
                        padding: EdgeInsets.fromLTRB(12, 8, 3, 8),
                        color: Colors.white,
                        width: 329,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 6, 0),
                              child: Icon(
                                Icons.search_rounded,
                                color: Color.fromRGBO(87, 87, 87, 1),
                              ),
                            ),
                            Text(
                              'Pesquisar',
                              style: TextStyle(
                                  color: Color.fromRGBO(87, 87, 87, 1),
                                  fontSize: 16),
                            ),
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  filtrado = !filtrado;
                                  if (filtrado) {
                                    cardColor = Colors.white;
                                    iconColor =
                                        'assets/images/biblioteca/icone_alimentacao_clicado.png';
                                    textColor =
                                        const Color.fromRGBO(0, 18, 25, 1);
                                    grossuraFonte = FontWeight.w600;
                                  } else {
                                    cardColor =
                                        const Color.fromRGBO(0, 18, 25, 1);
                                    iconColor =
                                        'assets/images/biblioteca/icone_alimentacao.png';
                                    textColor = Colors.white;
                                    grossuraFonte = FontWeight.w300;
                                  }
                                });
                              },
                              child: UniversalCard(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                padding: const EdgeInsets.fromLTRB(6, 6, 6, 6),
                                width: 157,
                                color: cardColor,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(25)),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      iconColor,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          12, 0, 0, 0),
                                      child: Text(
                                        'Alimentação',
                                        style: TextStyle(
                                          color: textColor,
                                          decoration: TextDecoration.none,
                                          fontFamily: 'Poppins',
                                          fontWeight: grossuraFonte,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            UniversalCard(
                              borderSide: const BorderSide(color: Colors.white),
                              padding: const EdgeInsets.fromLTRB(6, 6, 6, 6),
                              width: 126,
                              color: const Color.fromRGBO(0, 18, 25, 1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25)),
                              child: Row(
                                children: [
                                  Image.asset(
                                      'assets/images/biblioteca/icone_limpeza.png'),
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                                    child: Text(
                                      'Limpeza',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        decoration: TextDecoration.none,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            UniversalCard(
                              borderSide: const BorderSide(color: Colors.white),
                              padding: const EdgeInsets.fromLTRB(6, 6, 6, 6),
                              width: 114,
                              color: const Color.fromRGBO(0, 18, 25, 1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25)),
                              child: Row(
                                children: [
                                  Image.asset(
                                      'assets/images/biblioteca/icone_betta.png'),
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                                    child: Text(
                                      'Betta',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        decoration: TextDecoration.none,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14.0,
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
                    filtrado ? const FiltroAlimentacao() : listaImagens
                  ],
                ),
              ),
            ),
            bottomNavigationBar: ScopedModel<ServicoBluetooth>(
                model: task,
                child: const Navbar(
                  index: 0,
                ))),
      ],
    );
  }
}
