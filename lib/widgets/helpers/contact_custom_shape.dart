import 'package:flutter/material.dart';

import '../../colors/color_picker.dart';

enum ShapeStyle { whiteBorder, yellowFilled }

class CustomShapeImage extends StatefulWidget {
  final String firstImagePath;
  final String secondImagePath;
  final double width;
  final double height;
  final ShapeStyle style;

  const CustomShapeImage({
    required this.firstImagePath,
    required this.secondImagePath,
    this.width = 300,
    this.height = 400,
    this.style = ShapeStyle.whiteBorder,
    super.key,
  });

  @override
  State<CustomShapeImage> createState() => _CustomShapeImageState();
}

class _CustomShapeImageState extends State<CustomShapeImage> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: _isHovered ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(widget.width, widget.height),
            painter: CustomShapePainter(
              style: widget.style,
              isHovered: _isHovered,
            ),
          ),
          ClipPath(
            clipper: CustomShapeClipper(),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    _isHovered ? widget.secondImagePath : widget.firstImagePath,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomShapePainter extends CustomPainter {
  final ShapeStyle style;
  final bool isHovered;

  CustomShapePainter({required this.style, required this.isHovered});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width * 0.1, 0);
    path.quadraticBezierTo(
      size.width * 0.05,
      size.height * 0.2,
      size.width * 0.15,
      size.height * 0.3,
    );
    path.lineTo(size.width * 0.2, size.height * 0.5);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.65,
      size.width * 0.4,
      size.height * 0.7,
    );
    path.lineTo(size.width * 0.6, size.height * 0.7);
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.65,
      size.width * 0.85,
      size.height * 0.5,
    );
    path.lineTo(size.width * 0.9, size.height * 0.3);
    path.quadraticBezierTo(
      size.width * 0.95,
      size.height * 0.15,
      size.width * 0.85,
      0,
    );
    path.close();

    if (isHovered) {
      canvas.drawShadow(
        path,
        ColorPicker.cyberYellow.withOpacity(0.7),
        50.0,
        true,
      );
    }

    final paint =
        Paint()
          ..style =
              style == ShapeStyle.whiteBorder
                  ? PaintingStyle.stroke
                  : PaintingStyle.fill
          ..color =
              style == ShapeStyle.whiteBorder ? Colors.white : Colors.yellow
          ..strokeWidth = 4.0;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width * 0.1, 0);
    path.quadraticBezierTo(
      size.width * 0.05,
      size.height * 0.2,
      size.width * 0.15,
      size.height * 0.3,
    );
    path.lineTo(size.width * 0.2, size.height * 0.5);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.65,
      size.width * 0.4,
      size.height * 0.7,
    );
    path.lineTo(size.width * 0.6, size.height * 0.7);
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.65,
      size.width * 0.85,
      size.height * 0.5,
    );
    path.lineTo(size.width * 0.9, size.height * 0.3);
    path.quadraticBezierTo(
      size.width * 0.95,
      size.height * 0.15,
      size.width * 0.85,
      0,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
