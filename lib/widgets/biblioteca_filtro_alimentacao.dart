import 'package:aqua/servicos/servico_bluetooth.dart';
import 'package:aqua/telas/tela_biblioteca_filtro.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';




class FiltroAlimentacao extends StatelessWidget {
  const FiltroAlimentacao({super.key});

  @override
  Widget build(BuildContext context) {
    final ServicoBluetooth task =
        ServicoBluetooth.of(context, rebuildOnChange: false);
    return  Column(
        children: [
          _buildListItem(
            title: 'Peixe betta: Alimentação e cuidados principais',
            text: 'O alimento cru trás riscos para a saúde canina, mas é possível ofertá-lo de...',
            image: const AssetImage('assets/images/biblioteca/materia_um.png'),
            onTap: () {

              Navigator.push(context, MaterialPageRoute(builder: ((context) => ScopedModel<ServicoBluetooth>(
                        model: task,
                        child: const TelaBibliotecaFiltro()
                          
              ))));
            },
          ),
          _buildListItem(
            title: 'Guia completo para alimentação do peixe-dourado',
            text: 'Apesesar da variedade da espécie, os peixes-dourados são onívoros e...',
            image:
                const AssetImage('assets/images/biblioteca/materia_dois.png'),
          ),
          _buildListItem(
            title: 'Saiba tudo sobre o tetra neon',
            text: 'A recomendação é alimentar seu peixe três vezes ao dia, sua dieta é composta de...',
            image:
                const AssetImage('assets/images/biblioteca/materia_tres.png'),
          ),
          _buildListItem(
            title: 'Colisa: Alimentação e cuidados principais',
            text: 'Trata-se de um peixe onívero de água doce, recomenda-se alimentá-lo cerca...',
            image:
                const AssetImage('assets/images/biblioteca/materia_quatro.png'),
          ),
          _buildListItem(
            title: 'Tudo e mais sobre o peixe Coridora',
            text: 'Recomenda-se alimentá-los cerca de 2 a 3 vezes ao dieta, numa dieta composta de...',
            image:
                const AssetImage('assets/images/biblioteca/materia_cinco.png'),
          ),
        ],
      );
    
  }

  Widget _buildListItem({
    String? title,
    String? text,
    AssetImage? image,
    VoidCallback? onTap,
  }) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          title: Text(title!, style: const TextStyle(fontSize: 15),),
          subtitle: Text(text!, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w200),),
          trailing: Image(
            image: image!,
            width: 60, // Ajuste o tamanho conforme necessário
            height: 60, // Ajuste o tamanho conforme necessário
          ),
          onTap: onTap,
        ),
        const Divider(
          color: Colors.grey,
          thickness: 0.5,
          height: 0,
        ),
      ],
    );
  }
}
