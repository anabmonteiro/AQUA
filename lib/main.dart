import 'package:aqua/telas/pop_up_alimentacao.dart';
import 'package:aqua/telas/tela_inicial.dart';
import 'package:aqua/widgets/custom_theme.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await [
    Permission.location,
    Permission.bluetoothAdvertise,
    Permission.bluetoothConnect,
    Permission.bluetoothScan,
  ].request();
  runApp(
    ChangeNotifierProvider<AlarmProvider>(
  create: (context) => AlarmProvider(),
  child:MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('pt'),
      title: 'Aqua',
      theme: CustomTheme().theme(),
      home: const SafeArea(child: TelaInicial()),
    ),
    )
  );
}
