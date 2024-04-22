import 'package:aqua/servicos/servico_bluetooth.dart';
import 'package:aqua/widgets/switch.dart';
import 'package:aqua/widgets/universal_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Alarm {
  TimeOfDay time;
  List<bool> daysOfWeek;
  bool isEnabled;

  Alarm({
    required this.time,
    this.daysOfWeek = const [false, false, false, false, false, false, false],
    this.isEnabled = true,
  });
}

class AlarmProvider extends ChangeNotifier {
  List<Alarm> alarms = [];

  void addAlarm(TimeOfDay time, List<bool> daysOfWeek) {
    alarms.add(Alarm(time: time, daysOfWeek: daysOfWeek));
    notifyListeners(); // Notify listeners of changes
  }

  // ... other methods to manage alarms
}

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  List<Alarm> alarms = [];

  final TextEditingController _timeController = TextEditingController();

  void _addAlarm(TimeOfDay time, List<bool> days) {
    final AlarmProvider alarmProvider =
        Provider.of<AlarmProvider>(context, listen: false);
    if (alarmProvider.alarms.length < 3) {
      setState(() {
        alarms.add(Alarm(time: time, daysOfWeek: days));
        alarmProvider.addAlarm(time, days);
      });
    }
  }

  void _toggleAlarm(int index) {
    setState(() {
      alarms[index].isEnabled = !alarms[index].isEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ServicoBluetooth task =
        ServicoBluetooth.of(context, rebuildOnChange: false);
    final AlarmProvider alarmProvider = Provider.of<AlarmProvider>(context);
    return UniversalCard(
        width: 90.w,
        borderRadius: const BorderRadius.all(Radius.circular(23)),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text('Horários de alimentação:',style: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            decoration: TextDecoration.none,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.normal,
                            fontSize: 4.0.w,
                          ),),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () async {
                  if (alarmProvider.alarms.length < 3) {
                    final selectedTime = await showTimePicker(
                      initialEntryMode: TimePickerEntryMode.inputOnly,
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (selectedTime != null) {
                      _timeController.text = selectedTime.format(context);
                      List<bool>? selectedDays = List.from(alarms.isEmpty
                          ? [false, false, false, false, false, false, false]
                          : alarms.last.daysOfWeek);
                      selectedDays = await showDialog<List<bool>>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: const Color.fromRGBO(82, 84, 87, 0.98),
                            surfaceTintColor: Colors.transparent,
                            title: const Text(
                              'Escolha os dias da semana',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            content: StatefulBuilder(
                              builder: (BuildContext context, setState) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _buildDaysOfWeekRow(selectedDays!, setState),
                                  ],
                                );
                              },
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, selectedDays);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                      if (selectedDays != null) {
                        _addAlarm(selectedTime, selectedDays);
                        if (alarmProvider.alarms.length == 1) {
                          String timeString =
                              alarmProvider.alarms[0].time.format(context);
                          task.sendMessage('1H-$timeString');
                        } else if (alarmProvider.alarms.length == 2) {
                          String timeString =
                              alarmProvider.alarms[1].time.format(context);
                          task.sendMessage('2H-$timeString');
                        } else if (alarmProvider.alarms.length == 3) {
                          String timeString =
                              alarmProvider.alarms[2].time.format(context);
                          task.sendMessage('3H-$timeString');
                        }
                      }
                    }
                  } else {
                    Fluttertoast.showToast(
                      msg: "Não é possível adicionar mais de 3 horários.",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 3,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                },
              ),
            ],
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: alarmProvider.alarms.length,
            itemBuilder: (BuildContext context, int index) {
              final alarm = alarmProvider.alarms[index];
              return ListTile(
                title: Text(
                  alarm.time.format(context),
                  style: const TextStyle(fontSize: 20.0),
                ),
                subtitle: Text(
                  _buildDaysOfWeekString(alarm.daysOfWeek),
                ),
                trailing: SwitchButton(
                  value: alarm.isEnabled,
                  onChanged: (value) {
                    _toggleAlarm(index);
                  },
                ),
              );
            },
          )
        ]));
  }

  Widget _buildDaysOfWeekRow(List<bool> selectedDays, Function setState) {
    List<String> daysAbbreviations = ['S', 'T', 'Q', 'Q', 'S', 'S', 'D'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        7,
        (index) => GestureDetector(
          onTap: () {
            setState(() {
              selectedDays[index] = !selectedDays[index];
            });
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selectedDays[index]
                  ? const Color.fromARGB(255, 17, 151, 182)
                  : Colors.grey[200],
            ),
            child: Text(
              daysAbbreviations[index],
              style: TextStyle(
                color: selectedDays[index] ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _buildDaysOfWeekString(List<bool> daysOfWeek) {
    List<String> daysAbbreviations = [
      'Seg',
      'Ter',
      'Qua',
      'Qui',
      'Sex',
      'Sab',
      'Dom'
    ];
    String result = '';
    for (int i = 0; i < daysOfWeek.length; i++) {
      if (daysOfWeek[i]) {
        result += '${daysAbbreviations[i]} ';
      }
    }
    return result;
  }
}
