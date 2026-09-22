import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/core/theme/app_spacing.dart';
import 'package:internship_task/core/theme/app_text_styles.dart';
import 'package:internship_task/core/utils/date_utils.dart';
import 'package:internship_task/core/widgets/app_message.dart';

// ============================================================
// ENUMS & MODELS
// ============================================================

enum ProfileFormAction { create, update }

enum ProfileFormFieldType { text, multiline, date, url, switchField }

class ProfileFormResult {
  final ProfileFormAction action;
  final Map<String, String> values;

  const ProfileFormResult({required this.action, required this.values});
}

class ProfileFormField {
  final String name;
  final String label;
  final String initialValue;
  final ProfileFormFieldType type;
  final TextInputType keyboardType;
  final int maxLines;
  final bool obscureText;
  final bool required;

  const ProfileFormField({
    required this.name,
    required this.label,
    this.initialValue = '',
    this.type = ProfileFormFieldType.text,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.obscureText = false,
    this.required = false,
  });
}

// ============================================================
// POPUP
// ============================================================

class ProfileFormPopup extends StatefulWidget {
  final String title;
  final List<ProfileFormField> fields;
  final ProfileFormAction action;

  const ProfileFormPopup({
    super.key,
    required this.title,
    required this.fields,
    this.action = ProfileFormAction.create,
  });

  @override
  State<ProfileFormPopup> createState() => _ProfileFormPopupState();
}

class _ProfileFormPopupState extends State<ProfileFormPopup> {
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, bool> _switchValues = {};

  @override
  void initState() {
    super.initState();

    for (final field in widget.fields) {
      if (field.type == ProfileFormFieldType.switchField) {
        _switchValues[field.name] = field.initialValue.toLowerCase() == 'true';
      } else {
        _controllers[field.name] = TextEditingController(
          text: field.initialValue,
        );
      }
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  // ============================================================
  // HELPERS
  // ============================================================

  bool _isCurrent() => _switchValues['is_current'] ?? false;

  // ============================================================
  // VALIDATION
  // ============================================================

  bool _validate() {
    for (final field in widget.fields) {
      if (!field.required) continue;
      if (field.type == ProfileFormFieldType.switchField) continue;
      if (field.name == 'end_date' && _isCurrent()) continue;

      final value = _controllers[field.name]?.text.trim() ?? '';
      if (value.isEmpty) {
        AppMessage.show(
          context,
          message: '${field.label} is required.',
          type: MessageType.error,
        );
        return false;
      }
    }

    final start = AppDateUtils.parse(_controllers['start_date']?.text);
    final end = AppDateUtils.parse(_controllers['end_date']?.text);

    if (start != null && end != null && end.isBefore(start)) {
      AppMessage.show(
        context,
        message: 'End date cannot be before start date.',
        type: MessageType.error,
      );
      return false;
    }

    return true;
  }

  // ============================================================
  // DATE PICKER
  // ============================================================

  Future<void> _selectDate(ProfileFormField field) async {
    final controller = _controllers[field.name];
    if (controller == null) return;

    final now = DateTime.now();
    DateTime initialDate = AppDateUtils.parse(controller.text) ?? now;
    DateTime firstDate = DateTime(1900);
    DateTime lastDate = DateTime(now.year + 20);

    if (field.name == 'end_date') {
      final start = AppDateUtils.parse(_controllers['start_date']?.text);
      if (start != null) {
        firstDate = start;
        if (initialDate.isBefore(start)) initialDate = start;
      }
    } else if (field.name == 'start_date') {
      final end = AppDateUtils.parse(_controllers['end_date']?.text);
      if (end != null) {
        lastDate = end;
        if (initialDate.isAfter(end)) initialDate = end;
      }
    }

    final selected = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (selected == null) return;

    controller.text = AppDateUtils.toApi(selected);

    // If start date moved after end date → clear end
    if (field.name == 'start_date') {
      final end = AppDateUtils.parse(_controllers['end_date']?.text);
      if (end != null && end.isBefore(selected)) {
        _controllers['end_date']?.clear();
      }
    }

    if (mounted) setState(() {});
  }

  // ============================================================
  // SWITCH
  // ============================================================

  void _onSwitchChanged(ProfileFormField field, bool value) {
    setState(() {
      _switchValues[field.name] = value;
      if (field.name == 'is_current' && value) {
        _controllers['end_date']?.clear();
      }
    });
  }

  // ============================================================
  // SAVE
  // ============================================================

  void _save() {
    if (!_validate()) return;

    final values = <String, String>{};

    for (final field in widget.fields) {
      if (field.type == ProfileFormFieldType.switchField) {
        values[field.name] = (_switchValues[field.name] ?? false).toString();
      } else {
        values[field.name] = _controllers[field.name]?.text.trim() ?? '';
      }
    }

    if (_isCurrent() && values.containsKey('end_date')) {
      values['end_date'] = '';
    }

    Navigator.pop(
      context,
      ProfileFormResult(action: widget.action, values: values),
    );
  }

  // ============================================================
  // FIELD BUILDERS
  // ============================================================

  Widget _buildField(ProfileFormField field) {
    switch (field.type) {
      case ProfileFormFieldType.switchField:
        return _buildSwitchField(field);
      case ProfileFormFieldType.date:
        return _buildDateField(field);
      case ProfileFormFieldType.multiline:
      case ProfileFormFieldType.text:
      case ProfileFormFieldType.url:
        return _buildTextField(field);
    }
  }

  Widget _buildTextField(ProfileFormField field) {
    final isUrl = field.type == ProfileFormFieldType.url;

    return TextField(
      controller: _controllers[field.name],
      keyboardType: isUrl ? TextInputType.url : field.keyboardType,
      maxLines: field.maxLines,
      obscureText: field.obscureText,
      decoration: InputDecoration(
        labelText: field.label,
        border: const OutlineInputBorder(),
        hintText: isUrl ? 'https://...' : null,
      ),
    );
  }

  Widget _buildDateField(ProfileFormField field) {
    return TextField(
      controller: _controllers[field.name],
      readOnly: true,
      onTap: () => _selectDate(field),
      decoration: InputDecoration(
        labelText: field.label,
        border: const OutlineInputBorder(),
        suffixIcon: const Icon(Icons.calendar_today_outlined),
      ),
    );
  }

  Widget _buildSwitchField(ProfileFormField field) {
    final value = _switchValues[field.name] ?? false;

    return InputDecorator(
      decoration: const InputDecoration(border: OutlineInputBorder()),
      child: Row(
        children: [
          Expanded(child: Text(field.label, style: AppTextStyles.bodyMedium)),
          Switch(
            value: value,
            onChanged: (newValue) => _onSwitchChanged(field, newValue),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.action == ProfileFormAction.update;

    return AlertDialog(
      title: Text(widget.title, style: AppTextStyles.titleLarge),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final field in widget.fields) ...[
              // Hide End Date when "Currently working here" is ON
              if (field.name == 'end_date' && _isCurrent())
                const SizedBox.shrink()
              else ...[
                _buildField(field),
                AppSpacing.md.h.verticalSpace,
              ],
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _save,
          child: Text(isEditing ? 'Update' : 'Add'),
        ),
      ],
    );
  }
}
