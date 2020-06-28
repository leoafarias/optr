import 'package:flutter/material.dart';
import 'package:optr/helpers/sound_effect.dart';
import 'package:simple_animations/simple_animations.dart';

class Frame extends StatefulWidget {
  final Color color;
  final double lineStrokeWidth;
  final double cornerStrokeWidth;
  final double cornerLengthRatio;
  final Widget child;

  const Frame({
    Key key,
    this.color,
    this.lineStrokeWidth = 1.0,
    this.cornerStrokeWidth = 3.0,
    this.cornerLengthRatio = 0.15,
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
        return CustomPaint(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: child,
          ),
          painter: _ShapePainter(
            step: value,
            lineStrokeWidth: widget.lineStrokeWidth,
            cornerStrokeWidth: widget.cornerStrokeWidth,
            cornerLengthRatio: widget.cornerLengthRatio,
            color: widget.color ?? Theme.of(context).primaryColor,
          ),
        );
      },
    );
  }
}

class _ShapePainter extends CustomPainter {
  final double step;
  final Color color;
  final double lineStrokeWidth;
  final double cornerStrokeWidth;
  final double cornerLengthRatio;

  const _ShapePainter({
    @required this.color,
    @required this.lineStrokeWidth,
    @required this.cornerStrokeWidth,
    @required this.cornerLengthRatio,
    this.step = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _drawRect(canvas, size);
    _drawCorners(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void _drawRect(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(step)
      ..strokeWidth = lineStrokeWidth
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

  void _drawCorners(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(step)
      ..strokeWidth = cornerStrokeWidth
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
}
