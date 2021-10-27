import 'package:challenge/constants/strings.dart';
import 'package:challenge/core/utils/validators.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:test/test.dart';

class ValidatorTest with Validator {}

void main() {
  final ValidatorTest validator = ValidatorTest();

  group('Validator Test', () {
    group('phone number validator', () {
      test('can only include numbers', () {
        expect(Strings.errorMessageForNumberMustBeADigit,
            validator.verifyPhoneNumber('xfh0976578996807866554897'));
      });

      test('must be less than 20 characters', () {
        expect(Strings.errorMessageForNumberMustBeLessThan20,
            validator.verifyPhoneNumber('9487742820948472827492838'));
      });
    });

    group('Validate pin', () {
      test('can only include numbers', () {
        expect(Strings.errorMessageForInvalidPin,
            validator.validatePin('xfh0976578996807866554897'));
      });

      test('pin must not be empty', () {
        expect(Strings.errorMessageForEmptyPin, validator.validatePin(''));
      });

      test('pin must not be empty', () {
        expect(Strings.errorMessageForInvalidPin, validator.validatePin('374'));
      });

      test('pin must be 6 digit', () {
        expect(null, validator.validatePin('487673'));
      });
    });

    group('Validate Date of birth', () {
      test('must not be null', () {
        expect(Strings.errorMessageForInvalidDOB, validator.validateDOB(null));
      });

      test('year must be more than 18 from current date', () {
        expect(Strings.errorMessageForUnderAged,
            validator.validateDOB(DateTime.now()));
        expect(Strings.errorMessageForUnderAged,
            validator.validateDOB(DateTime(DateTime.now().year - 10)));
        expect(null, validator.validateDOB(DateTime(DateTime.now().year - 19)));
      });
    });
  });
}
