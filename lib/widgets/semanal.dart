import 'package:aqua/servicos/servico_bluetooth.dart';
import 'package:aqua/telas/pop_up_alimentacao.dart';
import 'package:flutter/material.dart';
import 'package:aqua/widgets/switch.dart';
import 'package:aqua/widgets/universal_card.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scoped_model/scoped_model.dart';

class Semanal extends StatefulWidget {
  const Semanal({super.key});

  @override
  State<Semanal> createState() => _SemanalState();
}

class _SemanalState extends State<Semanal> {
  double tdsValue = 0;
  double temperatureValue = 0;
  String temperatureString = '';
  Color temperatureColor = const Color.fromRGBO(255, 147, 30, 1);

  void temperatureValidator() {
    int temp = temperatureValue.floor();

    if (temp >= 26 && temp <= 28) {
      temperatureString = ' Ideal';
      temperatureColor = const Color.fromRGBO(255, 147, 30, 1);
    } else if (temp < 26) {
      temperatureString = ' Baixa';
      temperatureColor = Colors.lightBlue;
    } else if (temp > 28) {
      temperatureString = ' Alta';
      temperatureColor = Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ServicoBluetooth task =
        ServicoBluetooth.of(context, rebuildOnChange: true);
    const Duration showDuration = Duration(hours: 2);
    final Iterable<DataSample> lastSamples = task.getLastOf(showDuration);
    tdsValue =
        lastSamples.fold(0, (previousValue, element) => element.tdsValue);
    temperatureValue = lastSamples.fold(
        0, (previousValue, element) => element.temperatureValue);
    temperatureValidator();
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 1.0.h, 0, 0),
            child: UniversalCard(
              title: Padding(
                padding: EdgeInsets.fromLTRB(1.5.w, 0.8.h, 0, 1.2.h),
                child: Text(
                  'Estado da água:',
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.normal,
                    fontSize: 4.0.w,
                  ),
                ),
              ),
              width: 90.0.w,
              borderRadius: const BorderRadius.all(Radius.circular(23)),
              child: Column(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          height: 6.0.h,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(63, 139, 215, 1),
                                Color.fromRGBO(250, 185, 115, 1)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 52.0.w,
                          child: Padding(
                            padding: EdgeInsets.only(top: 2.2.h),
                            child: LinearProgressIndicator(
                              value: tdsValue / 1000,
                              backgroundColor: Colors.transparent,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.white),
                              minHeight: 1.6.h,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(2)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('limpo'),
                      Text('sujo'),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 1.5.h, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Datas de limpeza:',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            decoration: TextDecoration.none,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.normal,
                            fontSize: 4.0.w,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        UniversalCard(
                          padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
                          color: Color.fromRGBO(217, 217, 217, 0.35),
                          width: 72,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  '29/03',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                  ),
                                ),
                                Text(
                                  'última',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
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
          UniversalCard(
            width: 90.w,
            borderRadius: const BorderRadius.all(Radius.circular(23)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 6, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Iluminação Semanal',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          decoration: TextDecoration.none,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal,
                          fontSize: 4.0.w,
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                    child: Image.asset(
                        'assets/images/grafico/iluminação_semanal.png')),
              ],
            ),
          ),
           ScopedModel<ServicoBluetooth>(
                        model: task,
                        child:const AlarmPage(),
           ),

          UniversalCard(
              width: 90.w,
              borderRadius: const BorderRadius.all(Radius.circular(23)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 6, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Variação de Temperatura',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            decoration: TextDecoration.none,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.normal,
                            fontSize: 4.0.w,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 26, 0, 12),
                    child: Center(
                        child: Image.asset(
                            'assets/images/grafico/temperatura_semanal.png')),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
