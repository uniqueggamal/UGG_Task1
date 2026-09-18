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

    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }

    // Optional: only allow letters, spaces, hyphens and apostrophes
    if (!RegExp(r"^[a-zA-Z\s\-']+$").hasMatch(value.trim())) {
      return 'Name can only contain letters, spaces, hyphens and apostrophes';
    }

    return null; // valid
  }

  static String? validateMiddleName(String? value) {
    // Middle name is optional → empty is allowed
    if (value == null || value.trim().isEmpty) {
      return null; // valid
    }

    final name = value.trim();

    if (name.length < 1) {
      return 'Middle name is too short';
    }

    if (name.length > 30) {
      return 'Middle name is too long';
    }

    // Allow letters, spaces, hyphens and apostrophes (same as fname/lname)
    if (!RegExp(r"^[a-zA-ZÀ-ÿ\s\-']+$").hasMatch(name)) {
      return 'Please enter a valid middle name';
    }

    return null;
  }
}
