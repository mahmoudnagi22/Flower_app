class AppValidators {
  AppValidators._();

  static String? validateEmail(String? value) {
    RegExp emailRegex = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    } else {
      return null;
    }
  }


  static String? validatePassword(String? val) {
    RegExp passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[\W_]).{8,}$');

    if (val == null || val.trim().isEmpty) {
      return 'This field is required';
    } else if (!passwordRegex.hasMatch(val)) {
      return 'Password must be at least 8 characters and include uppercase, lowercase, numbers, and symbols';
    }
    return null;
  }


  static String? validateConfirmPassword(String? val, String? password) {
    if (val == null ||val.trim().isEmpty) {
      return 'this field is required';
    } else if (val != password) {
      return 'Passwords do not match';
    } else {
      return null;
    }
  }

  static String? validateUsername(String? val) {
    RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9,.-]+$');
    if (val == null) {
      return 'this field is required';
    } else if (val.trim().isEmpty) {
      return 'this field is required';
    } else if (!usernameRegex.hasMatch(val)) {
      return 'enter valid username';
    } else {
      return null;
    }
  }

  static String? validateFullName(String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'this field is required';
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(String? val) {
    if (val == null) {
      return 'this field is required';
    } else if (int.tryParse(val.trim()) == null) {
      return 'enter numbers only';
    } else if (val.trim().length != 12) {
      return 'enter value must equal 11 digit';
    } else {
      return null;
    }
  }
}
