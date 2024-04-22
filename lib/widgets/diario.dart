import 'package:aqua/servicos/servico_bluetooth.dart';
import 'package:aqua/telas/pop_up_alimentacao.dart';
import 'package:aqua/telas/tela_selecionar_aquario.dart';
import 'package:flutter/material.dart';
import 'package:aqua/widgets/switch.dart';
import 'package:aqua/widgets/universal_card.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Diario extends StatefulWidget {
  const Diario({super.key});

  @override
  State<Diario> createState() => _DiarioState();
}

class _DiarioState extends State<Diario> with TickerProviderStateMixin {
  ServicoBluetooth? _collectingTask;

  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  bool light = false;
  double tdsValue = 0;
  double temperatureValue = 0;
  String temperatureString = '';
  Color temperatureColor = const Color.fromRGBO(255, 147, 30, 1);

  @override
  void initState() {
    super.initState();

    // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    // Listen for further state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final ServicoBluetooth task =
        ServicoBluetooth.of(context, rebuildOnChange: true);
    final AlarmProvider alarmProvider = Provider.of<AlarmProvider>(context);
    const Duration showDuration = Duration(hours: 2);
    final Iterable<DataSample> lastSamples = task.getLastOf(showDuration);
    tdsValue =
        lastSamples.fold(0, (previousValue, element) => element.tdsValue);
    temperatureValue = lastSamples.fold(
        0, (previousValue, element) => element.temperatureValue);
    temperatureValidator();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
                  )
                ],
              ),
            ),
          ),
          UniversalCard(
            padding: EdgeInsets.fromLTRB(3.0.w, 0, 0, 0.7.h),
            width: 90.0.w,
            borderRadius: const BorderRadius.all(Radius.circular(23)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        'Horários de alimentação do dia:',
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal,
                          fontSize: 4.0.w,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.5.w, 0, 0, 0),
                      child: IconButton(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () {
                          print('Botão pressionado!');
                        },
                        iconSize: 3.0.h,
                        color: Colors.white,
                        tooltip: 'editar',
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 1.0.w, 0),
                        child: Icon(
                          Icons.schedule_outlined,
                          size: 4.0.h,
                        ),
                      ),
                      Row(
                        children: alarmProvider.alarms
                            .map((alarm) => UniversalCard(
                                  padding:
                                      EdgeInsets.fromLTRB(0, 0.5.h, 0, 0.5.h),
                                  width: 23.0.w,
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(12)),
                                  child: Center(
                                    child: Text(
                                      alarm.time.format(context),
                                      style: TextStyle(
                                        color: Colors.white,
                                        decoration: TextDecoration.none,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 2.0.h,
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  UniversalCard(
                    title: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0.8.h, 0, 0.8.h),
                      child: Center(
                        child: Text(
                          'Iluminação',
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.normal,
                            fontSize: 4.0.w,
                          ),
                        ),
                      ),
                    ),
                    width: 50.0.w,
                    borderRadius: const BorderRadius.all(Radius.circular(23)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Automática:',
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.normal,
                            fontSize: 3.8.w,
                          ),
                        ),
                        UniversalCard(
                          padding: EdgeInsets.fromLTRB(1.0.w, 0, 1.0.w, 0),
                          width: 40.0.w,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.lightbulb,
                                size: 3.0.h,
                                color: Colors.white,
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(1.5.w, 0, 0, 0),
                                child: Text(
                                  '18:00',
                                  style: TextStyle(
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 2.5.h,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(1.0.w, 0, 0, 0),
                                child: IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    print('Botão pressionado!');
                                  },
                                  iconSize: 3.0.h,
                                  color: Colors.white,
                                  tooltip: 'editar',
                                ),
                              ),
                            ],
                          ),
                        ),
                        UniversalCard(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          width: 40.0.w,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(2.5.w, 0, 0, 0),
                                child: Icon(
                                  Icons.lightbulb_outline,
                                  size: 3.0.h,
                                  color: const Color.fromRGBO(217, 217, 217, 1),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(1.5.w, 0, 0, 0),
                                child: Text(
                                  '00:00',
                                  style: TextStyle(
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 2.5.h,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(1.0.w, 0, 0, 0),
                                child: IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    print('Botão pressionado!');
                                  },
                                  iconSize: 3.0.h,
                                  color: Colors.white,
                                  tooltip: 'editar',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Manual:',
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.normal,
                            fontSize: 3.8.w,
                          ),
                        ),
                        Center(
                          child: Row(
                            children: [
                              SwitchButton(
                                value: light,
                                onChanged: (value) {
                                  setState(() {
                                    light = value;
                                    if (value) {
                                      task.sendMessage('HIGH');
                                    } else {
                                      task.sendMessage('LOW');
                                    }
                                  });
                                },
                              ),
                              Icon(
                                light
                                    ? Icons.lightbulb
                                    : Icons.lightbulb_outline,
                                color: Colors.white,
                                size: 8.w,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  UniversalCard(
                    height: 15.h,
                    title: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0.8.h, 0, 0),
                      child: Center(
                        child: Text(
                          'Temperatura:',
                          style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.none,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                              fontSize: 4.0.w),
                        ),
                      ),
                    ),
                    width: 37.0.w,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 1.h),
                          child: Text(
                            '${temperatureValue.floor()}°',
                            style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.none,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 3.0.h,
                            ),
                          ),
                        ),
                        Center(
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: 'Status:',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 2.0.h,
                                  color:
                                      const Color.fromRGBO(255, 255, 255, 1.0),
                                ),
                              ),
                              TextSpan(
                                text: temperatureString,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 2.0.h,
                                  color: temperatureColor,
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onLongPress: () async {
                      final BluetoothDevice? selectedDevice =
                          await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return const TelaSelecionarAquario(
                                checkAvailability: false, userData: true,);
                          },
                        ),
                      );
                      if (selectedDevice != null) {
                        print('Connect -> selected ${selectedDevice.address}');
                        _startBackgroundTask(context, selectedDevice);
                      } else {
                        print('Connect -> no device selected');
                      }
                    },
                    child: UniversalCard(
                      padding: const EdgeInsets.only(bottom: 0),
                      title: Padding(
                        padding: EdgeInsets.fromLTRB(0, 2.0.w, 0, 0),
                        child: Center(
                          child: Text(
                            'Bluetooth:',
                            style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.none,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                              fontSize: 4.0.w,
                            ),
                          ),
                        ),
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      width: 37.0.w,
                      height: 33.0.w,
                      child: Column(
                        children: [
                          Center(
                            child: Icon(
                              Icons.bluetooth,
                              size: 4.0.h,
                            ),
                          ),
                          SwitchButton(
                            value: _bluetoothState.isEnabled,
                            onChanged: (value) {
                              if (value) {
                                setState(() {
                                  FlutterBluetoothSerial.instance
                                      .requestEnable();
                                });
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _startBackgroundTask(
    BuildContext context,
    BluetoothDevice server,
  ) async {
    try {
      _collectingTask = await ServicoBluetooth.connect(server);
      await _collectingTask!.start();
      print('started task');
    } catch (ex) {
      _collectingTask?.cancel();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error occured while connecting'),
            content: Text(ex.toString()),
            actions: <Widget>[
              TextButton(
                child: const Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

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
}
