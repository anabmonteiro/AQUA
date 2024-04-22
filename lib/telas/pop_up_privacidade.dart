import 'package:aqua/telas/tela_privacidade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PopUpPrivacidade extends StatelessWidget {
  const PopUpPrivacidade({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, p1, p2) => AlertDialog(
        insetPadding: EdgeInsets.all(2.w),
        scrollable: true,
        backgroundColor: const Color.fromRGBO(82, 84, 87, 0.98),
        surfaceTintColor: Colors.transparent, // Cor de fundo
        title: const Text('Política de Privacidade', textAlign: TextAlign.center,),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Todas as informações são usadas para melhorar sua experiência e garantir o bom funcionamento do aplicativo. Seus dados pessoais nunca serão compartilhados com terceiros.',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w200),
              textAlign: TextAlign.justify,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
              child: Row(

                children: [
                  SizedBox(
                    width: 45,
                    height: 45,
                    child: ClipOval(
                      child: Container(
                        color: const Color.fromRGBO(217, 217, 217, 0.20),
                        width: 23,
                        height: 23,
                        child: Center(
                            child: SvgPicture.asset(
                                'assets/icones/priv_nome.svg')),
                      ),
                    ),
                  ),
                  Padding(
                    padding:  const EdgeInsets.fromLTRB(12, 0, 0, 0),
                    child: RichText(
                      text: const TextSpan(children: [
                        TextSpan(
                            text: 'Nome:',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: 'Poppins')),
                        TextSpan(
                          text:
                              ' Para personalizar sua\n experiência e comunicação\n conosco.',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                              fontFamily: 'Poppins'),
                        )
                      ]),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
              child: Row(
                children: [
                  SizedBox(
                    width: 45,
                    height: 45,
                    child: ClipOval(
                      child: Container(
                        color: const Color.fromRGBO(217, 217, 217, 0.20),
                        width: 23,
                        height: 23,
                        child: Center(
                            child: SvgPicture.asset(
                                'assets/icones/priv_email.svg')),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                    child: RichText(
                      text: const TextSpan(children: [
                        TextSpan(
                            text: 'E-mail:',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: 'Poppins')),
                        TextSpan(
                          text:
                              '  Para comunicações\n relacionadas ao serviço, como\n atualizações, notificações e\n suporte.',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                              fontFamily: 'Poppins'),
                        )
                      ]),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
              child: Row(
                children: [
                  SizedBox(
                    width: 45,
                    height: 45,
                    child: ClipOval(
                      child: Container(
                        color: const Color.fromRGBO(217, 217, 217, 0.20),
                        width: 23,
                        height: 23,
                        child: Center(
                            child:
                                SvgPicture.asset('assets/icones/priv_tel.svg')),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                    child: RichText(
                      text: const TextSpan(children: [
                        TextSpan(
                            text: 'Telefone:',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: 'Poppins')),
                        TextSpan(
                          text:
                              ' Para facilitar o suporte\n ao cliente e notificações, se\n autorizado por você.',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                              fontFamily: 'Poppins'),
                        )
                      ]),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 58, 8, 8),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(217, 217, 217, 0.35),
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                  ),
                  fixedSize: const Size(210, 46),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                child: const Text('Concordo'),
              ),
            ),
            TextButton(

                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TelaPrivacidade(),
                      ));
                },
                child: const Text('Ler mais',
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    )))
          ],
        ),
      ),
    );
  }
}
