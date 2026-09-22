import 'package:flutter/material.dart';

class ProfileFormDialog extends StatefulWidget {

  final String title;
  final String label;
  final String? initialValue;
  final int maxLines;
  final Future<void> Function(String value) onSave;

  const ProfileFormDialog({
    super.key,
    required this.title,
    required this.label,
    required this.onSave,
    this.initialValue,
    this.maxLines = 1,
  });

  @override
  State<ProfileFormDialog> createState() => _ProfilFormeDialogState();
}

class _ProfilFormeDialogState extends State<ProfileFormDialog> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}