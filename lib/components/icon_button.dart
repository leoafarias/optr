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
  const OptrIconButton({
    @required this.icon,
    @required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: icon,
      padding: const EdgeInsets.all(8.0),
      onPressed: onPressed,
      constraints: const BoxConstraints(),
      elevation: 0.0,
    );
  }
}
