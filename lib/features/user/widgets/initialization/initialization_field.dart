import 'package:flutter/material.dart';

class InitializationField extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController controller;
  final bool required;
  final TextInputType? keyboardType;
  final VoidCallback? onTap;
  final bool readOnly;

  const InitializationField({
    super.key,
    required this.label,
    required this.controller,
    this.hint,
    this.required = false,
    this.keyboardType,
    this.onTap,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          required ? '$label *' : label,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          onTap: onTap,
          readOnly: readOnly,
          decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
