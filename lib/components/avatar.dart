import 'package:flutter/material.dart';
import 'package:optr/components/edges.dart';
import 'package:optr/helpers/colors_from_string.dart';
import 'package:optr/helpers/icons_helper.dart';

/// Avatar for Account Passwords
class OptrAvatar extends StatelessWidget {
  final String name;

  /// Creates an instance of Optr Avatar
  const OptrAvatar(this.name, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final palette = colorFromString(name);

    Widget _buildLogoOrInitial(String name) {
      final logo = Icon(getFontAwesomeIcon(name: name.toLowerCase()));
      if (logo.icon != null) {
        return logo;
      }

      return Text(
        palette.initials,
        style: Theme.of(context).textTheme.headline6.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
      );
    }

    return OptrEdges(
      corners: NotchedCorner.cross(15, 0),
      color: palette.borderColor,
      child: Container(
        width: 60.0,
        height: 60.0,
        child: Center(
          child: _buildLogoOrInitial(name),
        ),
      ),
    );
  }
}
