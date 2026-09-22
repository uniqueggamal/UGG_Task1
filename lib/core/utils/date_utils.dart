// lib/core/utils/date_utils.dart  (or similar)
class AppDateUtils {
  /// Parse API / form value (yyyy-MM-dd or ISO)
  static DateTime? parse(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return null;
    return DateTime.tryParse(text);
  }

  /// Format for API / form storage
  static String toApi(DateTime date) {
    return '${date.year.toString().padLeft(4, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
  }

  /// Nice display (e.g. "Jan 2024")
  static String toDisplay(String? value, {bool includeDay = false}) {
    final date = parse(value);
    if (date == null) return '';

    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    if (includeDay) {
      return ' ${months[date.month - 1]} ${date.day}, ${date.year}';
    }
    return '${months[date.month - 1]} ${date.year}';
  }

  /// Range for cards / subtitles
  static String formatRange(
    String? start,
    String? end, {
    bool presentIfEmpty = true,
  }) {
    final s = toDisplay(start);
    final e = toDisplay(end);

    if (s.isEmpty && e.isEmpty) return '';
    if (s.isEmpty) return e;
    if (e.isEmpty) return presentIfEmpty ? '$s – Present' : s;
    return '$s – $e';
  }
}
