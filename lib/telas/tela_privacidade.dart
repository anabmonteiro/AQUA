import 'package:flutter/material.dart';

class TelaPrivacidade extends StatelessWidget {
  const TelaPrivacidade({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/fundo.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          appBar: AppBar(
            
            title: const Text(
              'Política de Privacidade',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            
          ),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Center(
              child: SizedBox(
                width: 360,
                child: Column(
                  children: [
                   
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0,0,0,25),
                      child: Text(
                        'Agradecemos por utilizar o aplicativo Aqua para monitoramento de aquários. Sua privacidade é de extrema importância para nós. Esta Política de Privacidade descreve como coletamos, usamos, compartilhamos e protegemos suas informações pessoais ao utilizar nosso aplicativo.',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          decoration: TextDecoration.none,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal,
                          fontSize: 14.0,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,0,25),
                      child: RichText(
                        text: const TextSpan(children: [
                          TextSpan(
                            text: '1. Informações Coletadas\n',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w800,
                              fontSize: 14.0,
                              color: Color.fromRGBO(255, 255, 255, 1.0),
                            ),
                          ),
                          TextSpan(
                            text:
                                'Ao utilizar o aplicativo Aqua, podemos coletar as seguintes informações pessoais:\n    - Nome: Para personalizar sua experiência e comunicação conosco.\n    - E-mail: Para comunicações relacionadas ao serviço, como atualizações, notificações e suporte.\n    - Telefone: Opcionalmente, para facilitar o suporte ao cliente e notificações por SMS, se autorizado por você.\n Além disso, podemos coletar informações não pessoais sobre seu dispositivo, como tipo de dispositivo, sistema operacional e dados de uso.',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                              fontSize: 14.0,
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                          ),
                        ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,0,25),
                      child: RichText(
                        text: const TextSpan(children: [
                          TextSpan(
                            text: '2. Uso das Informações\n',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w800,
                              fontSize: 14.0,
                              color: Color.fromRGBO(255, 255, 255, 1.0),
                            ),
                          ),
                          TextSpan(
                            text:
                                'As informações pessoais coletadas podem ser usadas para os seguintes fins:\n     - Fornecer e Manter o Serviço: Para operar, manter e melhorar o aplicativo Aqua.\n     - Comunicações: Para enviar notificações importantes, atualizações de serviço e responder às suas consultas.\n     - Personalização: Para personalizar sua experiência e conteúdo do aplicativo.\n     - Análise: Para entender como o aplicativo é usado, detectar problemas técnicos e melhorar nossos serviços.',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                              fontSize: 14.0,
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                          ),
                        ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,0,25),
                      child: RichText(
                        text: const TextSpan(children: [
                          TextSpan(
                            text: '3. Compartilhamento de Informações\n',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w800,
                              fontSize: 14.0,
                              color: Color.fromRGBO(255, 255, 255, 1.0),
                            ),
                          ),
                          TextSpan(
                            text:
                                'Não compartilhamos suas informações pessoais com terceiros, exceto nas seguintes circunstâncias:\n     - Com Seu Consentimento: Compartilharemos suas informações com terceiros apenas com seu consentimento explícito.\n     - Parceiros de Serviço: Podemos compartilhar suas informações com provedores de serviços terceirizados que nos ajudam a fornecer e manter o aplicativo Aqua.\n     - Conformidade Legal: Podemos divulgar suas informações se exigido por lei ou conforme necessário para proteger nossos direitos legais.',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                              fontSize: 14.0,
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                          ),
                        ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,0,25),
                      child: RichText(
                        text: const TextSpan(children: [
                          TextSpan(
                            text: '4. Proteção de Dados\n',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w800,
                              fontSize: 14.0,
                              color: Color.fromRGBO(255, 255, 255, 1.0),
                            ),
                          ),
                          TextSpan(
                            text:
                                ' Tomamos medidas razoáveis para proteger suas informações pessoais contra acesso não autorizado, alteração, divulgação ou destruição. No entanto, lembre-se de que nenhum método de transmissão pela internet ou armazenamento eletrônico é 100% seguro.',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                              fontSize: 14.0,
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                          ),
                        ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,0,25),
                      child: RichText(
                        text: const TextSpan(children: [
                          TextSpan(
                            text: '5. Seus Direitos de Privacidade\n',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w800,
                              fontSize: 14.0,
                              color: Color.fromRGBO(255, 255, 255, 1.0),
                            ),
                          ),
                          TextSpan(
                            text:
                                ' Você tem o direito de acessar, corrigir, atualizar ou excluir suas informações pessoais. Você também pode optar por não receber nossas comunicações a qualquer momento.',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                              fontSize: 14.0,
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                          ),
                        ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,0,25),
                      child: RichText(
                        text: const TextSpan(children: [
                          TextSpan(
                            text: '6. Consentimento\n',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w800,
                              fontSize: 14.0,
                              color: Color.fromRGBO(255, 255, 255, 1.0),
                            ),
                          ),
                          TextSpan(
                            text:
                                ' Ao utilizar o aplicativo Aqua, você consente com esta Política de Privacidade e com o       processamento de suas informações pessoais conforme descrito aqui. Última atualização: 30/03/2024',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                              fontSize: 14.0,
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                          ),
                        ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,0,25),
                      child: RichText(
                        text: const TextSpan(children: [
                          TextSpan(
                            text:
                                'Se você tiver dúvidas sobre esta Política de Privacidade ou sobre o uso de suas informações pessoais, entre em contato conosco aqui.\n\n',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                              fontSize: 14.0,
                              color: Color.fromRGBO(255, 255, 255, 1.0),
                            ),
                          ),
                          TextSpan(
                            text:
                                ' Obrigado por confiar em nós para cuidar da privacidade de suas informações!',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w800,
                              fontSize: 14.0,
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
