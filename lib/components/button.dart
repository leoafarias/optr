import 'package:flutter/material.dart';
import 'package:optr/components/frame.dart';
import 'package:optr/helpers/sound_effect.dart';

class OptrButton extends StatelessWidget {
  final Widget label;
  final Widget icon;
  final Color color;
  final Color borderColor;
  final Color textColor;
  final Color backgroundColor;
  final EdgeInsets padding;
  final Future<int> soundEffect;
  final VoidCallback onTap;

  const OptrButton({
    Key key,
    @required this.label,
    this.icon,
    this.color,
    this.borderColor,
    this.textColor,
    this.backgroundColor,
    this.padding = const EdgeInsets.all(15.0),
    this.soundEffect,
    this.onTap,
  }) : super(key: key);

  factory OptrButton.success({
    Key key,
    @required Widget label,
    Widget icon,
    EdgeInsets padding = const EdgeInsets.all(15.0),
    VoidCallback onTap,
  }) {
    return OptrButton(
      key: key,
      label: label,
      icon: icon,
      padding: padding,
      onTap: onTap,
      color: Colors.green,
      textColor: Colors.green,
      borderColor: Colors.lightGreenAccent,
      soundEffect: SoundEffect.information,
    );
  }

  factory OptrButton.active({
    Key key,
    Widget label,
    Widget icon,
    EdgeInsets padding = const EdgeInsets.all(15.0),
    VoidCallback onTap,
  }) {
    return OptrButton(
      key: key,
      label: label,
      icon: icon,
      padding: padding,
      onTap: onTap,
      color: Colors.tealAccent,
      textColor: Colors.tealAccent,
      backgroundColor: Colors.black.withOpacity(0.9),
      borderColor: Colors.tealAccent,
      soundEffect: SoundEffect.click,
    );
  }

  factory OptrButton.cancel({
    Key key,
    Widget label,
    Widget icon,
    EdgeInsets padding = const EdgeInsets.all(15.0),
    VoidCallback onTap,
  }) {
    return OptrButton(
      key: key,
      label: label,
      icon: icon,
      padding: padding,
      onTap: onTap,
      color: Colors.tealAccent,
      textColor: Colors.tealAccent,
      backgroundColor: Colors.black.withOpacity(0.9),
      borderColor: Colors.tealAccent,
      soundEffect: SoundEffect.error,
    );
  }

  factory OptrButton.error({
    Key key,
    Widget label,
    Widget icon,
    EdgeInsets padding = const EdgeInsets.all(15.0),
    VoidCallback onTap,
  }) {
    return OptrButton(
      key: key,
      label: label,
      icon: icon,
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
    return Frame(
      color:
          backgroundColor ?? Theme.of(context).backgroundColor.withOpacity(0.6),
      lineColor: borderColor ?? Theme.of(context).accentColor,
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.2),
          blurRadius: 3.0,
          spreadRadius: 3.0,
        )
      ],
      child: _buildFlatButton(),
    );
  }

  Widget _buildFlatButton() {
    if (icon == null) {
      return FlatButton(
        onPressed: _onPressed,
        highlightColor: color,
        splashColor: color.withOpacity(0.3),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: padding,
        textColor: textColor,
        child: label,
      );
    } else if (label == null) {
      return IconButton(
        onPressed: _onPressed,
        color: color,
        splashColor: color.withOpacity(0.3),
        padding: padding,
        icon: icon,
      );
    } else {
      return FlatButton.icon(
        onPressed: _onPressed,
        highlightColor: color,
        splashColor: color.withOpacity(0.3),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: padding,
        textColor: textColor,
        icon: icon,
        label: label,
      );
    }
  }
}
