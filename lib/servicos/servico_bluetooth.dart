import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scoped_model/scoped_model.dart';

class DataSample {
  final double temperatureValue;
  final double tdsValue;
  final DateTime timestamp;

  DataSample({
    required this.temperatureValue,
    required this.tdsValue,
    required this.timestamp,
  });
}

class ServicoBluetooth extends Model {
  static ServicoBluetooth of(
    BuildContext context, {
    bool rebuildOnChange = false,
  }) =>
      ScopedModel.of<ServicoBluetooth>(
        context,
        rebuildOnChange: rebuildOnChange,
      );

  bool isDiscovering = false;

  final BluetoothConnection _connection;
  final List<int> _buffer = List<int>.empty(growable: true);
  List<DataSample> samples = List<DataSample>.empty(growable: true);
  bool inProgress = false;

  ServicoBluetooth._fromConnection(this._connection) {
    if(!_connection.isConnected) throw Exception('Erro ao comunicar-se com o aquário.');
    _connection.input!.listen((Uint8List data) {
      _buffer.addAll(data);

      while (_buffer.length >= 8) {
        int delimiterIndex = _buffer.indexOf('!'.codeUnitAt(0));

        if (delimiterIndex >= 0 && delimiterIndex == 8) {
          double tdsValue = _decodeFloat(_buffer.sublist(0, 4));

          double temperatureValue = _decodeFloat(_buffer.sublist(4, 8));

          final DataSample sample = DataSample(
            temperatureValue: temperatureValue,
            tdsValue: tdsValue,
            timestamp: DateTime.now(),
          );

          _buffer.removeRange(0, delimiterIndex + 1);

          samples.add(sample);

          notifyListeners();
        } else {
          _buffer.clear();
          break;
        }
      }
    }, onDone: () {
      inProgress = false;
      notifyListeners();
    });
  }

  double _decodeFloat(List<int> bytes) {
    final buffer = ByteData.sublistView(Uint8List.fromList(bytes));
    return buffer.getFloat32(0, Endian.little);
  }

  static Future<ServicoBluetooth> connect(
      BluetoothDevice server) async {
    final BluetoothConnection connection =
        await BluetoothConnection.toAddress(server.address);
    return ServicoBluetooth._fromConnection(connection);
  }

  void dispose() {
    _connection.dispose();
  }

  Future<void> start() async {
    inProgress = true;
    _buffer.clear();
    samples.clear();
    notifyListeners();
    _connection.output.add(ascii.encode('start'));
    await _connection.output.allSent;
  }

  Future<void> cancel() async {
    inProgress = false;
    notifyListeners();
    _connection.output.add(ascii.encode('stop'));
    await _connection.finish();
  }

  Future<void> pause() async {
    inProgress = false;
    notifyListeners();
    _connection.output.add(ascii.encode('stop'));
    await _connection.output.allSent;
  }

  Future<void> reasume() async {
    inProgress = true;
    notifyListeners();
    _connection.output.add(ascii.encode('start'));
    await _connection.output.allSent;
  }

  Iterable<DataSample> getLastOf(Duration duration) {
    DateTime startingTime = DateTime.now().subtract(duration);
    int i = samples.length;
    do {
      if (i <= 0) {
        break;
      }
      i -= 1;
    } while (samples[i].timestamp.isAfter(startingTime));
    return samples.getRange(i, samples.length);
  }

  void sendMessage(String text) async {
    if (text.isNotEmpty) {
      try {
        _connection.output.add(Uint8List.fromList(utf8.encode(text)));
        await _connection.output.allSent;
      } catch (e) {
        Fluttertoast.showToast(msg: '$e');
      }
    }
  }
}
