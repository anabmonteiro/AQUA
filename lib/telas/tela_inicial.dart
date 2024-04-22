import 'package:aqua/telas/tela_conexao.dart';
import 'package:aqua/telas/tela_introducao.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animation = Tween<double>(begin: -50, end: 50).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      navigateToNextScreen();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void navigateToNextScreen() {
    var tela = user != null
        ? const TelaConexao(userData: true,)
        : ChangeNotifierProvider<CurrentPageIndex>(
            create: (context) => CurrentPageIndex(),
            child: const TelaIntroducao(),
          );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>  tela),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (p0, p1, p2) => Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/fundo.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Transform.translate(
                offset: Offset(0, _animation.value),
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 60.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
