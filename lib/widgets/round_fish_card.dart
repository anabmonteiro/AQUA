import 'package:flutter/material.dart';

class RoundFishCard extends StatefulWidget {
  final Image? image;
 final Function() onTap;
  final String fishName;
  const RoundFishCard(
      {super.key, required this.image, required this.fishName,required this.onTap});

  @override
  State<RoundFishCard> createState() => _RoundFishCardState();
}

class _RoundFishCardState extends State<RoundFishCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: InkWell(
                onTap: widget.onTap,
                child: Container(
                  height: 101,
                  width: 101,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(217, 217, 217, 0.25)),
                  child:Center(child: widget.image,),
                ),
              ),
            ),
            Text(
              widget.fishName,
              style: const TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                decoration: TextDecoration.none,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ],
        );
  }
}
