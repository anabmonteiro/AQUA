import 'package:flutter/material.dart';

class InputTexto extends StatefulWidget {
  final String text;

  const InputTexto({
    super.key,
    this.text = 'Enter text',
  });

  @override
  State<StatefulWidget> createState() {
    return _InputTextoState();
  }
}

class _InputTextoState extends State<InputTexto> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 325,
        maxHeight: 46,
        minWidth: 325,
        minHeight: 46,
      ),
      child: TextField(
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide.none),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelStyle: const TextStyle(
            fontFamily: 'Poppins',
            decoration: TextDecoration.none,
            fontSize: 17.0,
            fontWeight: FontWeight.normal,
          ),
          labelText: widget.text,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12.0,
          ),
        ),
      ),
    );
  }
}
