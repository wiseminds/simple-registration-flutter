import 'package:challenge/constants/strings.dart';

/// A mixin that handles all validation
mixin Validator {
  final RegExp numberRegExp = RegExp(r'^\d+$'); // RegExp to validate numbers
  final RegExp nigerianNumber = RegExp(r'^([0]?)(7|8|9)(0|1)\d{8}$');
  final RegExp _pinRegExp = RegExp(
    r'^[0-9]{1}[0-9]{1}[0-9]{1}[0-9]{1}[0-9]{1}[0-9]{1}$',
  );

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

  /// a full name validator function
  String? verifyFullName(String? name) {
    if (name?.isEmpty ?? true) {
      return Strings.errorMessageForNameMustNotBeEmpty;
    } else if (name!.length > 50) {
      return Strings.errorMessageForNameMustBeLessThan50Characters;
    }
    return null;
  }


  String? validatePin(String text) {
    if (text.isEmpty) {
      return Strings.errorMessageForEmptyPin;
    } else if (!_pinRegExp.hasMatch(text)) {
      return Strings.errorMessageForInvalidPin;
    }
  }
}

