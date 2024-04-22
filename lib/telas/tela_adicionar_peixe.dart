import 'package:aqua/servicos/servico_bluetooth.dart';
import 'package:aqua/servicos/servico_firebase.dart';
import 'package:aqua/telas/pop_up_aviso.dart';
import 'package:aqua/telas/tela_cadastro_aquario.dart';
import 'package:aqua/telas/tela_meus_aquarios.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class TelaAdicionarPeixe extends StatefulWidget {
  final String? aquarioId;

  const TelaAdicionarPeixe({super.key, required this.aquarioId});

  @override
  State<TelaAdicionarPeixe> createState() => _TelaAdicionarPeixeState();
}

class _TelaAdicionarPeixeState extends State<TelaAdicionarPeixe> {
  Image? perfilImg;
  String? dropdownError;
  String? nomeError;
  final formKey = GlobalKey<FormState>();
  final User? user = FirebaseAuth.instance.currentUser;
  String? valorAgua;
  String? valorSexo;
  String? valorEspecies;
  String? nome;
  List<Fish> listaPeixes = List.empty();

  // Lista de itens para o DropdownButton
  final List<String> listAgua = ['Doce', 'Salgada'];
  final List<String> listSexo = ['Fêmea', 'Macho', 'Não consta'];
  final List<String> listEspecies = [
    'Betta',
    'Colisa',
    'Coridora',
    'Dourado',
    'Tetra Neon',
    'Tigre d\'Água',
    'Orelha Vermelha'
  ];

  void navegarTelaCadastroAquario(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TelaCadastroAquario()),
    );
  }

  String? validarNome(String? value) {
    if (value!.isEmpty) {
      return "Informe o nome";
    } else if (value.length > 20) {
      return 'Limitado em 20 letras';
    }
    return null;
  }

  String removeSpaces(String text) {
    return text.replaceAll(RegExp(r"\s"), "");
  }

  Future<void> onSpeciesSelected(String value) async {
    String formatted = removeSpaces(value);
    perfilImg = await FirebaseService()
        .getImageFromFirebaseStorage('perfil_$formatted');
  }

  Future<void> getPeixes() async {
    listaPeixes =
        await FirebaseService().getPeixes(user!.uid, widget.aquarioId!);
  }

  void validateForm(String? nome, String? valorAgua, String? valorSexo,
      String? valorEspecies) {
    if (formKey.currentState!.validate() &&
        valorAgua != null &&
        valorSexo != null &&
        valorEspecies != null) {
      formKey.currentState!.save();

      Future.delayed(Duration.zero, () async => await getPeixes());

      bool hasBetta = listaPeixes.any((item) => item.especie == "betta");
      if (valorEspecies == 'Betta' && hasBetta == true) {
        const PopUpAviso();
      } else {
        FirebaseService().addPeixes(user!.uid, widget.aquarioId!, nome,
            valorEspecies, valorAgua, valorSexo);
      }
    } else {
      setState(() {
        dropdownError = 'Selecione alguma opção!';
      });
    }
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
          backgroundColor: const Color.fromARGB(0, 202, 96, 96),
          body: Center(
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 70.0,
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 24),
                        child: Text(
                          'Adicione seu pet:',
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 24.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
                    child: SizedBox(
                      width: 168, // largura do círculo
                      height: 168, // altura do círculo
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        child: perfilImg,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (newValue) {
                        nome = newValue;
                      },
                      validator: validarNome,
                      decoration: InputDecoration(
                          constraints: const BoxConstraints(maxWidth: 325),
                          label: const Text(
                            'Nome do seu pet',
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
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          contentPadding:
                              const EdgeInsets.fromLTRB(30, 0, 30, 0),
                          alignLabelWithHint: true),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: DropdownMenu<String>(
                      errorText: dropdownError,
                      width: 325,
                      menuStyle: const MenuStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              Color.fromRGBO(1, 4, 9, 1.0))),
                      inputDecorationTheme:
                          Theme.of(context).inputDecorationTheme,
                      label: const Text('Espécies'),
                      initialSelection: valorEspecies,
                      onSelected: (String? value) {
                        setState(() {
                          valorEspecies = value;
                        });
                        Future.delayed(Duration.zero, () {
                          onSpeciesSelected(value!).then(
                            (value) => setState(() {}),
                          );
                        });
                      },
                      dropdownMenuEntries: listEspecies
                          .map<DropdownMenuEntry<String>>((String value) {
                        return DropdownMenuEntry<String>(
                            value: value, label: value);
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: DropdownMenu<String>(
                      errorText: dropdownError,
                      width: 325,
                      menuStyle: const MenuStyle(
                          backgroundColor: MaterialStatePropertyAll(
                        Color.fromRGBO(1, 4, 9, 1.0),
                      )),
                      inputDecorationTheme:
                          Theme.of(context).inputDecorationTheme,
                      label: const Text('Água'),
                      initialSelection: valorAgua,
                      onSelected: (String? value) {
                        setState(() {
                          valorAgua = value!;
                        });
                      },
                      dropdownMenuEntries: listAgua
                          .map<DropdownMenuEntry<String>>((String value) {
                        return DropdownMenuEntry<String>(
                            value: value, label: value);
                      }).toList(),
                    ),
                  ),
                  DropdownMenu<String>(
                    errorText: dropdownError,
                    width: 325,
                    menuStyle: const MenuStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromRGBO(4, 13, 23, 1.0))),
                    inputDecorationTheme:
                        Theme.of(context).inputDecorationTheme,
                    label: const Text('Sexo'),
                    initialSelection: valorSexo,
                    onSelected: (String? value) {
                      setState(() {
                        valorSexo = value!;
                      });
                    },
                    dropdownMenuEntries:
                        listSexo.map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    }).toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 32, 0, 12),
                    child: ElevatedButton(
                      onPressed: () {
                        validateForm(nome, valorAgua, valorSexo, valorEspecies);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ScopedModel<ServicoBluetooth>(
                                      model: task,
                                      child: const TelaMeusAquarios(),
                                    )));
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
                      child: const Text('Pronto'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 1.0,
                    ),
                    child: TextButton(
                      child: const Text(
                        'Voltar',
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScopedModel<ServicoBluetooth>(
                              model: task,
                              child: const TelaMeusAquarios(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
