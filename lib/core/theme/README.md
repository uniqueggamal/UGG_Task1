# Design system

Use the semantic utilities in `package:internship_task/utils/app_styles.dart`
when a value represents a shared visual decision. They are responsive through
`flutter_screenutil` and should be preferred over repeated raw values.

## Text

```dart
Text('Page title', style: AppTextStyles.headingLarge)
Text('Description', style: AppTextStyles.bodyMedium)
```

The default family is `NotoSansDevanagari`, which supports English and
Devanagari. Use a local `copyWith` only for a component-specific color or
exceptional font choice.

## Spacing

```dart
SizedBox(height: AppSpacing.xl.h)
Padding(
  padding: EdgeInsets.symmetric(horizontal: AppSpacing.md.w),
)
```

Use `.w` for horizontal dimensions, `.h` for vertical dimensions, and `.r` for
general square dimensions. Keep genuinely unique component measurements local.

## Radius

```dart
BorderRadius.circular(AppRadius.medium)
```

Choose `small`, `medium`, `large`, or `extraLarge` for recurring surface
shapes. A one-off radius can remain local.

## Responsive dimensions

Use `100.w` for width, `50.h` for height, `16.sp` for a one-off font size, and
`8.r` for a one-off radius. Do not scale logical values, widget counts, enums,
or layout values that Flutter should calculate itself.
