import 'package:challenge/constants/strings.dart';
/// A mixin that handles all validation
mixin Validator {
  final RegExp numberRegExp = RegExp(r'^\d+$'); // RegExp to validate numbers

  /// a phone number validator function
  String? verifyPhoneNumber(String? number) {
    number = number?.replaceAll(' ', '') ?? '';
    if (number.isEmpty) {
      return Strings.errorMessageForNumberMustNotBeEmpty;
    } else if (!numberRegExp.hasMatch(number)) {
      return Strings.errorMessageForNumberMustBeADigit;
    } else if (number.length > 20) {
      return Strings.errorMessageForNumberMustBeLessThan20;
    }
    return null;
  }
}
