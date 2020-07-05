import 'package:flutter/material.dart';
import 'package:optr/helpers/sound_effect.dart';

import 'package:simple_animations/simple_animations.dart';

class Frame extends StatefulWidget {
  final Color color;
  final Color lineColor;
  final double lineStroke;
  final double cornerStroke;
  final double cornerLengthRatio;
  final Gradient gradient;
  final List<BoxShadow> boxShadow;
  final BlendMode backgroundBlendMode;
  final DecorationPosition position;
  final bool enableSoundEffect;
  final Future<int> soundEffect;
  final Widget child;

  const Frame({
    Key key,
    this.color,
    this.lineColor,
    this.lineStroke = 1.0,
    this.cornerStroke = 3.0,
    this.cornerLengthRatio = 0.15,
    this.gradient,
    this.boxShadow,
    this.backgroundBlendMode,
    this.position = DecorationPosition.background,
    this.enableSoundEffect = false,
    this.soundEffect,
    this.child,
  }) : super(key: key);

  @override
  _FrameState createState() => _FrameState();
}

class _FrameState extends State<Frame> {
  @override
  void initState() {
    super.initState();

    if (widget.enableSoundEffect) {
      SoundEffect.play(widget.soundEffect ?? SoundEffect.deploy);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PlayAnimation<double>(
      child: widget.child,
      curve: Curves.fastOutSlowIn,
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      builder: (context, child, value) {
        return DecoratedBox(
          position: widget.position,
          decoration: FrameDecoration(
            step: value,
            color: widget.color,
            lineColor: widget.lineColor ?? Theme.of(context).primaryColor,
            lineStroke: widget.lineStroke,
            cornerStroke: widget.cornerStroke,
            cornerLengthRatio: widget.cornerLengthRatio,
            gradient: widget.gradient,
            boxShadow: widget.boxShadow,
            backgroundBlendMode: widget.backgroundBlendMode,
          ),
          child: child,
        );
      },
    );
  }
}

class FrameDecoration extends Decoration {
  final double step;
  final Color color;
  final Color lineColor;
  final double lineStroke;
  final double cornerStroke;
  final double cornerLengthRatio;
  final Gradient gradient;
  final List<BoxShadow> boxShadow;
  final BlendMode backgroundBlendMode;

  const FrameDecoration({
    @required this.lineColor,
    this.color,
    this.step = 1.0,
    this.lineStroke = 1.0,
    this.cornerStroke = 3.0,
    this.cornerLengthRatio = 0.15,
    this.gradient,
    this.boxShadow,
    this.backgroundBlendMode,
  });

  @override
  BoxPainter createBoxPainter([onChanged]) {
    return _FrameDecorationPainter(
      step: step,
      color: color,
      lineColor: lineColor,
      lineStroke: lineStroke,
      cornerStroke: cornerStroke,
      cornerLengthRatio: cornerLengthRatio,
      gradient: gradient,
      boxShadow: boxShadow,
      backgroundBlendMode: backgroundBlendMode,
    );
  }
}

class _FrameDecorationPainter extends BoxPainter {
  final double step;
  final Color color;
  final Color lineColor;
  final double lineStroke;
  final double cornerStroke;
  final double cornerLengthRatio;
  final Gradient gradient;
  final List<BoxShadow> boxShadow;
  final BlendMode backgroundBlendMode;

  const _FrameDecorationPainter({
    this.step = 1.0,
    this.color,
    @required this.lineColor,
    @required this.lineStroke,
    @required this.cornerStroke,
    @required this.cornerLengthRatio,
    this.gradient,
    this.boxShadow,
    this.backgroundBlendMode,
  });

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final rect = offset & configuration.size;

    _paintShadows(canvas, rect);
    _paintBackgroundColor(canvas, rect);
    _drawRect(canvas, rect);
    _drawCorners(canvas, rect);
  }

  void _drawCorners(Canvas canvas, Rect rect) {
    final paint = Paint()
      ..color = lineColor.withOpacity(step)
      ..strokeWidth = cornerStroke
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    final length = step * rect.shortestSide * cornerLengthRatio;

    final topLeftCorner = Path()
      ..moveTo(rect.topLeft.dx, rect.topLeft.dy + length)
      ..relativeLineTo(0.0, -length)
      ..relativeLineTo(length, 0.0);

    canvas.drawPath(topLeftCorner, paint);

    final topRightCorner = Path()
      ..moveTo(rect.topRight.dx - length, rect.topRight.dy)
      ..relativeLineTo(length, 0.0)
      ..relativeLineTo(0.0, length);

    canvas.drawPath(topRightCorner, paint);

    final bottomLeftCorner = Path()
      ..moveTo(rect.bottomLeft.dx, rect.bottomLeft.dy - length)
      ..relativeLineTo(0.0, length)
      ..relativeLineTo(length, 0.0);

    canvas.drawPath(bottomLeftCorner, paint);

    final bottomRightCorner = Path()
      ..moveTo(rect.bottomRight.dx - length, rect.bottomRight.dy)
      ..relativeLineTo(length, 0.0)
      ..relativeLineTo(0.0, -length);

    canvas.drawPath(bottomRightCorner, paint);
  }

  void _drawRect(Canvas canvas, Rect rect) {
    final paint = Paint()
      ..color = lineColor.withOpacity(step)
      ..strokeWidth = lineStroke
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    canvas.drawPath(_topPath(rect), paint);
    canvas.drawPath(_rightPath(rect), paint);
    canvas.drawPath(_bottomPath(rect), paint);
    canvas.drawPath(_leftPath(rect), paint);
  }

  Path _topPath(Rect rect) {
    final tween = RectTween(
      begin: Rect.zero.shift(rect.topCenter),
      end: rect,
    ).transform(step);

    return Path()
      ..moveTo(tween.topLeft.dx, tween.topLeft.dy)
      ..relativeLineTo(tween.width, 0.0);
  }

  Path _rightPath(Rect rect) {
    final tween = RectTween(
      begin: Rect.zero.shift(rect.centerRight),
      end: rect,
    ).transform(step);

    return Path()
      ..moveTo(tween.topRight.dx, tween.topRight.dy)
      ..relativeLineTo(0.0, tween.height);
  }

  Path _bottomPath(Rect rect) {
    final tween = RectTween(
      begin: Rect.zero.shift(rect.bottomCenter),
      end: rect,
    ).transform(step);

    return Path()
      ..moveTo(tween.bottomLeft.dx, tween.bottomLeft.dy)
      ..relativeLineTo(tween.width, 0.0);
  }

  Path _leftPath(Rect rect) {
    final tween = RectTween(
      begin: Rect.zero.shift(rect.centerLeft),
      end: rect,
    ).transform(step);

    return Path()
      ..moveTo(tween.topLeft.dx, tween.topLeft.dy)
      ..relativeLineTo(0.0, tween.height);
  }

  void _paintShadows(Canvas canvas, Rect rect) {
    if (boxShadow == null) {
      return;
    }

    for (final shadow in boxShadow) {
      final paint = shadow.toPaint();
      final bounds = rect.shift(shadow.offset).inflate(shadow.spreadRadius);
      canvas.drawRect(bounds, paint);
    }
  }

  void _paintBackgroundColor(Canvas canvas, Rect rect) {
    if (color == null) {
      return;
    }

    final paint = Paint();

    if (backgroundBlendMode != null) paint.blendMode = backgroundBlendMode;
    if (color != null) paint.color = color;
    if (gradient != null) {
      paint.shader = gradient.createShader(rect);
    }

    canvas.drawRect(rect, paint);
  }
}
