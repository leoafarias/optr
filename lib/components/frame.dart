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
    this.child,
  }) : super(key: key);

  @override
  _FrameState createState() => _FrameState();
}

class _FrameState extends State<Frame> {
  @override
  void initState() {
    super.initState();

    SoundEffect.play(SoundEffect.deploy);
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
    _drawRect(canvas, configuration.size);
    _drawCorners(canvas, configuration.size);
  }

  void _drawCorners(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor.withOpacity(step)
      ..strokeWidth = cornerStroke
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    final length = step * size.shortestSide * cornerLengthRatio;

    final topLeftCorner = Path()
      ..lineTo(length, 0.0)
      ..moveTo(0.0, 0.0)
      ..lineTo(0.0, length);

    canvas.drawPath(topLeftCorner, paint);

    final topRightCorner = Path()
      ..moveTo(size.width - length, 0.0)
      ..lineTo(size.width, 0.0)
      ..lineTo(size.width, length);

    canvas.drawPath(topRightCorner, paint);

    final bottomLeftCorner = Path()
      ..moveTo(0.0, size.height - length)
      ..lineTo(0.0, size.height)
      ..lineTo(length, size.height);

    canvas.drawPath(bottomLeftCorner, paint);

    final bottomRightCorner = Path()
      ..moveTo(size.width, size.height - length)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width - length, size.height);

    canvas.drawPath(bottomRightCorner, paint);
  }

  void _drawRect(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor.withOpacity(step)
      ..strokeWidth = lineStroke
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    canvas.drawPath(_topPath(size), paint);
    canvas.drawPath(_rightPath(size), paint);
    canvas.drawPath(_bottomPath(size), paint);
    canvas.drawPath(_leftPath(size), paint);
  }

  Path _topPath(Size size) {
    final start = Tween<double>(begin: size.width / 2, end: 0.0);
    final length = Tween<double>(begin: size.width / 2, end: size.width);

    final path = Path();
    path.moveTo(start.transform(step), 0.0);
    path.lineTo(length.transform(step), 0.0);

    return path;
  }

  Path _rightPath(Size size) {
    final start = Tween<double>(begin: size.height / 2, end: 0.0);
    final length = Tween<double>(begin: size.height / 2, end: size.height);

    final path = Path();
    path.moveTo(size.width, start.transform(step));
    path.lineTo(size.width, length.transform(step));

    return path;
  }

  Path _bottomPath(Size size) {
    final start = Tween<double>(begin: size.width / 2, end: 0.0);
    final length = Tween<double>(begin: size.width / 2, end: size.width);

    final path = Path();
    path.moveTo(start.transform(step), size.height);
    path.lineTo(length.transform(step), size.height);

    return path;
  }

  Path _leftPath(Size size) {
    final start = Tween<double>(begin: size.height / 2, end: 0.0);
    final length = Tween<double>(begin: size.height / 2, end: size.height);

    final path = Path();
    path.moveTo(0.0, start.transform(step));
    path.lineTo(0.0, length.transform(step));

    return path;
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
