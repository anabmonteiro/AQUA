import 'package:flutter/material.dart';

class UniversalCard extends StatefulWidget {
  final BorderSide borderSide;
  final double width;
  final Color color;
  final Widget? title;
  final Widget child;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;
  final double? height;
  const UniversalCard(
      {super.key,
      this.borderSide = BorderSide.none,
      required this.width,
      this.height,
      this.color = const Color.fromRGBO(217, 217, 217, 0.25),
      required this.borderRadius,
      this.title,
      required this.child,
      this.padding = const EdgeInsets.fromLTRB(12, 6, 12, 12)});

  @override
  State<UniversalCard> createState() => _UniversalCardState();
}

class _UniversalCardState extends State<UniversalCard> {
  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    if (widget.title != null) {
      children.add(widget.title!);
      children.add(widget.child);
    } else {
      children.add(widget.child);
    }
    return Card(
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: widget.borderRadius, side: widget.borderSide),
      color: widget.color,
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: Padding(
          padding: widget.padding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ),
    );
  }
}
