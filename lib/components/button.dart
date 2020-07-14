import 'package:flutter/material.dart';
import 'package:optr/components/cut_edges_decoration.dart';

class OptrButton extends StatelessWidget {
  final Widget child;
  final Function() onPressed;
  const OptrButton({this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(0),
        decoration: CutEdgesDecoration(
          color: Colors.red,
          lineColor: Theme.of(context).accentColor,
          lineStroke: 1.0,
          edges: const CutEdgeCorners.cross(10.0, 10.0),
        ),
        child: RawMaterialButton(
          fillColor: Colors.blue,
          padding: const EdgeInsets.all(0),
          child: child,
          onPressed: onPressed,
          shape: const BeveledRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
        ));
  }
}
