import 'package:aqua/servicos/servico_firebase.dart';
import 'package:aqua/telas/tela_conexao.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class Autenticador extends StatelessWidget {
  const Autenticador({super.key});

  @override
  Widget build(BuildContext context) {


    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          
          return SignInScreen(
            showPasswordVisibilityToggle: true,
            providers: [
              EmailAuthProvider(),
            ],
            actions: [
             
              AuthStateChangeAction<SignedIn>((context, state) {
                FirebaseService()
                    .addCliente(snapshot.data!.uid, snapshot.data!.email!);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  TelaConexao(userData: false)
                  ),
                );
              })
            ],
            headerBuilder: (context, constraints, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(0,70,0,30),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset('assets/images/logo.png'),
                ),
              );
            },
          );
          
        }
        
        FirebaseService().addCliente(snapshot.data!.uid, snapshot.data!.email!);
        return TelaConexao(userData: true);
      },
    );
  }
}
