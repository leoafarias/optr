import 'package:flutter/material.dart';
import 'package:optr/components/edge.dart';

/// Generic wrapper for Optr
class Wrapper extends StatelessWidget {
  /// Child Widget
  final Widget child;

  /// Constructor
  const Wrapper({this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OptrEdges(
        corners: EdgeCorners.only(25, 25, 0, 40),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: OptrEdges(
              child: child,
              corners: EdgeCorners.only(25, 25, 0, 40),
              color: Color.fromRGBO(10, 10, 10, 1)),
        ),
      ),
    );
  }
}
