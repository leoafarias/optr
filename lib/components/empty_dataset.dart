import 'package:flutter/material.dart';

/// EmptyDataset class
class EmptyDataset extends StatelessWidget {
  /// Message to be displayed
  final String message;

  /// Icon to be displayed
  final IconData icon;

  /// Instance of the empty dataset
  const EmptyDataset({this.message, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Opacity(
        opacity: 0.2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(icon, size: 50.0),
                const SizedBox(height: 20.0),
                Text(message, style: const TextStyle(fontSize: 18.0))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
