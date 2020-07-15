import 'package:flutter/material.dart';
import 'package:optr/components/edges.dart';

class OptrButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final NotchedCorner edgeCorners;
  final TextStyle textStyle;
  final Color color;
  const OptrButton({
    this.label,
    this.onPressed,
    this.edgeCorners = const NotchedCorner.cross(10, 0),
    this.color,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final _color = color ?? Theme.of(context).buttonColor;
    final _textStyle = textStyle ?? Theme.of(context).textTheme.button;

    final shapeBorder = BeveledRectangleBorder(
      side: BorderSide(
        width: 1,
        color: _color,
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(edgeCorners.topLeft),
        topRight: Radius.circular(edgeCorners.topRight),
        bottomRight: Radius.circular(edgeCorners.bottomRight),
        bottomLeft: Radius.circular(edgeCorners.bottomLeft),
      ),
    );

    final labelStyle = _textStyle.copyWith(color: _color);

    return Material(
      shape: shapeBorder,
      color: Colors.transparent,
      child: InkWell(
        highlightColor: _color.withOpacity(0.1),
        splashColor: _color.withOpacity(0.2),
        focusColor: _color.withOpacity(0.1),
        hoverColor: _color.withOpacity(0.1),
        customBorder: shapeBorder,
        onTap: onPressed,
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: Text(label, style: labelStyle),
        ),
      ),
    );
  }
}
