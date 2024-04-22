import 'package:flutter/material.dart';

class TagCard extends StatefulWidget {
  final String text;
  final Function() onTap;
  final Color? color;
  const TagCard({
    super.key,
    required this.text,
    required this.onTap,
    this.color = Colors.transparent,
  });

  @override
  State<TagCard> createState() => _TagCardState();
}

class _TagCardState extends State<TagCard> {
  // Remove the isSelected variable

  @override
  void initState() {
    super.initState();
    // Listen for selection changes from provider
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap();
      },
      child: Card(
        surfaceTintColor: Colors.transparent,
        color: Colors.transparent, // Update color based on selection
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          side: BorderSide.none,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(widget.text),
        ),
      ),
    );
  }
}
