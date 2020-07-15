import 'package:flutter/material.dart';
import 'package:optr/components/edges.dart';

class OptrButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final NotchedCorner edgeCorners;
  final TextStyle textStyle;
  final Color color;
  final IconData icon;
  const OptrButton({
    this.label,
    this.onPressed,
    this.edgeCorners = const NotchedCorner.cross(10, 0),
    this.color,
    this.textStyle,
    this.icon,
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

    Widget _renderLabel() {
      if (label == null) return const SizedBox();
      return Text(label, style: labelStyle);
    }

    Widget _renderIcon() {
      if (icon == null) return const SizedBox();
      return Icon(icon, color: _color);
    }

    Widget _renderSpace() {
      if (label == null || icon == null) return const SizedBox();
      return const SizedBox(width: 5);
    }

    Widget renderElement() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _renderIcon(),
          _renderSpace(),
          _renderLabel(),
        ],
      );
    }

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
          child: renderElement(),
        ),
      ),
    );
  }
}
