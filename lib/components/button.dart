import 'package:flutter/material.dart';
import 'package:optr/components/frame.dart';
import 'package:optr/helpers/sound_effect.dart';

class OptrButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final Color borderColor;
  final Color textColor;
  final Color backgroundColor;
  final TextStyle style;
  final EdgeInsets padding;
  final Future<int> soundEffect;
  final VoidCallback onTap;

  const OptrButton({
    Key key,
    @required this.label,
    this.icon,
    this.color = Colors.cyan,
    this.borderColor,
    this.textColor,
    this.backgroundColor,
    this.style,
    this.padding = const EdgeInsets.all(15.0),
    this.soundEffect,
    this.onTap,
  }) : super(key: key);

  factory OptrButton.success({
    Key key,
    @required String label,
    IconData icon = Icons.check,
    TextStyle style,
    EdgeInsets padding = const EdgeInsets.all(15.0),
    VoidCallback onTap,
  }) {
    return OptrButton(
      key: key,
      label: label,
      icon: icon,
      style: style,
      padding: padding,
      onTap: onTap,
      color: Colors.green,
      textColor: Colors.green,
      borderColor: Colors.lightGreenAccent,
      soundEffect: SoundEffect.information,
    );
  }

  factory OptrButton.error({
    Key key,
    @required String label,
    IconData icon,
    TextStyle style,
    EdgeInsets padding = const EdgeInsets.all(15.0),
    VoidCallback onTap,
  }) {
    return OptrButton(
      key: key,
      label: label,
      icon: icon,
      style: style,
      padding: padding,
      onTap: onTap,
      color: Colors.red,
      textColor: Colors.red,
      borderColor: Colors.redAccent,
      soundEffect: SoundEffect.error,
    );
  }

  void _onPressed() {
    SoundEffect.play(soundEffect ?? SoundEffect.click);

    if (onTap != null) {
      onTap();
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttonTheme = Theme.of(context).textTheme.button;
    final style = this.style ?? buttonTheme.copyWith(color: textColor);

    return Frame(
      color: backgroundColor ?? Colors.black.withOpacity(0.6),
      lineColor: borderColor ?? Colors.cyan[50],
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.5),
          blurRadius: 6.0,
          spreadRadius: 6.0,
        )
      ],
      child: FlatButton.icon(
        onPressed: _onPressed,
        highlightColor: color,
        splashColor: color.withOpacity(0.3),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: padding,
        icon: Icon(icon, color: style.color),
        label: Text(label, style: style),
      ),
    );
  }
}
