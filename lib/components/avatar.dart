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
    return OptrDoubleEdge(
      corners: const EdgeCorners.only(0, 0, 0, 0),
      color: Colors.black.withOpacity(0.95),
      borderColor: palette.borderColor,
      child: Container(
        width: 60.0,
        height: 60.0,
        child: Center(
          child: Text(
            palette.initials,
            style: Theme.of(context).textTheme.headline6.copyWith(
                  color: palette.borderColor,
                ),
          ),
        ),
      ),
    );
  }
}
