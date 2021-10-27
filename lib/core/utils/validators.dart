import 'package:challenge/constants/strings.dart';

mixin Validator {
  final RegExp numberRegExp = RegExp(r'^\d+$'); // RegExp to validate numbers

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
