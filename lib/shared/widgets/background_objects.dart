import 'package:flutter/material.dart';
import 'package:internship_task/shared/utils/app_styles.dart';

/// A decorative circle used in the login background
class BackgroundCircle extends StatelessWidget {
  final double size;
  final double opacity;

  const BackgroundCircle({
    super.key,
    required this.size,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary.withValues(alpha: opacity),
      ),
    );
  }
}

/// A decorative ring (circular border) used in the login background
class BackgroundRing extends StatelessWidget {
  final double size;

  const BackgroundRing({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.15),
          width: 2,
        ),
      ),
    );
  }
}

/// A grid of decorative dots used in the login background
class DotGrid extends StatelessWidget {
  const DotGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        4,
        (_) => Row(
          children: List.generate(
            4,
            (_) => Container(
              margin: const EdgeInsets.all(4),
              width: 5,
              height: 5,
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
