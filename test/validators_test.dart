import 'package:challenge/constants/strings.dart';
import 'package:challenge/core/utils/validators.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:test/test.dart';


class ValidatorTest with Validator {}


Map<String, String?> phoneNumberTestCases = {
'': Strings.errorMessageForNumberMustNotBeEmpty,
'xfh0976578996807866554897': Strings.errorMessageForNumberMustBeADigit,
  '9487742820948472827492838': Strings.errorMessageForNumberMustBeLessThan20,
  '07098485758585': null
};


Map<String, String?> pinTestCases = {
'': Strings.errorMessageForEmptyPin,
'xfh0976578996807866554897': Strings.errorMessageForInvalidPin,
 '9487742820948472827492838': Strings.errorMessageForInvalidPin,
  '123456': null
};

void main() {
  final ValidatorTest validator = ValidatorTest();

  group('Validator Test', () {

     group('phone number validator', () {
       phoneNumberTestCases.forEach((key, value) { 

      test('can only include numbers', () {
        expect(value, validator.verifyPhoneNumber(key));
      });

      test('must be less than 20 characters', () {
        expect(value, validator.verifyPhoneNumber(key));
      });
         
       
     });

       group('Validate pin', () {
        
      test('can only include numbers', () {
        expect(Strings.errorMessageForInvalidPin, validator.validatePin('xfh0976578996807866554897'));
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
  });
});

}