class TextFieldValidator {
  String? validateEmail(String email) {
    if (email.trim().isEmpty) return 'Please enter your email';
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern as String);

    if (!regex.hasMatch(email)) return 'Please enter a valid email';
    return null;
  }

  String? validatePassword(String phone) {
    if (phone.toString().trim().isEmpty) {
      return 'Please enter your password';
    }
    if (phone.toString().length < 8) {
      return 'Please should be at least 8 characters long.';
    }
    if (!phone.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }
    if (!phone.contains(RegExp(r'[a-zA-Z]'))) {
      return 'Password must contain at least one character.';
    }
    return null;
  }

  String? validateConfirmPassword(String pass1, String pass2) {
    if (pass1.toString().trim().isEmpty) {
      return 'Please enter your password';
    }
    if (pass2 != pass1) {
      return 'Confirm password dose not match';
    }
    return null;
  }

  String? validateEmpty(String? value, String hint, {bool dropDown = false}) {
    if (value.toString().trim().isEmpty) {
      return 'Please ${dropDown ? "select" : "enter"} your $hint';
    }
    return null;
  }
}
