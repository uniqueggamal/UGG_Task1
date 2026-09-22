import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/core/theme/app_colors.dart';
import 'package:internship_task/core/theme/app_spacing.dart';
import 'package:internship_task/features/user/models/user_profile_model.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key, this.profile, this.name, this.size});

  final UserProfileModel? profile;
  final String? name;
  final double? size;

  bool get _isNetwork {
    final url = profile?.profileImage?.trim() ?? '';
    return url.startsWith('http://') || url.startsWith('https://');
  }

  String get _initials {
    final value = (name ?? '').trim();
    if (value.isEmpty) return '?';
    final parts = value.split(RegExp(r'\s+'));
    if (parts.length == 1) {
      return parts.first.characters.first.toUpperCase();
    }
    return (parts[0].characters.first + parts[1].characters.first)
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final baseSize = size ?? 120.r;
    final width = baseSize;
    final height = baseSize * 1.25; // ← taller rectangle (not square)
    final imageUrl = profile?.profileImage?.trim();

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.15),
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: imageUrl != null && imageUrl.isNotEmpty
            ? (_isNetwork
                  ? Image.network(
                      imageUrl,
                      width: width,
                      height: height,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _fallback(width, height),
                    )
                  : Image.asset(
                      imageUrl,
                      width: width,
                      height: height,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _fallback(width, height),
                    ))
            : _fallback(width, height),
      ),
    );
  }

  Widget _fallback(double width, double height) {
    if ((name ?? '').trim().isNotEmpty) {
      return Container(
        width: width,
        height: height,
        color: AppColors.primary.withValues(alpha: 0.12),
        alignment: Alignment.center,
        child: Text(
          _initials,
          style: TextStyle(
            fontSize: width * 0.45,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
      );
    }
    return Container(
      width: width,
      height: height,
      color: AppColors.primary.withValues(alpha: 0.08),
      child: Icon(
        Icons.person_rounded,
        size: width * 0.8,
        color: AppColors.inactive,
      ),
    );
  }
}
