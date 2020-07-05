import 'package:flutter/material.dart';

class CutEdgesDecoration extends Decoration {
  final Color color;
  final Color lineColor;
  final double lineStroke;
  final Gradient gradient;
  final List<BoxShadow> boxShadow;
  final BlendMode backgroundBlendMode;
  final CutEdgeCorners edges;

  const CutEdgesDecoration({
    @required this.edges,
    this.color,
    this.lineColor = Colors.black,
    this.lineStroke = 1.0,
    this.gradient,
    this.boxShadow,
    this.backgroundBlendMode,
  });

  @override
  BoxPainter createBoxPainter([onChanged]) {
    return _CutEdgesDecorationPainter(
      edges: edges,
      color: color,
      lineColor: lineColor,
      lineStroke: lineStroke,
      gradient: gradient,
      boxShadow: boxShadow,
      backgroundBlendMode: backgroundBlendMode,
    );
  }
}

class _CutEdgesDecorationPainter extends BoxPainter {
  final Color color;
  final Color lineColor;
  final double lineStroke;
  final Gradient gradient;
  final List<BoxShadow> boxShadow;
  final BlendMode backgroundBlendMode;
  final CutEdgeCorners edges;

  const _CutEdgesDecorationPainter({
    @required this.edges,
    this.color,
    this.lineColor,
    this.lineStroke,
    this.gradient,
    this.boxShadow,
    this.backgroundBlendMode,
  });

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final rect = offset & configuration.size;
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = lineStroke
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    final shape = BeveledRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(edges.topLeft),
        topRight: Radius.circular(edges.topRight),
        bottomRight: Radius.circular(edges.bottomRight),
        bottomLeft: Radius.circular(edges.bottomLeft),
      ),
    );

    if (boxShadow != null) {
      for (final shadow in boxShadow) {
        final paint = shadow.toPaint();
        final bounds = rect.shift(shadow.offset).inflate(shadow.spreadRadius);
        canvas.drawPath(shape.getOuterPath(bounds), paint);
      }
    }

    if (color != null) {
      final fill = Paint();

      if (backgroundBlendMode != null) fill.blendMode = backgroundBlendMode;
      if (color != null) fill.color = color;
      if (gradient != null) {
        fill.shader = gradient.createShader(rect);
      }

      canvas.drawPath(shape.getOuterPath(rect), fill);
    }

    canvas.drawPath(shape.getOuterPath(rect), paint);
  }
}

/// Helper for edge corners
class CutEdgeCorners {
  /// Top left corner
  final double topLeft;

  /// Top right corner
  final double topRight;

  /// Bottom right corner
  final double bottomRight;

  /// Bottom left corner
  final double bottomLeft;

  /// Constructor
  const CutEdgeCorners({
    this.topLeft = 0.0,
    this.topRight = 0.0,
    this.bottomLeft = 0.0,
    this.bottomRight = 0.0,
  });

  /// Creates edge corners by setting eacy corner individually
  const CutEdgeCorners.all(
    this.topLeft,
    this.topRight,
    this.bottomRight,
    this.bottomLeft,
  );

  /// Creates cross axis edge corners
  const CutEdgeCorners.cross(double topToBottom, double bottomToTop)
      : topLeft = bottomToTop,
        topRight = topToBottom,
        bottomRight = bottomToTop,
        bottomLeft = topToBottom;

  @override
  String toString() {
    return 'CutEdgeCorners{topLeft: $topLeft, '
        'topRight: $topRight, '
        'bottomRight: $bottomRight, '
        'bottomLeft: $bottomLeft}';
  }
}
