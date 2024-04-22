import 'package:aqua/servicos/servico_bluetooth.dart';
import 'package:aqua/telas/tela_configuracao_clara.dart';
import 'package:aqua/telas/tela_notificacao.dart';
import 'package:aqua/widgets/navbar.dart';
import 'package:aqua/widgets/switch.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class TelaConfiguracao extends StatefulWidget {
  const TelaConfiguracao({super.key});

  @override
  State<TelaConfiguracao> createState() => _TelaConfiguracaoState();
}

class _TelaConfiguracaoState extends State<TelaConfiguracao> {
  @override
  Widget build(BuildContext context) {
    final ServicoBluetooth task =
        ServicoBluetooth.of(context, rebuildOnChange: false);
    bool value = false;
    return Stack(children: [
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
              'Configurações',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24.0,
              ),
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: IconButton(
                  icon: const Icon(Icons.notification_add_outlined),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScopedModel<ServicoBluetooth>(
                                model: task, child: const TelaNotificacao())));
                  },
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person_2_outlined,
                          size: 25,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(6, 0, 0, 6),
                          child: Text(
                            'Editar perfil',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              decoration: TextDecoration.none,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          31,
                          0,
                          0,
                          0,
                        ),
                        child: Text(
                          'Informações da conta e senha',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            decoration: TextDecoration.none,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.normal,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.lock_outline,
                          size: 25,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                          child: Text(
                            'Privacidade e segurança',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              decoration: TextDecoration.none,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.chevron_right_rounded,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          31,
                          0,
                          0,
                          0,
                        ),
                        child: Text(
                          'Gerencie e monitore seus dados',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            decoration: TextDecoration.none,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.normal,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.edit_notifications_outlined,
                          size: 25,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                          child: Text(
                            'Noticações',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              decoration: TextDecoration.none,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.chevron_right_rounded,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          31,
                          0,
                          0,
                          0,
                        ),
                        child: Text(
                          'Gerencie suas notificações',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            decoration: TextDecoration.none,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.normal,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.emoji_emotions_outlined,
                          size: 25,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                          child: Text(
                            'Acessibilidade',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              decoration: TextDecoration.none,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.chevron_right_rounded,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          31,
                          0,
                          0,
                          0,
                        ),
                        child: Text(
                          'Legendas, idiomas e exibição',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            decoration: TextDecoration.none,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.normal,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.light_mode_outlined,
                          size: 25,
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                          child: Text(
                            'Modo claro',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              decoration: TextDecoration.none,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SwitchButton(
                                value: value,
                                onChanged: (value) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ScopedModel<ServicoBluetooth>(
                                                model: task,
                                                child:
                                                    const TelaConfiguracaoClara())),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.more_horiz_outlined,
                          size: 25,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                          child: Text(
                            'Outros recursos',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              decoration: TextDecoration.none,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.chevron_right_rounded,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          31,
                          0,
                          0,
                          0,
                        ),
                        child: Text(
                          'Mais',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            decoration: TextDecoration.none,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.normal,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout_outlined,
                          size: 25,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                          child: Text(
                            'Desativar',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              decoration: TextDecoration.none,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
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
          bottomNavigationBar:
              ScopedModel<ServicoBluetooth>(model: task, child: Navbar())),
    ]);
  }
}
