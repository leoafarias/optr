import 'package:flutter/material.dart';
import 'package:optr/components/edges.dart';
import 'package:optr/helpers/colors_from_string.dart';

/// Avatar for Account Passwords
class OptrAvatar extends StatelessWidget {
  final String _name;

  /// Creates an instance of Optr Avatar
  const OptrAvatar({String name, Key key})
      : _name = name,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final palette = colorFromString(_name);
    return OptrEdges(
      corners: const EdgeCorners.only(0, 0, 0, 0),
      child: Container(
        width: 40.0,
        height: 60.0,
        color: palette.bgColor,
        child: Center(
          child: Text(
            palette.initials,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: palette.textColor),
          ),
        ),
      ),
    );
  }
}
