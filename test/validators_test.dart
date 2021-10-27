import 'package:challenge/constants/strings.dart';
import 'package:challenge/core/utils/validators.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:test/test.dart';


class ValidatorText with Validator {}


Map<String, String?> phoneNumberTestCases = {
'xfh0976578996807866554897': Strings.errorMessageForNumberMustBeADigit,
  '9487742820948472827492838': Strings.errorMessageForNumberMustBeLessThan20,
  '07098485758585': null
};

void main() {
  final ValidatorText validator = ValidatorText();

  group('Validator Test', () {

     group('phone number validator', () {
       phoneNumberTestCases.forEach((key, value) { 

      test('can only include numbers', () {
        expect(key, validator.verifyPhoneNumber(value));
      });

      test('must be less than 20 characters', () {
        expect(key, validator.verifyPhoneNumber(value));
      });
         
       
     });
  });
});

}