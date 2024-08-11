import 'package:form_field_validator/form_field_validator.dart';

class Validator {
  var emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is required'),
    EmailValidator(errorText: 'Enter a valid email address')
  ]);

  var passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
    MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
    PatternValidator(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
        errorText: 'Password strength: weak '
            '\nAt least one upper case '
            '\nAt least one lower case '
            '\nAt least one number '
            '\nAt least one Special character')
  ]);

  var phoneValidator = MultiValidator([
    MinLengthValidator(11,
        errorText: 'Phone number must be at least 11 digits long'),
    MaxLengthValidator(11,
        errorText: 'Phone number must be at most 11 digits long'),
  ]);

  var requiredValidator =
      RequiredValidator(errorText: 'This field is required');
  // var phoneValidator = MinLengthValidator(11, errorText: 'Phone number must be at least 11 digits long');
}
