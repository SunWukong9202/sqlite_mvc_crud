// ignore_for_file: file_names

class ValidatorHelper {
  static bool _isValid(String email) {
    // Expresión regular para validar emails
    final RegExp regex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    );

    return regex.hasMatch(email);
  }

  static String? validateEmptyField(value) {
    if (value == null || value.isEmpty) {
      return "Este campo es obligatorio";
    }
    return null;
  }

  static String? validateEmail(value) {
    var error = validateEmptyField(value);
    if (error == null) {
      return !_isValid(value)
          ? "Por favor, ingrese un correo electrónico válido"
          : null;
    }
    return error;
  }
}
