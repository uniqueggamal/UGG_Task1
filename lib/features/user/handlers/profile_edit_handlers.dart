import 'package:flutter/material.dart';
import 'package:internship_task/core/utils/date_utils.dart';
import 'package:provider/provider.dart';
import 'package:internship_task/core/widgets/app_message.dart';
import 'package:internship_task/features/auth/providers/auth_provider.dart';
import 'package:internship_task/features/user/models/full_profile_model.dart';
import 'package:internship_task/features/user/models/user_profile_model.dart';
import 'package:internship_task/features/user/providers/user_provider.dart';
import 'package:internship_task/features/user/widgets/profile/profile_collection_popup.dart';
import 'package:internship_task/features/user/widgets/profile/profile_form_popup.dart';

class ProfileEditHandlers {
  ProfileEditHandlers._();

  static String? _token(BuildContext context) =>
      context.read<AuthProvider>().token;

  static void _showError(BuildContext context, Object error) {
    if (!context.mounted) return;
    AppMessage.show(
      context,
      message: error.toString(),
      type: MessageType.error,
    );
  }

  static String? _nullable(String? value) {
    final t = value?.trim() ?? '';
    return t.isEmpty ? null : t;
  }

  // ────────────────────────────────────────────────────────────
  // Description
  // ────────────────────────────────────────────────────────────

  static Future<void> editDescription(
    BuildContext context,
    FullProfileModel profile,
    VoidCallback onSuccess,
  ) async {
    final result = await showDialog<ProfileFormResult>(
      context: context,
      builder: (_) => ProfileFormPopup(
        title: 'Description',
        action: ProfileFormAction.update,
        fields: [
          ProfileFormField(
            name: 'description',
            label: 'Description',
            initialValue: profile.profile?.description ?? '',
            type: ProfileFormFieldType.multiline,
            maxLines: 5,
          ),
        ],
      ),
    );
    if (result == null) return;

    final token = _token(context);
    if (token == null || token.isEmpty) {
      if (context.mounted) {
        AppMessage.show(
          context,
          message: 'You are not authenticated.',
          type: MessageType.error,
        );
      }
      return;
    }

    try {
      final old = profile.profile;
      if (old == null) {
        if (context.mounted) {
          AppMessage.show(
            context,
            message: 'Profile information is not available.',
            type: MessageType.error,
          );
        }
        return;
      }

      final updated = UserProfileModel(
        id: old.id,
        userId: old.userId,
        role: old.role,
        currentStatus: old.currentStatus,
        affiliatedOrganization: old.affiliatedOrganization,
        dateOfBirth: old.dateOfBirth,
        phone: old.phone,
        description: result.values['description'],
        location: old.location,
        profileImage: old.profileImage,
      );

      await context.read<UserProvider>().updateProfile(
        token: token,
        profile: updated,
      );

      if (context.mounted) {
        AppMessage.show(
          context,
          message: 'Description updated successfully.',
          type: MessageType.success,
        );
      }
      onSuccess();
    } catch (e) {
      _showError(context, e);
    }
  }

  // ────────────────────────────────────────────────────────────
  // Location
  // ────────────────────────────────────────────────────────────

  static Future<void> editLocation(
    BuildContext context,
    FullProfileModel profile,
    VoidCallback onSuccess,
  ) async {
    final result = await showDialog<ProfileFormResult>(
      context: context,
      builder: (_) => ProfileFormPopup(
        title: 'Location',
        action: ProfileFormAction.update,
        fields: [
          ProfileFormField(
            name: 'location',
            label: 'Location',
            initialValue: profile.profile?.location ?? '',
            maxLines: 2,
          ),
        ],
      ),
    );
    if (result == null) return;

    final token = _token(context);
    if (token == null || token.isEmpty) {
      if (context.mounted) {
        AppMessage.show(
          context,
          message: 'You are not authenticated.',
          type: MessageType.error,
        );
      }
      return;
    }

    try {
      final old = profile.profile;
      if (old == null) {
        if (context.mounted) {
          AppMessage.show(
            context,
            message: 'Profile information is not available.',
            type: MessageType.error,
          );
        }
        return;
      }

      final updated = UserProfileModel(
        id: old.id,
        userId: old.userId,
        role: old.role,
        currentStatus: old.currentStatus,
        affiliatedOrganization: old.affiliatedOrganization,
        dateOfBirth: old.dateOfBirth,
        phone: old.phone,
        description: old.description,
        location: result.values['location'],
        profileImage: old.profileImage,
      );

      await context.read<UserProvider>().updateProfile(
        token: token,
        profile: updated,
      );

      if (context.mounted) {
        AppMessage.show(
          context,
          message: 'Location updated successfully.',
          type: MessageType.success,
        );
      }
      onSuccess();
    } catch (e) {
      _showError(context, e);
    }
  }

  // ────────────────────────────────────────────────────────────
  // Academic Qualifications
  // ────────────────────────────────────────────────────────────

  static Future<void> editAcademicQualifications(
    BuildContext context,
    FullProfileModel profile,
    VoidCallback onSuccess,
  ) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => ProfileCollectionPopup(
        title: 'Academic Qualification',
        items: profile.academicQualifications,
        itemTitle: (item) => item.degree,
        itemSubtitle: (item) => [
          item.institution,
          if (item.field != null && item.field!.isNotEmpty) item.field!,
          AppDateUtils.formatRange(item.startDate, item.endDate),
        ].where((v) => v.isNotEmpty).join(' • '),
        fieldsBuilder: (item) => [
          ProfileFormField(
            name: 'degree',
            label: 'Degree',
            initialValue: item?.degree ?? '',
            required: true,
          ),
          ProfileFormField(
            name: 'institution',
            label: 'Institution',
            initialValue: item?.institution ?? '',
            required: true,
          ),
          ProfileFormField(
            name: 'field',
            label: 'Field',
            initialValue: item?.field ?? '',
          ),
          ProfileFormField(
            name: 'start_date',
            label: 'Start Date',
            initialValue: item?.startDate ?? '',
            type: ProfileFormFieldType.date,
          ),
          ProfileFormField(
            name: 'end_date',
            label: 'End Date',
            initialValue: item?.endDate ?? '',
            type: ProfileFormFieldType.date,
          ),
        ],
        onSave: (result, item) async {
          final token = _token(context);
          if (token == null || token.isEmpty) {
            if (context.mounted) {
              AppMessage.show(
                context,
                message: 'You are not authenticated.',
                type: MessageType.error,
              );
            }
            return;
          }
          try {
            final data = {
              'degree': result.values['degree'],
              'institution': result.values['institution'],
              'field': _nullable(result.values['field']),
              'start_date': _nullable(result.values['start_date']),
              'end_date': _nullable(result.values['end_date']),
            };
            if (result.action == ProfileFormAction.create) {
              await context.read<UserProvider>().createAcademicQualification(
                token: token,
                data: data,
              );
              if (context.mounted) {
                AppMessage.show(
                  context,
                  message: 'Academic qualification added successfully.',
                  type: MessageType.success,
                );
              }
            } else {
              await context.read<UserProvider>().updateAcademicQualification(
                token: token,
                id: item!.id!,
                data: data,
              );
              if (context.mounted) {
                AppMessage.show(
                  context,
                  message: 'Academic qualification updated successfully.',
                  type: MessageType.success,
                );
              }
            }
            onSuccess();
          } catch (e) {
            _showError(context, e);
          }
        },
        onDelete: (item) async {
          final token = _token(context);
          if (token == null || token.isEmpty) {
            if (context.mounted) {
              AppMessage.show(
                context,
                message: 'You are not authenticated.',
                type: MessageType.error,
              );
            }
            return;
          }
          try {
            await context.read<UserProvider>().deleteAcademicQualification(
              token: token,
              id: item.id!,
            );
            if (context.mounted) {
              AppMessage.show(
                context,
                message: 'Academic qualification deleted successfully.',
                type: MessageType.success,
              );
            }
            onSuccess();
          } catch (e) {
            _showError(context, e);
          }
        },
      ),
    );
  }

  // ────────────────────────────────────────────────────────────
  // Experiences
  // ────────────────────────────────────────────────────────────

  static Future<void> editExperiences(
    BuildContext context,
    FullProfileModel profile,
    VoidCallback onSuccess,
  ) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => ProfileCollectionPopup(
        title: 'Experience',
        items: profile.experiences,
        itemTitle: (item) => item.position,
        itemSubtitle: (item) {
          final parts = <String>[item.organization];
          if (item.isCurrent) {
            parts.add('Current');
          } else {
            final range = AppDateUtils.formatRange(
              item.startDate,
              item.endDate,
            );
            if (range.isNotEmpty) parts.add(range);
          }
          return parts.join(' • ');
        },
        fieldsBuilder: (item) => [
          ProfileFormField(
            name: 'organization',
            label: 'Organization',
            initialValue: item?.organization ?? '',
            required: true,
          ),
          ProfileFormField(
            name: 'position',
            label: 'Position',
            initialValue: item?.position ?? '',
            required: true,
          ),
          ProfileFormField(
            name: 'description',
            label: 'Description',
            initialValue: item?.description ?? '',
            type: ProfileFormFieldType.multiline,
            maxLines: 5,
          ),
          ProfileFormField(
            name: 'start_date',
            label: 'Start Date',
            initialValue: item?.startDate ?? '',
            type: ProfileFormFieldType.date,
          ),
          ProfileFormField(
            name: 'is_current',
            label: 'Currently working here?',
            initialValue: item?.isCurrent == true ? 'true' : 'false',
            type: ProfileFormFieldType.switchField,
          ),
          ProfileFormField(
            name: 'end_date',
            label: 'End Date',
            initialValue: item?.endDate ?? '',
            type: ProfileFormFieldType.date,
          ),
        ],
        onSave: (result, item) async {
          final token = _token(context);
          if (token == null || token.isEmpty) {
            if (context.mounted) {
              AppMessage.show(
                context,
                message: 'You are not authenticated.',
                type: MessageType.error,
              );
            }
            return;
          }
          try {
            final isCurrent = result.values['is_current'] == 'true';
            final data = {
              'organization': result.values['organization'],
              'position': result.values['position'],
              'description': _nullable(result.values['description']),
              'start_date': _nullable(result.values['start_date']),
              'end_date': isCurrent
                  ? null
                  : _nullable(result.values['end_date']),
              'is_current': isCurrent,
            };
            if (result.action == ProfileFormAction.create) {
              await context.read<UserProvider>().createExperience(
                token: token,
                data: data,
              );
              if (context.mounted) {
                AppMessage.show(
                  context,
                  message: 'Experience added successfully.',
                  type: MessageType.success,
                );
              }
            } else {
              await context.read<UserProvider>().updateExperience(
                token: token,
                id: item!.id!,
                data: data,
              );
              if (context.mounted) {
                AppMessage.show(
                  context,
                  message: 'Experience updated successfully.',
                  type: MessageType.success,
                );
              }
            }
            onSuccess();
          } catch (e) {
            _showError(context, e);
          }
        },
        onDelete: (item) async {
          final token = _token(context);
          if (token == null || token.isEmpty) {
            if (context.mounted) {
              AppMessage.show(
                context,
                message: 'You are not authenticated.',
                type: MessageType.error,
              );
            }
            return;
          }
          try {
            await context.read<UserProvider>().deleteExperience(
              token: token,
              id: item.id!,
            );
            if (context.mounted) {
              AppMessage.show(
                context,
                message: 'Experience deleted successfully.',
                type: MessageType.success,
              );
            }
            onSuccess();
          } catch (e) {
            _showError(context, e);
          }
        },
      ),
    );
  }

  // ────────────────────────────────────────────────────────────
  // Technical Skills
  // ────────────────────────────────────────────────────────────

  static Future<void> editTechnicalSkills(
    BuildContext context,
    FullProfileModel profile,
    VoidCallback onSuccess,
  ) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => ProfileCollectionPopup(
        title: 'Technical Skills',
        items: profile.skills,
        itemTitle: (item) => item.name,
        fieldsBuilder: (item) => [
          ProfileFormField(
            name: 'name',
            label: 'Skill',
            initialValue: item?.name ?? '',
            required: true,
          ),
        ],
        onSave: (result, item) async {
          final token = _token(context);
          if (token == null || token.isEmpty) {
            if (context.mounted) {
              AppMessage.show(
                context,
                message: 'You are not authenticated.',
                type: MessageType.error,
              );
            }
            return;
          }
          try {
            final data = {'name': result.values['name']};
            if (result.action == ProfileFormAction.create) {
              await context.read<UserProvider>().createSkill(
                token: token,
                data: data,
              );
              if (context.mounted) {
                AppMessage.show(
                  context,
                  message: 'Skill added successfully.',
                  type: MessageType.success,
                );
              }
            } else {
              await context.read<UserProvider>().updateSkill(
                token: token,
                id: item!.id,
                data: data,
              );
              if (context.mounted) {
                AppMessage.show(
                  context,
                  message: 'Skill updated successfully.',
                  type: MessageType.success,
                );
              }
            }
            onSuccess();
          } catch (e) {
            _showError(context, e);
          }
        },
        onDelete: (item) async {
          final token = _token(context);
          if (token == null || token.isEmpty) {
            if (context.mounted) {
              AppMessage.show(
                context,
                message: 'You are not authenticated.',
                type: MessageType.error,
              );
            }
            return;
          }
          try {
            await context.read<UserProvider>().deleteSkill(
              token: token,
              id: item.id,
            );
            if (context.mounted) {
              AppMessage.show(
                context,
                message: 'Skill deleted successfully.',
                type: MessageType.success,
              );
            }
            onSuccess();
          } catch (e) {
            _showError(context, e);
          }
        },
      ),
    );
  }

  // ────────────────────────────────────────────────────────────
  // Projects
  // ────────────────────────────────────────────────────────────

  static Future<void> editProjects(
    BuildContext context,
    FullProfileModel profile,
    VoidCallback onSuccess,
  ) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => ProfileCollectionPopup(
        title: 'Projects',
        items: profile.projects,
        itemTitle: (item) => item.title,
        itemSubtitle: (item) => [
          if (item.description != null && item.description!.isNotEmpty)
            item.description!,
          if (item.link != null && item.link!.isNotEmpty) item.link!,
        ].join('\n'),
        fieldsBuilder: (item) => [
          ProfileFormField(
            name: 'title',
            label: 'Project Title',
            initialValue: item?.title ?? '',
            required: true,
          ),
          ProfileFormField(
            name: 'description',
            label: 'Description',
            initialValue: item?.description ?? '',
            type: ProfileFormFieldType.multiline,
            maxLines: 5,
          ),
          ProfileFormField(
            name: 'link',
            label: 'Project Link',
            initialValue: item?.link ?? '',
            type: ProfileFormFieldType.url,
          ),
        ],
        onSave: (result, item) async {
          final token = _token(context);
          if (token == null || token.isEmpty) {
            if (context.mounted) {
              AppMessage.show(
                context,
                message: 'You are not authenticated.',
                type: MessageType.error,
              );
            }
            return;
          }
          try {
            final data = {
              'title': result.values['title'],
              'description': _nullable(result.values['description']),
              'link': _nullable(result.values['link']),
            };
            if (result.action == ProfileFormAction.create) {
              await context.read<UserProvider>().createProject(
                token: token,
                data: data,
              );
              if (context.mounted) {
                AppMessage.show(
                  context,
                  message: 'Project added successfully.',
                  type: MessageType.success,
                );
              }
            } else {
              await context.read<UserProvider>().updateProject(
                token: token,
                id: item!.id,
                data: data,
              );
              if (context.mounted) {
                AppMessage.show(
                  context,
                  message: 'Project updated successfully.',
                  type: MessageType.success,
                );
              }
            }
            onSuccess();
          } catch (e) {
            _showError(context, e);
          }
        },
        onDelete: (item) async {
          final token = _token(context);
          if (token == null || token.isEmpty) {
            if (context.mounted) {
              AppMessage.show(
                context,
                message: 'You are not authenticated.',
                type: MessageType.error,
              );
            }
            return;
          }
          try {
            await context.read<UserProvider>().deleteProject(
              token: token,
              id: item.id,
            );
            if (context.mounted) {
              AppMessage.show(
                context,
                message: 'Project deleted successfully.',
                type: MessageType.success,
              );
            }
            onSuccess();
          } catch (e) {
            _showError(context, e);
          }
        },
      ),
    );
  }

  // ────────────────────────────────────────────────────────────
  // Achievements
  // ────────────────────────────────────────────────────────────

  static Future<void> editAchievements(
    BuildContext context,
    FullProfileModel profile,
    VoidCallback onSuccess,
  ) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => ProfileCollectionPopup(
        title: 'Achievements & Certifications',
        items: profile.achievements,
        itemTitle: (item) => item.title,
        itemSubtitle: (item) => [
          if (item.description != null && item.description!.isNotEmpty)
            item.description!,
          if (item.date != null && item.date!.isNotEmpty)
            AppDateUtils.toDisplay(item.date, includeDay: true),
        ].join('\n'),
        fieldsBuilder: (item) => [
          ProfileFormField(
            name: 'title',
            label: 'Title',
            initialValue: item?.title ?? '',
            required: true,
          ),
          ProfileFormField(
            name: 'description',
            label: 'Description',
            initialValue: item?.description ?? '',
            type: ProfileFormFieldType.multiline,
            maxLines: 4,
          ),
          ProfileFormField(
            name: 'date',
            label: 'Date',
            initialValue: item?.date ?? '',
            type: ProfileFormFieldType.date,
          ),
        ],
        onSave: (result, item) async {
          final token = _token(context);
          if (token == null || token.isEmpty) {
            if (context.mounted) {
              AppMessage.show(
                context,
                message: 'You are not authenticated.',
                type: MessageType.error,
              );
            }
            return;
          }
          try {
            final data = {
              'title': result.values['title'],
              'description': _nullable(result.values['description']),
              'date': _nullable(result.values['date']),
            };
            if (result.action == ProfileFormAction.create) {
              await context.read<UserProvider>().createAchievement(
                token: token,
                data: data,
              );
              if (context.mounted) {
                AppMessage.show(
                  context,
                  message: 'Achievement added successfully.',
                  type: MessageType.success,
                );
              }
            } else {
              await context.read<UserProvider>().updateAchievement(
                token: token,
                id: item!.id,
                data: data,
              );
              if (context.mounted) {
                AppMessage.show(
                  context,
                  message: 'Achievement updated successfully.',
                  type: MessageType.success,
                );
              }
            }
            onSuccess();
          } catch (e) {
            _showError(context, e);
          }
        },
        onDelete: (item) async {
          final token = _token(context);
          if (token == null || token.isEmpty) {
            if (context.mounted) {
              AppMessage.show(
                context,
                message: 'You are not authenticated.',
                type: MessageType.error,
              );
            }
            return;
          }
          try {
            await context.read<UserProvider>().deleteAchievement(
              token: token,
              id: item.id,
            );
            if (context.mounted) {
              AppMessage.show(
                context,
                message: 'Achievement deleted successfully.',
                type: MessageType.success,
              );
            }
            onSuccess();
          } catch (e) {
            _showError(context, e);
          }
        },
      ),
    );
  }

  // ────────────────────────────────────────────────────────────
  // Coursework
  // ────────────────────────────────────────────────────────────

  static Future<void> editCoursework(
    BuildContext context,
    FullProfileModel profile,
    VoidCallback onSuccess,
  ) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => ProfileCollectionPopup(
        title: 'Relevant Coursework',
        items: profile.courseworks,
        itemTitle: (item) => item.name,
        itemSubtitle: (item) => item.description,
        fieldsBuilder: (item) => [
          ProfileFormField(
            name: 'name',
            label: 'Coursework',
            initialValue: item?.name ?? '',
            required: true,
          ),
          ProfileFormField(
            name: 'description',
            label: 'Description',
            initialValue: item?.description ?? '',
            type: ProfileFormFieldType.multiline,
            maxLines: 4,
          ),
        ],
        onSave: (result, item) async {
          final token = _token(context);
          if (token == null || token.isEmpty) {
            if (context.mounted) {
              AppMessage.show(
                context,
                message: 'You are not authenticated.',
                type: MessageType.error,
              );
            }
            return;
          }
          try {
            final data = {
              'name': result.values['name'],
              'description': _nullable(result.values['description']),
            };
            if (result.action == ProfileFormAction.create) {
              await context.read<UserProvider>().createCoursework(
                token: token,
                data: data,
              );
              if (context.mounted) {
                AppMessage.show(
                  context,
                  message: 'Coursework added successfully.',
                  type: MessageType.success,
                );
              }
            } else {
              await context.read<UserProvider>().updateCoursework(
                token: token,
                id: item!.id,
                data: data,
              );
              if (context.mounted) {
                AppMessage.show(
                  context,
                  message: 'Coursework updated successfully.',
                  type: MessageType.success,
                );
              }
            }
            onSuccess();
          } catch (e) {
            _showError(context, e);
          }
        },
        onDelete: (item) async {
          final token = _token(context);
          if (token == null || token.isEmpty) {
            if (context.mounted) {
              AppMessage.show(
                context,
                message: 'You are not authenticated.',
                type: MessageType.error,
              );
            }
            return;
          }
          try {
            await context.read<UserProvider>().deleteCoursework(
              token: token,
              id: item.id,
            );
            if (context.mounted) {
              AppMessage.show(
                context,
                message: 'Coursework deleted successfully.',
                type: MessageType.success,
              );
            }
            onSuccess();
          } catch (e) {
            _showError(context, e);
          }
        },
      ),
    );
  }

  // ────────────────────────────────────────────────────────────
  // Interests
  // ────────────────────────────────────────────────────────────

  static Future<void> editInterests(
    BuildContext context,
    FullProfileModel profile,
    VoidCallback onSuccess,
  ) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => ProfileCollectionPopup(
        title: 'Interests',
        items: profile.interests,
        itemTitle: (item) => item.name,
        fieldsBuilder: (item) => [
          ProfileFormField(
            name: 'name',
            label: 'Interest',
            initialValue: item?.name ?? '',
            required: true,
          ),
        ],
        onSave: (result, item) async {
          final token = _token(context);
          if (token == null || token.isEmpty) {
            if (context.mounted) {
              AppMessage.show(
                context,
                message: 'You are not authenticated.',
                type: MessageType.error,
              );
            }
            return;
          }
          try {
            final data = {'name': result.values['name']};
            if (result.action == ProfileFormAction.create) {
              await context.read<UserProvider>().createInterest(
                token: token,
                data: data,
              );
              if (context.mounted) {
                AppMessage.show(
                  context,
                  message: 'Interest added successfully.',
                  type: MessageType.success,
                );
              }
            } else {
              await context.read<UserProvider>().updateInterest(
                token: token,
                id: item!.id,
                data: data,
              );
              if (context.mounted) {
                AppMessage.show(
                  context,
                  message: 'Interest updated successfully.',
                  type: MessageType.success,
                );
              }
            }
            onSuccess();
          } catch (e) {
            _showError(context, e);
          }
        },
        onDelete: (item) async {
          final token = _token(context);
          if (token == null || token.isEmpty) {
            if (context.mounted) {
              AppMessage.show(
                context,
                message: 'You are not authenticated.',
                type: MessageType.error,
              );
            }
            return;
          }
          try {
            await context.read<UserProvider>().deleteInterest(
              token: token,
              id: item.id,
            );
            if (context.mounted) {
              AppMessage.show(
                context,
                message: 'Interest deleted successfully.',
                type: MessageType.success,
              );
            }
            onSuccess();
          } catch (e) {
            _showError(context, e);
          }
        },
      ),
    );
  }
}
