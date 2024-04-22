import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Aquarium {
  final String name;
  final String id;

  Aquarium({required this.name, required this.id});
}

class Fish {
  final String name;
  final String id;
  final String especie;
  final String agua;
  final String sexo;

  Fish(
      {required this.name,
      required this.id,
      required this.especie,
      required this.agua,
      required this.sexo});
}

class FishInformation {
  final String alimentacao;
  final String compatibilidade;
  final String curiosidades;
  final String ph;
  final String temperamento;
  final String agua;
  final String temperatura;

  FishInformation(
      {required this.alimentacao,
      required this.compatibilidade,
      required this.curiosidades,
      required this.agua,
      required this.temperamento,
      required this.temperatura,
      required this.ph});
}

class FirebaseService {
  Future<String?> addAquario(String? clientId, String? nome, String? capacidade,
    String? altura, String? largura, String? comprimento) async {
  try {
    if (clientId == null || nome == null || capacidade == null || altura == null||  largura == null || comprimento == null) {
      throw Exception('Não é possível adicionar valores vazios.');
    }

    final docRef = await FirebaseFirestore.instance
        .collection('clientes')
        .doc(clientId)
        .collection('aquarios')
        .add({
      'nome': nome,
      'altura': altura,
      'largura': largura,
      'comprimento': comprimento,
      'capacidade': capacidade,
    });
    return docRef.id;  // Return the document ID
  } on Exception catch (e) {
    Fluttertoast.showToast(
      msg: "Error: ${e.toString()}",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    return null;
  }
}

  void addCliente(String clientId, String email) {
    try {
      FirebaseFirestore.instance
          .runTransaction((Transaction transaction) async {
        CollectionReference reference =
            FirebaseFirestore.instance.collection('clientes');
        await reference.doc(clientId).set({
          'email': email,
        });
      });
    } on Exception catch (e) {
      Fluttertoast.showToast(
        msg: "Error: ${e.toString()}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void addPeixes(String? clientId, String aquarioId, String? nome,
      String? especie, String? agua, String? sexo) {
    try {
      if (clientId == null ||
          nome == null ||
          especie == null ||
          agua == null ||
          sexo == null) {
        throw Exception('Não é possível adicionar valores vazios.');
      }
      FirebaseFirestore.instance
          .runTransaction((Transaction transaction) async {
        DocumentReference reference =
            FirebaseFirestore.instance.collection('clientes').doc(clientId);
        await reference
            .collection('aquarios')
            .doc(aquarioId)
            .collection('peixes')
            .add({
          'nome': nome,
          'especie': especie,
          'agua': agua,
          'sexo': sexo,
        });
      });
    } on Exception catch (e) {
      Fluttertoast.showToast(
        msg: "Error: ${e.toString()}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<FishInformation?> getCaracteristicasPeixes(
      String clientId, String especie) async {
    FishInformation? fishData;
    try {
      await FirebaseFirestore.instance
          .runTransaction((Transaction transaction) async {
        CollectionReference reference =
            FirebaseFirestore.instance.collection('caracteristicas_peixes');

        DocumentSnapshot doc = await reference.doc(especie).get();
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String alimentacao = data['alimentacao'] ?? '';
        String compatibilidade = data['compatibilidade'] ?? '';
        String curiosidades = data['curiosidades'] ?? '';
        String agua = data['tipo agua'] ?? '';
        String temperamento = data['temperamento'] ?? '';
        String temperatura = data['temperatura'] ?? '';
        String ph = data['ph agua'] ?? '';
        fishData = FishInformation(
            alimentacao: alimentacao,
            compatibilidade: compatibilidade,
            curiosidades: curiosidades,
            agua: agua,
            temperamento: temperamento,
            temperatura: temperatura,
            ph: ph);
      });
      return fishData;
    } on Exception catch (e) {
      Fluttertoast.showToast(
        msg: "Error: ${e.toString()}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return null;
    }
  }

  Future<List<Aquarium>> getAquarios(String clientId) async {
    List<Aquarium> dataList = [];
    try {
      await FirebaseFirestore.instance
          .runTransaction((Transaction transaction) async {
        CollectionReference reference =
            FirebaseFirestore.instance.collection('clientes');

        QuerySnapshot querySnapshot =
            await reference.doc(clientId).collection('aquarios').get();

        for (var doc in querySnapshot.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          String name = data['nome'] ?? '';
          String id = doc.id; 
          dataList.add(Aquarium(name: name, id: id));
        }
      });
      return dataList;
    } on Exception catch (e) {
      Fluttertoast.showToast(
        msg: "Error: ${e.toString()}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return [];
    }
  }

  Future<void> deletePeixe(
      String clientId, String aquarioId, String fishId) async {
    try {
      await FirebaseFirestore.instance
          .collection('clientes')
          .doc(clientId)
          .collection('aquarios')
          .doc(aquarioId)
          .collection('peixes')
          .doc(fishId)
          .delete();

      print("Fish with ID $fishId deleted successfully.");
    } on Exception catch (e) {
      Fluttertoast.showToast(
        msg: "Error deleting fish: ${e.toString()}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<List<Fish>> getPeixes(String clientId, String aquarioId) async {
    List<Fish> dataList = [];

    try {
      await FirebaseFirestore.instance
          .runTransaction((Transaction transaction) async {
        CollectionReference reference =
            FirebaseFirestore.instance.collection('clientes');

        QuerySnapshot querySnapshot = await reference
            .doc(clientId)
            .collection('aquarios')
            .doc(aquarioId)
            .collection('peixes')
            .get();

        for (var doc in querySnapshot.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          String name = data['nome'] ?? '';
          String especie = data['especie'] ?? '';
          String agua = data['agua'] ?? '';
          String sexo = data['sexo'] ?? '';
          String id = doc.id;
          dataList.add(Fish(
              name: name, id: id, agua: agua, especie: especie, sexo: sexo));
        }
      });

      return dataList;
    } on Exception catch (e) {
      Fluttertoast.showToast(
        msg: "Error: ${e.toString()}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      return [];
    }
  }

  Future<Image?> getImageFromFirebaseStorage(String imageName) async {
    final storage = FirebaseStorage.instance;

    final imageReference =
        storage.ref().child("images/${imageName.toLowerCase()}.png");

    try {
      const oneMegabyte = 1024 * 1024;
      final imageData = await imageReference.getData(oneMegabyte);

      if (imageData == null) {
        throw Exception('Image not found.');
      }

      return Image.memory(imageData);
    } on FirebaseException catch (e) {
      print('Firebase Storage error: $e');
      Fluttertoast.showToast(
        msg: "Error accessing Firebase Storage: ${e.message}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return null;
    } catch (e) {
      print('Unexpected error: $e');
      Fluttertoast.showToast(
        msg: "An unexpected error occurred.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return null;
    }
  }
}
