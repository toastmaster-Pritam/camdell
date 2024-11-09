// import 'package:flutter/material.dart';
// import 'dart:math' as math;

// class CustomDoubleCircleProgress extends StatefulWidget {
//   final double size;
//   final Color outerColor;
//   final Color innerColor;
//   final String text;

//   const CustomDoubleCircleProgress({
//     super.key,
//     this.size = 100.0,
//     this.outerColor = Colors.blue,
//     this.innerColor = Colors.white,
//     this.text = 'Placing your order',
//   });

//   @override
//   _CustomDoubleCircleProgressState createState() => _CustomDoubleCircleProgressState();
// }

// class _CustomDoubleCircleProgressState extends State<CustomDoubleCircleProgress>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     )..repeat();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         SizedBox(
//           width: widget.size,
//           height: widget.size,
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               AnimatedBuilder(
//                 animation: _controller,
//                 builder: (_, child) {
//                   return CustomPaint(
//                     size: Size(widget.size, widget.size),
//                     painter: _CirclePainter(
//                       progress: _controller.value,
//                       color: widget.outerColor,
//                       strokeWidth: 3,
//                     ),
//                   );
//                 },
//               ),
//               Container(
//                 width: widget.size * 0.85,
//                 height: widget.size * 0.85,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: widget.innerColor,
//                 ),
//                 child: Center(
//                   child: AnimatedBuilder(
//                     animation: _controller,
//                     builder: (_, child) {
//                       return CustomPaint(
//                         size: Size(widget.size * 0.85, widget.size * 0.85),
//                         painter: _CirclePainter(
//                           progress: _controller.value,
//                           color: widget.outerColor,
//                           strokeWidth: 3,
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 10),
//         Text(
//           widget.text,
//           style: const TextStyle(
//             color: Colors.black54,
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _CirclePainter extends CustomPainter {
//   final double progress;
//   final Color color;
//   final double strokeWidth;

//   _CirclePainter({
//     required this.progress,
//     required this.color,
//     this.strokeWidth = 3,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = (size.width - strokeWidth) / 2;
//     final paint = Paint()
//       ..color = color
//       ..strokeWidth = strokeWidth
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round;

//     canvas.drawArc(
//       Rect.fromCircle(center: center, radius: radius),
//       -math.pi / 2,
//       2 * math.pi * progress,
//       false,
//       paint,
//     );
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => true;
// }
