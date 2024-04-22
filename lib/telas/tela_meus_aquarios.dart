import 'package:aqua/servicos/servico_bluetooth.dart';
import 'package:aqua/servicos/servico_firebase.dart';
import 'package:aqua/telas/tela_adicionar_peixe.dart';
import 'package:aqua/telas/tela_cadastro_aquario.dart';
import 'package:aqua/telas/tela_configuracao.dart';
import 'package:aqua/telas/tela_especie.dart';
import 'package:aqua/telas/tela_notificacao.dart';
import 'package:aqua/widgets/diario.dart';
import 'package:aqua/widgets/navbar.dart';
import 'package:aqua/widgets/round_fish_card.dart';
import 'package:aqua/widgets/semanal.dart';
import 'package:aqua/widgets/tag_card.dart';
import 'package:aqua/widgets/universal_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scoped_model/scoped_model.dart';

class TelaMeusAquarios extends StatefulWidget {
  const TelaMeusAquarios({super.key});

  @override
  State<TelaMeusAquarios> createState() => _TelaMeusAquariosState();
}

class _TelaMeusAquariosState extends State<TelaMeusAquarios> {
  List<Aquarium> aquariosList = List.empty(growable: true);
  List<Fish> peixesList = List.empty(growable: true);
  List<Widget> tagsList = List.empty(growable: true);
  List<RoundFishCard> roundedFishCardList = List.empty(growable: true);
  PageController controller = PageController(initialPage: 0);
  final User? user = FirebaseAuth.instance.currentUser;
  String? aquarioId;
  String? peixeId;
  Color? aquarioTagColor;
  bool diarioSelected = true;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async => await getAquarios())
        .then((value) => setState(() {}));

    // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {});
    });
    // Listen for further state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {});
    });
  }

  void handleTagSelection(Aquarium clickedAquarium) {
    Future.delayed(
      Duration.zero,
      () => getPeixes(),
    );
    setState(() {
      aquarioId = clickedAquarium.id;
    });
  }

  String removeSpaces(String text) {
    return text.replaceAll(RegExp(r"\s"), "");
  }

  Future<void> getAquarios() async {
    aquariosList = await FirebaseService().getAquarios(user!.uid);
  }

  Future<void> getPeixes() async {
    peixesList = await FirebaseService().getPeixes(user!.uid, aquarioId!);
    print(peixesList);

    // 2. Create a list to hold the RoundFishCard widgets
    List<RoundFishCard> list = [];

    // 3. Loop through the filtered peixesList and create RoundFishCard instances
    for (var peixe in peixesList) {
      String especie = removeSpaces(peixe.especie.toLowerCase());
      list.add(
        RoundFishCard(
          image: await FirebaseService()
              .getImageFromFirebaseStorage('meus_$especie'),
          fishName: peixe.name,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ChangeNotifierProvider<CurrentPageIndexEspecies>(
                          create: (context) => CurrentPageIndexEspecies(),
                          child: TelaEspecie(
                              peixes: peixesList, peixeSelecionado: peixe),
                        )));
          },
        ),
      );
    }
    setState(() {
      roundedFishCardList = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ServicoBluetooth task =
        ServicoBluetooth.of(context, rebuildOnChange: true);
    Future.delayed(Duration.zero, () async => await getAquarios())
        .then((value) => setState(() {}));
    return ResponsiveSizer(
      builder: (context, orientation, screen) => Stack(
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
              automaticallyImplyLeading: false,
              surfaceTintColor: Colors.transparent,
              title: Text(
                'Meus Aquários',
                style: TextStyle(fontSize: 3.h, fontWeight: FontWeight.w600),
              ),
              actions: [
                IconButton(onPressed: () => task.sendMessage('ALIMENTAR'), icon: Icon(Icons.arrow_circle_down)),
                IconButton(
                  icon: const Icon(Icons.notification_add_outlined),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScopedModel<ServicoBluetooth>(
                                model: task, child: TelaNotificacao())));
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.settings_outlined),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScopedModel<ServicoBluetooth>(
                                model: task, child: TelaConfiguracao())));
                  },
                ),
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0.0.h, 0, 1.0.h),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: [
                      IconButton(
                        icon: const Icon(Icons.add_circle),
                        onPressed: () {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ScopedModel<ServicoBluetooth>(
                                              model: task,
                                              child:
                                                  const TelaCadastroAquario())))
                              .then((value) => setState(() {}));
                        },
                        iconSize: 5.h,
                        color: const Color.fromRGBO(172, 172, 172, 32),
                        splashColor: const Color.fromARGB(255, 94, 34, 205),
                        tooltip:
                            'Adicionar', // Texto exibido ao segurar o botão
                      ),
                      Row(
                        children: aquariosList
                            .map((aquarium) => TagCard(
                                  text: aquarium.name,
                                  onTap: () => handleTagSelection(aquarium),
                                  color: aquarioTagColor,
                                ))
                            .toList(),
                      )
                    ]),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              if (aquarioId != null) {
                                Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ScopedModel<ServicoBluetooth>(
                                                    model: task,
                                                    child: TelaAdicionarPeixe(
                                                      aquarioId: aquarioId,
                                                    ))))
                                    .then((value) => setState(() {}));
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Erro: Selecione um aquário antes.",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 3,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 1.5.w),
                              child: Container(
                                height: 101,
                                width: 101,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromRGBO(217, 217, 217, 0.25)),
                                child: const Icon(
                                  Icons.add_rounded,
                                  size: 60,
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            'Adicionar',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              decoration: TextDecoration.none,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        child: Row(
                          children: roundedFishCardList,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(4.0.w, 0.5.h, 0, 0.5.h),
                  child: Text(
                    'Informações',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      decoration: TextDecoration.none,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 6.0.w,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                      child: InkWell(
                        overlayColor:
                            const MaterialStatePropertyAll(Colors.transparent),
                        onTap: () {
                          setState(() {
                            controller.animateToPage(0,
                                curve: Curves.linear,
                                duration: Durations.medium1);
                            diarioSelected = true;
                          });
                        },
                        child: UniversalCard(
                          color: diarioSelected
                              ? const Color.fromRGBO(217, 217, 217, 0.25)
                              : Colors.transparent,
                          padding: const EdgeInsets.fromLTRB(1, 1, 1, 1),
                          width: 25.w,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                          child: const Center(
                            child: Text(
                              'Diário',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                      child: InkWell(
                        overlayColor:
                            const MaterialStatePropertyAll(Colors.transparent),
                        onTap: () {
                          setState(() {
                            controller.animateToPage(1,
                                curve: Curves.linear,
                                duration: Durations.medium1);
                            diarioSelected = false;
                          });
                        },
                        child: UniversalCard(
                          color: diarioSelected
                              ? Colors.transparent
                              : const Color.fromRGBO(217, 217, 217, 0.25),
                          padding: const EdgeInsets.fromLTRB(1, 1, 1, 1),
                          width: 25.w,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                          child: const Center(
                            child: Text(
                              'Semanal',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: PageView(
                    onPageChanged: (value) {
                      if (value == 0) {
                        setState(() {
                          diarioSelected = true;
                        });
                      } else {
                        diarioSelected = false;
                      }
                    },
                    controller: controller,
                    children: [
                      ScopedModel<ServicoBluetooth>(
                        model: task,
                        child: const Diario(),
                      ),
                      ScopedModel<ServicoBluetooth>(
                        model: task,
                        child: const Semanal(),
                      )
                    ],
                  ),
                ),
              ],
            ),
            bottomNavigationBar: const Navbar(
              index: 1,
            ),
          ),
        ],
      ),
    );
  }
}
