class FormValidator {
  
  static String validateName(String value) {
    if (value.length < 1)
      return 'El campo nombre está vacio';
    else
      return null;
  }

  static String validateMobile(String value) {
    if (value.length != 10)
      return 'Los números telefónicos son de 10 dígitos';
    else
      return null;
  }

  static String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Ingresa un email válido';
    else
      return null;
  }

  static String validatePassword(String value){
    if(value.length<8) return "La contraseña debe tener mínimo 8 carácteres";
    return null;
  }
}