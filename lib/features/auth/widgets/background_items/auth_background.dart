import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'background_objects.dart';

/// The decorative background for the login screen
/// Contains gradient background and positioned decorative elements
class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        // Calculate circle sizes relative to screen dimensions
        final largeCircleSize = width * 0.65.r;
        final mediumCircleSize = width * 0.55.r;
        final smallCircleSize = width * 0.5.r;

        // Calculate ring sizes
        final largeRingSize = width * 0.32.r;
        final mediumRingSize = width * 0.35.r;

        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFF5F1FF), Color(0xFFFFFFFF), Color(0xFFECE5FF)],
            ),
          ),
          child: Stack(
            children: [
              /// Top-left large circle
              Positioned(
                top: -largeCircleSize * 0.38,
                left: -largeCircleSize * 0.35,
                child: BackgroundCircle(size: largeCircleSize, opacity: 0.12),
              ),

              /// Top-right purple circle
              Positioned(
                top: -mediumCircleSize * 0.35,
                right: -mediumCircleSize * 0.3,
                child: BackgroundCircle(size: mediumCircleSize, opacity: 0.18),
              ),

              /// Bottom-left circle
              Positioned(
                bottom: -mediumCircleSize * 0.39,
                left: -mediumCircleSize * 0.35,
                child: BackgroundCircle(size: mediumCircleSize, opacity: 0.14),
              ),

              /// Bottom-right circle
              Positioned(
                bottom: -smallCircleSize * 0.32,
                right: -smallCircleSize * 0.36,
                child: BackgroundCircle(size: smallCircleSize, opacity: 0.12),
              ),

              /// Top-right ring
              Positioned(
                top: height * 0.15,
                right: -largeRingSize * 0.25,
                child: BackgroundRing(size: largeRingSize),
              ),

              /// Bottom-left ring
              Positioned(
                bottom: height * 0.14,
                left: -mediumRingSize * 0.32,
                child: BackgroundRing(size: mediumRingSize),
              ),

              /// Decorative dots - positioned more responsively
              Positioned(
                top: height * 0.15,
                left: width * 0.1,
                child: const DotGrid(),
              ),

              Positioned(
                bottom: height * 0.15,
                right: width * 0.1,
                child: const DotGrid(),
              ),
            ],
          ),
        );
      },
    );
  }
}
