import 'package:aqua/servicos/servico_bluetooth.dart';
import 'package:aqua/telas/tela_configuracao.dart';
import 'package:aqua/widgets/navbar.dart';
import 'package:aqua/widgets/universal_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scoped_model/scoped_model.dart';

class TelaNotificacao extends StatefulWidget {
  const TelaNotificacao({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TelaNotificacaoState();
  }
}

class _TelaNotificacaoState extends State<TelaNotificacao> {
  List<Map<String, dynamic>> alarms = [
    {
      "text": "Lembrete:",
      "icon": 'assets/icones/comida.svg',
      "subtext": "Finalize as configurações da\nalimentação",
    },
    {
      "text": "Lembrete:",
      "icon": 'assets/icones/alarme.svg',
      "subtext": "Não se esqueça de fazer a \nlimpeza do aquário 1",
    },
    {
      "text": "Pontos",
      "icon": 'assets/icones/moedas.svg',
      "subtext": "Não se esqueça de colotar\nos pontos semanais",
    },
    {
      "text": "E-mail",
      "icon": 'assets/icones/email.svg',
      "subtext": "Realize a verificação do\ne-mail cadastrado",
    },
  ];

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
          bottomNavigationBar:
              ScopedModel<ServicoBluetooth>(model: task, child: const Navbar()),
          appBar: AppBar(
            title: const Text(
              'Notificações',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: IconButton(
                  icon: const Icon(Icons.settings_outlined),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScopedModel<ServicoBluetooth>(
                                model: task, child: const TelaConfiguracao())));
                  },
                  
                  color: const Color.fromARGB(255, 255, 255, 255),
                  tooltip: 'editar',
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(30, 24, 30, 0),
            child: ListView.builder(
              itemCount: alarms.length,
              itemBuilder: (context, index) {
                final alarm = alarms[index];
                return Dismissible(
                  key: Key(alarm['text'] + index.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      alarms.removeAt(index);
                    });
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                      child: UniversalCard(
                        padding: const EdgeInsets.fromLTRB(3, 6, 0, 6),
                        width: 328,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 12, 0),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                            width: 44,
                                            height: 44,
                                            child: ClipOval(
                                              child: Container(
                                                color: const Color.fromRGBO(
                                                    217, 217, 217, 0.20),
                                                width: 25,
                                                height: 25,
                                                child: Center(
                                                  child: SvgPicture.asset(
                                                      alarm['icon'].toString()),
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(width: 10),
                                      Text(
                                        alarm['text'],
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(
                                          height:
                                              3), // Espaço entre o texto e o subtexto
                                      Text(
                                        alarm[
                                            'subtext'], // Subtexto dinâmico para cada alarme
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Color.fromARGB(255, 255, 255,
                                                255)), // Estilo do subtexto
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
