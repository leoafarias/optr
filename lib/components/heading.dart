import 'package:flutter/material.dart';

/// Avatar for Account Passwords
class OptrHeading extends StatelessWidget {
  final String text;
  final Color color;

  /// Creates an instance of Optr Avatar
  const OptrHeading({this.text, this.color, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline6.copyWith(color: color),
    );
  }
}
