import 'package:aqua/widgets/universal_card.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Especie extends StatefulWidget {
  const Especie(
      {super.key,
      required this.especie,
      required this.agua,
      required this.sexo,
      required this.alimentacao,
      required this.temperatura,
      required this.nomePeixe,
      required this.image,
      required this.ph});
  final String especie;
  final String agua;
  final String sexo;
  final String alimentacao;
  final String temperatura;
  final String ph;
  final String nomePeixe;
  final Image? image;

  @override
  State<StatefulWidget> createState() {
    return _EspecieState();
  }
}

class _EspecieState extends State<Especie> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (p0, p1, p2) => Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.5.w),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 2.5.w, 0),
                    child: const Icon(Icons.notification_add_outlined),
                  ),
                  const Icon(Icons.settings_outlined),
                ],
              ),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: 90.w,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.especie,
                        style:  TextStyle(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          decoration: TextDecoration.none,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                          fontSize: 4.w,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        widget.nomePeixe,
                        style:  TextStyle(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          decoration: TextDecoration.none,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 5.w,
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          print('Botão pressionado!');
                        },
                        iconSize: 5.w, // Tamanho do ícone
                        color: const Color.fromARGB(
                            255, 255, 255, 255), // Cor do ícone
                        splashColor: const Color.fromARGB(255, 94, 34,
                            205), // Cor do efeito de splash ao pressionar
                        tooltip:
                            'Editar', // Texto exibido ao segurar o botão
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 90.w,
                    child: widget.image,
                  ),
                  UniversalCard(
                    padding:  EdgeInsets.fromLTRB(3.w, 1.5.h, 3.w, 1.5.h),
                    width: 90.w,
                    borderRadius: const BorderRadius.all(Radius.circular(23)),
                    title:  Center(
                      child: Text(
                        'Informações',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          decoration: TextDecoration.none,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal,
                          fontSize: 6.w,
                        ),
                      ),
                    ),
                    child: Column(
                  
                      children: [
                        UniversalCard(
                          padding: EdgeInsets.symmetric(vertical:1.5.w,horizontal: 4.w),
                          width: 80.w,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          title:  Text(
                            'Espécie',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                              fontSize: 3.w,
                            ),
                          ),
                          child: Text(
                            widget.especie,
                            style:  TextStyle(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                              fontSize: 4.5.w,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            UniversalCard(
                                padding: EdgeInsets.symmetric(vertical:1.5.w,horizontal: 4.w),
                              width: 38.5.w,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              title: Text(
                                'Água',
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 255, 255, 255),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 3.w,
                                ),
                              ),
                              child: Text(
                                widget.agua,
                                style:  TextStyle(
                                  color: const Color.fromARGB(255, 255, 255, 255),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 4.5.w,
                                ),
                              ),
                            ),
                            UniversalCard(
                                padding: EdgeInsets.symmetric(vertical:1.5.w,horizontal: 4.w),
                              width: 38.5.w,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              title:  Text(
                                'Sexo',
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 255, 255, 255),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 3.w,
                                ),
                              ),
                              child: Text(
                                widget.sexo,
                                style:  TextStyle(
                                  color: const Color.fromARGB(255, 255, 255, 255),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 4.5.w,
                                ),
                              ),
                            )
                          ],
                        ),
                         Padding(
                          padding: EdgeInsets.only(top: 1.5.w),
                          child: Row(
                            children: [
                              Text(
                                'Recomendações',
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 255, 255, 255),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 4.5.w,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                               Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Icon(
                                  Icons.restaurant,
                                  size:  4.5.w,
                                  color: const Color.fromARGB(255, 255, 147, 30),
                                ),
                              ),
                              Text(
                                'Alimentação: ${widget.alimentacao}',
                                softWrap: true,
                                style:  TextStyle(
                                  color: const Color.fromARGB(255, 255, 255, 255),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 3.5.w,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                               Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Icon(
                                  Icons.thermostat,
                                  size:  4.5.w,
                                  color: const Color.fromARGB(255, 255, 147, 30),
                                ),
                              ),
                              Text(
                                'Temperatura ideal: ${widget.temperatura}',
                                softWrap: true,
                                style:  TextStyle(
                                  color: const Color.fromARGB(255, 255, 255, 255),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 3.5.w,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                               Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Icon(
                                  Icons.water_drop,
                                  size: 4.5.w,
                                  color: const Color.fromARGB(255, 255, 147, 30),
                                ),
                              ),
                              Text(
                                'PH ideal: ${widget.ph}',
                                softWrap: true,
                                textAlign: TextAlign.center,
                                style:  TextStyle(
                                  color: const Color.fromARGB(255, 255, 255, 255),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 3.5.w,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
