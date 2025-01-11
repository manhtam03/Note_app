class Validator {
  Validator._();

  static String? nameValidator(String? name) {
    name = name?.trim() ?? '';
    return name.isEmpty ? 'Please enter the name!' : null;
  }

  static String? emailValidator(String? email) {
    email = email?.trim() ?? '';
    return email.isEmpty
        ? 'Please enter the email address!'
        : !email.contains("@")
            ? 'Please enter the correct email format!'
            : null;
  }

  static String? passwordValidator(String? password) {
    password = password?.trim() ?? '';
    String errorMessage = '';
    if(password.isEmpty) {
      errorMessage = 'Please enter the password!';
    } else {
      if(password.length < 6){
        errorMessage = 'Please enter all 6 characters';
      }

      if(!password.contains(RegExp(r'[a-z]'))) {
        errorMessage = '$errorMessage\n Password must have at least 1 regular word';
      }

      // if(!password.contains(RegExp(r'[A-Z]'))) {
      //   errorMessage = '$errorMessage\n Password must have at least 1 capital letter';
      // }
      //
      // if(!password.contains(RegExp(r'[0-9]'))) {
      //   errorMessage = '$errorMessage\n The password must have at least 1 number';
      // }
    }

    return errorMessage.isNotEmpty ? errorMessage.trim() : null;
  }
}
