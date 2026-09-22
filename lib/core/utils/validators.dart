class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    final email = value.trim();

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    // if (!RegExp(r'[A-Z]').hasMatch(value)) {
    //   return 'Password must contain at least one uppercase letter';
    // }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }

    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }

    final name = value.trim();

    if (name.length < 2) {
      return 'Name must be at least 2 characters';
    }

    if (RegExp(r'[\d]').hasMatch(name)) {
      return 'Name cannot contain numbers';
    }

    if (RegExp(r'''[!@#$%^&*()_+=\[\]{};:"\\|,.<>/?~`€£¥]''').hasMatch(name)) {
      return 'Name cannot contain special characters';
    }

    return null;
  }

  static String capitalizeWords(String value) {
    return value
        .split(' ')
        .map(
          (word) => word.isEmpty
              ? word
              : '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}',
        )
        .join(' ');
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    final phone = value.trim().replaceAll(RegExp(r'[\s-]'), '');

    if (!RegExp(r'^(?:\+977)?9[678]\d{8}$').hasMatch(phone)) {
      return 'Please enter a valid Nepali phone number';
    }

    return null;
  }

  static String? validateLocation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    final location = value.trim();

    if (location.length < 2) {
      return 'Location must be at least 2 characters';
    }

    if (location.length > 100) {
      return 'Location is too long';
    }

    return null;
  }
}
