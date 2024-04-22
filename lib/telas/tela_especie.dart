import 'package:aqua/servicos/servico_firebase.dart';
import 'package:aqua/widgets/especie.dart';
import 'package:aqua/widgets/pagination_dots.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelaEspecie extends StatefulWidget {
  final List<Fish> peixes;
  final Fish peixeSelecionado;
  const TelaEspecie(
      {super.key, required this.peixeSelecionado, required this.peixes});

  @override
  State<TelaEspecie> createState() => _TelaEspecieState();
}

class CurrentPageIndexEspecies with ChangeNotifier {
  int _currentPageIndex = 0;

  int get currentPageIndex => _currentPageIndex;

  void setCurrentPageIndex(int newIndex) {
    _currentPageIndex = newIndex;
    notifyListeners();
  }
}

class _TelaEspecieState extends State<TelaEspecie> {
  final User? user = FirebaseAuth.instance.currentUser;
  List<DotWidget> paginationDots = List.empty(growable: true);
  List<Especie> especies = List.empty(growable: true);
  PageController controller = PageController();
  @override
  void initState() {
    controller = PageController(
        initialPage: widget.peixes.indexOf(widget.peixeSelecionado));

    super.initState();
    Future.delayed(
      Duration.zero,
      () async => await getEspecies(),
    ).then((value) => setState(() {
      
    }));
    print('$especies ${controller.initialPage}');
  }
 String removeSpaces(String text) {
    return text.replaceAll(RegExp(r"\s"), "");
  }
  Future<List<Especie>> getEspecies() async {
    // Create an empty list to hold Especie objects
    
    // Loop through each peixe in widget.peixes
    for (var peixe in widget.peixes) {
      String especie = removeSpaces(peixe.especie.toLowerCase());
      FishInformation? peixeInfo = await FirebaseService()
          .getCaracteristicasPeixes(user!.uid, peixe.especie.toLowerCase());
      //if (peixeInfo == null) throw Exception('Informações não encontradas');
    
      especies.add(Especie(
        key: UniqueKey(),
        agua: peixe.agua,
        alimentacao: peixeInfo!.alimentacao,
        especie: peixe.especie,
        nomePeixe: peixe.name,
        sexo: peixe.sexo,
        temperatura: peixeInfo
            .temperatura, // Consider fetching from peixeInfo if available
        ph: peixeInfo.ph, 
        image: await FirebaseService().getImageFromFirebaseStorage('peixes_$especie'),// Consider fetching from peixeInfo if available
      ));
    }
    return especies;
  }

  @override
  Widget build(BuildContext context) {
    final currentPageIndex = Provider.of<CurrentPageIndexEspecies>(context);
    paginationDots = List<DotWidget>.generate(
        widget.peixes.length,
        (index) =>
            DotWidget(isSelected: index == currentPageIndex._currentPageIndex));
    return Provider(
      create: (context) => CurrentPageIndexEspecies(),
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/fundo.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          PageView(
            controller: controller,
            onPageChanged: (value) {
              Provider.of<CurrentPageIndexEspecies>(context, listen: false)
                  .setCurrentPageIndex(value);
            },
            children: [...especies],
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.08,
            right: MediaQuery.of(context).size.height * 0.23,
            child: Row(children: paginationDots),
          ),
        ],
      ),
    );
  }
}
