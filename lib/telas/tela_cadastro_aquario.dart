import 'package:aqua/servicos/servico_bluetooth.dart';
import 'package:aqua/servicos/servico_firebase.dart';
import 'package:aqua/telas/pop_up_privacidade.dart';
import 'package:aqua/telas/tela_adicionar_peixe.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaCadastroAquario extends StatefulWidget {
  const TelaCadastroAquario({super.key});
  @override
  State<TelaCadastroAquario> createState() => _TelaCadastroAquario();
}

class _TelaCadastroAquario extends State<TelaCadastroAquario> {
  FirebaseService firebaseService = FirebaseService();
  final User? user = FirebaseAuth.instance.currentUser;
  final formKey = GlobalKey<FormState>();
  String? aquarioId;
  String? nome;
  String? capacidade;
  String? altura;
  String? largura;
  String? comprimento;
  bool valueReturned = false;
  bool _showPopup = true;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () => _loadPreferences(),
    ).then((value) => showPopup());
  }

  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _showPopup = _prefs.getBool('showPopup') ?? true;
    });
  }

  Future<void> _savePreferences() async {
    await _prefs.setBool('showPopup', _showPopup);
  }

  Future<void> showPopup() async {
    if (_showPopup) {
      _showPopup = await showDialog(
          context: context,
          builder: (BuildContext context) => const PopUpPrivacidade());
      print(_showPopup);
      _savePreferences();
    }
  }

  String? validarNome(String? value) {
    if (value!.isEmpty) {
      return "Informe o nome";
    } else if (value.length > 20) {
      return 'Limitado em 20 letras';
    }
    return null;
  }

  String? validarNum(String? value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(patttern);
    if (value!.isEmpty) {
      return 'Informe o valor';
    } else if (!regExp.hasMatch(value)) {
      return 'Somente valores numéricos';
    }
    return null;
  }

  Future<void> sendForm() async {
    if (formKey.currentState!.validate()) {
      // Sem erros na validação
      formKey.currentState!.save();
      print(user!.uid);
      aquarioId = await FirebaseService().addAquario(
          user!.uid, nome, capacidade, altura, largura, comprimento);
      print(aquarioId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ServicoBluetooth task =
        ServicoBluetooth.of(context, rebuildOnChange: true);

    return Stack(children: [
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/fundo.png'), fit: BoxFit.cover),
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
                  child: Icon(
                    Icons.error_outline_rounded,
                    size: 70,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: SizedBox(
                    height: 90,
                    width: 320,
                    child: RichText(
                      text: const TextSpan(
                        text: 'Coloque as informações\n sobre o seu aquário:',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          decoration: TextDecoration.none,
                          fontSize: 24.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 330),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            onSaved: (newValue) {
                              nome = newValue;
                            },
                            validator: validarNome,
                            decoration: const InputDecoration(
                                label: Text(
                                  'Nome',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    decoration: TextDecoration.none,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w100,
                                    color: Colors.white,
                                  ),
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                contentPadding:
                                    EdgeInsets.fromLTRB(30, 0, 30, 10),
                                alignLabelWithHint: true),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onSaved: (newValue) {
                              capacidade = newValue;
                            },
                            validator: validarNum,
                            decoration: InputDecoration(
                                label: const Text(
                                  'Litros',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    decoration: TextDecoration.none,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w100,
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    borderSide:
                                        const BorderSide(color: Colors.white)),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                alignLabelWithHint: true),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            onSaved: (newValue) {
                              altura = newValue;
                            },
                            validator: validarNum,
                            decoration: InputDecoration(
                                label: const Text(
                                  'Altura (cm)',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    decoration: TextDecoration.none,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w100,
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    borderSide:
                                        const BorderSide(color: Colors.white)),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                alignLabelWithHint: true),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            onSaved: (newValue) {
                              largura = newValue;
                            },
                            validator: validarNum,
                            decoration: InputDecoration(
                                label: const Text(
                                  'Largura (cm)',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    decoration: TextDecoration.none,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w100,
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    borderSide:
                                        const BorderSide(color: Colors.white)),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                alignLabelWithHint: true),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            onSaved: (newValue) {
                              comprimento = newValue;
                            },
                            validator: validarNum,
                            decoration: InputDecoration(
                                label: const Text(
                                  'Comprimento (cm)',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    decoration: TextDecoration.none,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w100,
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    borderSide:
                                        const BorderSide(color: Colors.white)),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                alignLabelWithHint: true),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 58, 8, 8),
                          child: ElevatedButton(
                            onPressed: () async {
                              await sendForm();
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ScopedModel<ServicoBluetooth>(
                                              model: task,
                                              child: TelaAdicionarPeixe(
                                                aquarioId: aquarioId,
                                              )))).then((value) {
                                Navigator.pop(context);
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 147, 30),
                              foregroundColor: Colors.white,
                              textStyle: const TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0,
                              ),
                              fixedSize: const Size(236, 46),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                            child: const Text('Próximo'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
