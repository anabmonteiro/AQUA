import 'package:aqua/telas/tela_introducao_dois.dart';
import 'package:aqua/telas/tela_introducao_quatro.dart';
import 'package:aqua/telas/tela_introducao_tres.dart';
import 'package:aqua/telas/tela_introducao_um.dart';
import 'package:aqua/widgets/pagination_dots.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CurrentPageIndex with ChangeNotifier {
  int _currentPageIndex = 0;

  int get currentPageIndex => _currentPageIndex;

  void setCurrentPageIndex(int newIndex) {
    _currentPageIndex = newIndex;
    notifyListeners();
  }
}

class TelaIntroducao extends StatefulWidget {
  const TelaIntroducao({super.key});

  @override
  State<TelaIntroducao> createState() => _TelaIntroducaoState();
}

class _TelaIntroducaoState extends State<TelaIntroducao> {
  final PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final currentPageIndex = Provider.of<CurrentPageIndex>(context);
    return Provider(
      create: (context) => CurrentPageIndex(),
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
              Provider.of<CurrentPageIndex>(context, listen: false)
                  .setCurrentPageIndex(value);
            },
            children: const [
              TelaIntroducaoUm(),
              TelaIntroducaoDois(),
              TelaIntroducaoTres(),
              TelaIntroducaoQuatro(),
            ],
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.15,
            right: MediaQuery.of(context).size.height * 0.2,
            child: Row(
              children: [
                DotWidget(isSelected: currentPageIndex._currentPageIndex == 0),
                DotWidget(isSelected: currentPageIndex._currentPageIndex == 1),
                DotWidget(isSelected: currentPageIndex._currentPageIndex == 2),
                DotWidget(isSelected: currentPageIndex._currentPageIndex == 3),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
