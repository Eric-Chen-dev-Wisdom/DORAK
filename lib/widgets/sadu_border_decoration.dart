import 'package:flutter/material.dart';

/// A custom decoration that creates a Sadu-pattern border effect
class SaduBorderDecoration extends Decoration {
  final Color backgroundColor;
  final double borderWidth;
  final BorderRadius? borderRadius;
  final bool useCircularPattern;

  const SaduBorderDecoration({
    this.backgroundColor = Colors.white,
    this.borderWidth = 4.0,
    this.borderRadius,
    this.useCircularPattern = false,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _SaduBorderPainter(
      backgroundColor: backgroundColor,
      borderWidth: borderWidth,
      borderRadius: borderRadius,
      useCircularPattern: useCircularPattern,
    );
  }
}

class _SaduBorderPainter extends BoxPainter {
  final Color backgroundColor;
  final double borderWidth;
  final BorderRadius? borderRadius;
  final bool useCircularPattern;

  _SaduBorderPainter({
    required this.backgroundColor,
    required this.borderWidth,
    this.borderRadius,
    required this.useCircularPattern,
  });

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final rect = offset & configuration.size!;
    
    // Draw background
    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    
    if (borderRadius != null) {
      canvas.drawRRect(
        borderRadius!.toRRect(rect),
        bgPaint,
      );
    } else {
      canvas.drawRect(rect, bgPaint);
    }
    
    // Draw Sadu pattern border
    _drawSaduBorder(canvas, rect);
  }

  void _drawSaduBorder(Canvas canvas, Rect rect) {
    // Sadu colors: Red, Black, White
    final colors = [
      const Color(0xFFD32F2F), // Red
      const Color(0xFF000000), // Black
      const Color(0xFFFFFFFF), // White
      const Color(0xFFB71C1C), // Dark Red
    ];

    // Create geometric Sadu pattern along borders
    final paint = Paint()..style = PaintingStyle.fill;

    // Pattern size
    final patternSize = borderWidth * 3;
    
    // Top border
    for (double x = rect.left; x < rect.right; x += patternSize) {
      final colorIndex = ((x / patternSize) % colors.length).toInt();
      paint.color = colors[colorIndex];
      canvas.drawRect(
        Rect.fromLTWH(x, rect.top, patternSize / 2, borderWidth),
        paint,
      );
    }

    // Bottom border
    for (double x = rect.left; x < rect.right; x += patternSize) {
      final colorIndex = ((x / patternSize) % colors.length).toInt();
      paint.color = colors[colorIndex];
      canvas.drawRect(
        Rect.fromLTWH(x, rect.bottom - borderWidth, patternSize / 2, borderWidth),
        paint,
      );
    }

    // Left border
    for (double y = rect.top; y < rect.bottom; y += patternSize) {
      final colorIndex = ((y / patternSize) % colors.length).toInt();
      paint.color = colors[colorIndex];
      canvas.drawRect(
        Rect.fromLTWH(rect.left, y, borderWidth, patternSize / 2),
        paint,
      );
    }

    // Right border
    for (double y = rect.top; y < rect.bottom; y += patternSize) {
      final colorIndex = ((y / patternSize) % colors.length).toInt();
      paint.color = colors[colorIndex];
      canvas.drawRect(
        Rect.fromLTWH(rect.right - borderWidth, y, borderWidth, patternSize / 2),
        paint,
      );
    }

    // Draw corner decorations (diamond shapes)
    _drawCornerDiamonds(canvas, rect, paint);
  }

  void _drawCornerDiamonds(Canvas canvas, Rect rect, Paint paint) {
    final size = borderWidth * 2;
    paint.color = const Color(0xFFD32F2F);

    // Top-left
    _drawDiamond(canvas, Offset(rect.left + size, rect.top + size), size, paint);
    
    // Top-right
    _drawDiamond(canvas, Offset(rect.right - size, rect.top + size), size, paint);
    
    // Bottom-left
    _drawDiamond(canvas, Offset(rect.left + size, rect.bottom - size), size, paint);
    
    // Bottom-right
    _drawDiamond(canvas, Offset(rect.right - size, rect.bottom - size), size, paint);
  }

  void _drawDiamond(Canvas canvas, Offset center, double size, Paint paint) {
    final path = Path()
      ..moveTo(center.dx, center.dy - size / 2)
      ..lineTo(center.dx + size / 2, center.dy)
      ..lineTo(center.dx, center.dy + size / 2)
      ..lineTo(center.dx - size / 2, center.dy)
      ..close();
    canvas.drawPath(path, paint);
  }
}

/// Widget for containers with Sadu pattern borders
class SaduBorderedContainer extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final double borderWidth;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final bool useCircularPattern;

  const SaduBorderedContainer({
    super.key,
    required this.child,
    this.backgroundColor = Colors.white,
    this.borderWidth = 4.0,
    this.borderRadius,
    this.padding,
    this.width,
    this.height,
    this.useCircularPattern = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: SaduBorderDecoration(
        backgroundColor: backgroundColor,
        borderWidth: borderWidth,
        borderRadius: borderRadius,
        useCircularPattern: useCircularPattern,
      ),
      padding: padding ?? EdgeInsets.all(borderWidth * 2),
      child: child,
    );
  }
}

/// Widget for Sadu pattern image borders (using the actual images)
class SaduImageBorder extends StatelessWidget {
  final Widget child;
  final double borderWidth;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final bool useCircular;

  const SaduImageBorder({
    super.key,
    required this.child,
    this.borderWidth = 40.0,
    this.borderRadius,
    this.padding,
    this.useCircular = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
        border: Border.all(
          width: 0,
          color: Colors.transparent,
        ),
      ),
      child: Stack(
        children: [
          // Border image
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                image: DecorationImage(
                  image: AssetImage(
                    useCircular 
                      ? 'assets/images/saudi.jpg'
                      : 'assets/images/Kuwaiti.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Inner white content area
          Container(
            margin: EdgeInsets.all(borderWidth),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: borderRadius != null
                  ? BorderRadius.circular(
                      borderRadius!.topLeft.x - borderWidth,
                    )
                  : null,
            ),
            padding: padding ?? const EdgeInsets.all(16),
            child: child,
          ),
        ],
      ),
    );
  }
}

