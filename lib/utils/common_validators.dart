class CommonValidators {
  static String? validateMobile(String? value) {
    const String pattern = '^[0-9]{10}\$';
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  static String? validateName(String? value, String? label) {
    if (value!.isEmpty) {
      return '$label cannot be empty';
    }
    return null;
  }

  static String? validateRupee(String? value) {
    if (value == null || value.isEmpty) {
      return 'Rupee value cannot be empty';
    }

    // Try to parse the value as a double
    final int? rupeeValue = int.tryParse(value);
    if (rupeeValue == null) {
      return 'Please enter a valid integer number';
    }

    // Check if the value is within the range 1 to 100
    if (rupeeValue < 1 || rupeeValue > 100) {
      return 'Rupee value must be between 1 and 100';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    const String pattern =
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~])[A-Za-z\d!@#\$&*~]{8,}$';
    RegExp regExp = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    } else if (!regExp.hasMatch(value)) {
      return 'Must be 8+ chars, with upper, lower, number & special char';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return 'Please enter email';
    } else if (!regex.hasMatch(value!)) {
      return 'Enter Valid Email';
    } else {
      return null;
    }
  }

  static String? confirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    }
    if (value != password) {
      return "Passwords must match";
    }

    return null;
  }
}
