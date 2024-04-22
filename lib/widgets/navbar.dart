import 'package:aqua/servicos/servico_bluetooth.dart';
import 'package:aqua/telas/tela_biblioteca.dart';
import 'package:aqua/telas/tela_meus_aquarios.dart';
import 'package:aqua/telas/tela_pontos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scoped_model/scoped_model.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key, this.index = 1});
  final int index;

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;
  ServicoBluetooth? task;
  List<BottomNavigationBarItem> navbarItens = [
    BottomNavigationBarItem(
      icon: SizedBox(
        width: 58,
        height: 58,
        child: ClipOval(
          child: Container(
            color: const Color.fromRGBO(217, 217, 217, 0.20),
            child: Center(
              child: SvgPicture.asset(
                'assets/icones/livros.svg',
                width: 25,
                height: 25,
              ),
            ),
          ),
        ),
      ),
      activeIcon: SizedBox(
        width: 58,
        height: 58,
        child: ClipOval(
          child: Container(
            color: const Color.fromARGB(255, 255, 255, 255),
            child: Center(
              child: SvgPicture.asset(
                'assets/icones/livros_clicado.svg',
                width: 25,
                height: 25,
              ),
            ),
          ),
        ),
      ),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: SizedBox(
        width: 58,
        height: 58,
        child: ClipOval(
          child: Container(
            color: const Color.fromRGBO(217, 217, 217, 0.20),
            child: Center(
              child: SvgPicture.asset(
                'assets/icones/peixe.svg',
                width: 30,
                height: 30,
              ),
            ),
          ),
        ),
      ),
      activeIcon: SizedBox(
        width: 58,
        height: 58,
        child: ClipOval(
          child: Container(
            color: const Color.fromARGB(255, 255, 255, 255),
            child: Center(
              child: SvgPicture.asset(
                'assets/icones/peixe_clicado.svg',
                width: 25,
                height: 25,
              ),
            ),
          ),
        ),
      ),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: SizedBox(
        width: 58,
        height: 58,
        child: ClipOval(
          child: Container(
            color: const Color.fromRGBO(217, 217, 217, 0.20),
            child: Center(
              child: SvgPicture.asset(
                'assets/icones/moedas.svg',
                width: 25,
                height: 25,
              ),
            ),
          ),
        ),
      ),
      activeIcon: SizedBox(
        width: 58,
        height: 58,
        child: ClipOval(
          child: Container(
            color: const Color.fromARGB(255, 255, 255, 255),
            child: Center(
              child: SvgPicture.asset(
                'assets/icones/moedas_clicado.svg',
                width: 25,
                height: 25,
              ),
            ),
          ),
        ),
      ),
      label: '',
    ),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    task = ServicoBluetooth.of(context, rebuildOnChange: true);
    _selectedIndex = widget.index;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
      child: FractionallySizedBox(
        widthFactor: 0.70,
        heightFactor: 0.09,
        child: Container(
          decoration: BoxDecoration(
              color: const Color.fromRGBO(147, 148, 152, 0.5),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(52)),
          child: BottomNavigationBar(
            selectedFontSize: 0,
            unselectedFontSize: 0,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            items: navbarItens,
            currentIndex: _selectedIndex,
            onTap: (value) {
              setState(() {
                _selectedIndex = value;
              });
              _getPage(value);
            },
          ),
        ),
      ),
    );
  }

  void _getPage(int index) {
    switch (index) {
      case 0:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ScopedModel<ServicoBluetooth>(
                      model: task!,
                      child: const TelaBiblioteca(),
                    )));
        break;

      case 1:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ScopedModel<ServicoBluetooth>(
                      model: task!,
                      child: const TelaMeusAquarios(),
                    )));
        break;

      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ScopedModel<ServicoBluetooth>(
                  model: task!, child: const TelaPontos())),
        );
        break;

      default:
    }
  }
}
