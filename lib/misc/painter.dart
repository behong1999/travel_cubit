//NOTE: Create a circle below every tab's label
import 'package:flutter/material.dart';

class CircleTabIndicator extends Decoration {
  final Color color;
  final double radius;

  const CircleTabIndicator({
    required this.color,
    required this.radius,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  double radius;

  _CirclePainter({
    required this.color,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint _paint = Paint();

    _paint.color = color;

    final Offset circleOffset = Offset(configuration.size!.width / 2,
        configuration.size!.height * 0.9 - radius / 2);

    // Draw a circle on the canvas
    canvas.drawCircle(circleOffset + offset, radius, _paint);
  }
}
