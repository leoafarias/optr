import 'package:flutter/material.dart';

/// Icon Button
class OptrIconButton extends StatelessWidget {
  /// Icon for the button
  final Icon icon;

  /// Color for the button
  final Color color;

  /// On press callback
  final Function onPressed;

  /// Constructor
  const OptrIconButton(
      {@required this.icon,
      @required this.onPressed,
      this.color = Colors.teal});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: color,
      child: icon,
      padding: EdgeInsets.all(8.0),
      onPressed: onPressed,
      shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(0),
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(0))),
      constraints: BoxConstraints(),
      elevation: 0.0,
    );
  }
}
