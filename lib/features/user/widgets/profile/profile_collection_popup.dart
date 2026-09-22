import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/core/theme/app_colors.dart';
import 'package:internship_task/core/theme/app_spacing.dart';
import 'package:internship_task/core/theme/app_text_styles.dart';
import 'package:internship_task/features/user/widgets/profile/profile_form_popup.dart';

class ProfileCollectionPopup<T> extends StatelessWidget {
  final String title;
  final List<T> items;
  final String Function(T item) itemTitle;
  final String? Function(T item)? itemSubtitle;
  final List<ProfileFormField> Function(T? item)
  fieldsBuilder; // ← ProfileFormField
  final Future<void> Function(ProfileFormResult result, T? item) onSave;
  final Future<void> Function(T item)? onDelete;

  const ProfileCollectionPopup({
    super.key,
    required this.title,
    required this.items,
    required this.itemTitle,
    required this.fieldsBuilder,
    required this.onSave,
    this.itemSubtitle,
    this.onDelete,
  });

  // ============================================================
  // ADD
  // ============================================================

  Future<void> _addItem(BuildContext context) async {
    final result = await showDialog<ProfileFormResult>(
      context: context,
      builder: (_) => ProfileFormPopup(
        title: 'Add $title',
        action: ProfileFormAction.create,
        fields: fieldsBuilder(null),
      ),
    );
    if (result == null) return;

    await onSave(result, null);
    if (context.mounted) Navigator.of(context).pop();
  }

  // ============================================================
  // EDIT
  // ============================================================

  Future<void> _editItem(BuildContext context, T item) async {
    final result = await showDialog<ProfileFormResult>(
      context: context,
      builder: (_) => ProfileFormPopup(
        title: 'Edit $title',
        action: ProfileFormAction.update,
        fields: fieldsBuilder(item),
      ),
    );
    if (result == null) return;

    await onSave(result, item);
    if (context.mounted) Navigator.of(context).pop();
  }

  // ============================================================
  // DELETE
  // ============================================================

  Future<void> _deleteItem(BuildContext context, T item) async {
    if (onDelete == null) return;

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Delete $title?', style: AppTextStyles.titleLarge),
        content: Text(
          'Are you sure you want to delete "${itemTitle(item)}"? This action cannot be undone.',
          style: AppTextStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (shouldDelete != true) return;

    await onDelete!(item);
    if (context.mounted) Navigator.of(context).pop();
  }

  // ============================================================
  // ITEM ACTIONS
  // ============================================================

  Widget _buildItemActions(BuildContext context, T item) {
    if (onDelete == null) {
      return IconButton(
        onPressed: () => _editItem(context, item),
        icon: Icon(Icons.edit_outlined, size: 20.r, color: AppColors.inactive),
        tooltip: 'Edit',
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () => _editItem(context, item),
          icon: Icon(
            Icons.edit_outlined,
            size: 20.r,
            color: AppColors.inactive,
          ),
          tooltip: 'Edit',
        ),
        IconButton(
          onPressed: () => _deleteItem(context, item),
          icon: Icon(Icons.delete_outline, size: 20.r, color: AppColors.error),
          tooltip: 'Delete',
        ),
      ],
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.xxl.w,
          0,
          AppSpacing.xxl.w,
          AppSpacing.xxl.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(title, style: AppTextStyles.titleLarge)),
                IconButton(
                  onPressed: () => _addItem(context),
                  icon: Icon(Icons.add, size: 22.r, color: AppColors.primary),
                  tooltip: 'Add',
                ),
              ],
            ),
            AppSpacing.lg.h.verticalSpace,

            if (items.isEmpty)
              Padding(
                padding: EdgeInsets.only(bottom: AppSpacing.lg.h),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'No $title added yet.',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyMedium,
                      ),
                    ),
                    AppSpacing.lg.h.verticalSpace,
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () => _addItem(context),
                        icon: const Icon(Icons.add),
                        label: const Text('Add New'),
                      ),
                    ),
                  ],
                ),
              )
            else
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final subtitle = itemSubtitle?.call(item);
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        itemTitle(item),
                        style: AppTextStyles.bodyLarge,
                      ),
                      subtitle: subtitle != null && subtitle.trim().isNotEmpty
                          ? Padding(
                              padding: EdgeInsets.only(top: AppSpacing.xs.h),
                              child: Text(
                                subtitle,
                                style: AppTextStyles.bodyMedium,
                              ),
                            )
                          : null,
                      trailing: _buildItemActions(context, item),
                    );
                  },
                ),
              ),

            if (items.isNotEmpty) ...[
              AppSpacing.lg.h.verticalSpace,
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => _addItem(context),
                  icon: const Icon(Icons.add),
                  label: const Text('Add New'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
