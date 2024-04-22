import 'package:flutter/material.dart';

class SwitchButton extends StatefulWidget {
  final bool value;
  final void Function(bool) onChanged;
  const SwitchButton({super.key, required this.value, required this.onChanged});

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  @override
  Widget build(BuildContext context) {
    final MaterialStateProperty<Color?> trackColor =
        MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        // Always set track color to black.
        return const Color.fromRGBO(222, 225, 227, 1);
      },
    );

    final MaterialStateProperty<Color?> thumbColor =
        MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        // Thumb color when the switch is selected.
        if (states.contains(MaterialState.selected)) {
          return const Color.fromARGB(
              255, 255, 147, 30); // Change thumb color to orange when selected.
        }
        // Otherwise return default thumb color (blue).
        return const Color.fromARGB(255, 63, 139, 215);
      },
    );

    return Switch(
      value: widget.value,
      onChanged: widget.onChanged,
      overlayColor: null, // We don't need overlay color.
      trackColor: trackColor,
      thumbColor: thumbColor,
    );
  }
}
