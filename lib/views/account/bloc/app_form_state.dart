part of 'app_form_bloc.dart';

enum Gender { male, female }

const securityQuestions = [
  SecurityQuestion('favorite', 'Who is your favorite author?'),
  SecurityQuestion('first', 'Who was your first boss'),
];

@immutable
class AppFormState extends Equatable with Validator {
  final String? phoneNumber, otp, fullname, pin, answer1, answer2;
  final Gender? gender;
  final SecurityQuestion? question, altQuestion;
  final DateTime? dateOfBirth;
  final Location? state, lga;

  /// removed all spaces added from input formater
  String get phoneNumberSanitized => (phoneNumber ?? '').replaceAll(' ', '');

  AppFormState(
      {this.state,
      this.lga,
      this.answer1,
      this.answer2,
      this.question,
      this.dateOfBirth,
      this.pin,
      this.altQuestion,
      this.fullname,
      this.gender,
      this.phoneNumber,
      this.otp});

  /// clone the current state with updated values
  AppFormState copyWith(
          {String? phoneNumber,
          String? otp,
          DateTime? dateOfBirth,
          Gender? gender,
          String? answer1,
          String? answer2,
          Location? state,
          Location? lga,
          String? pin,
          SecurityQuestion? altQuestion,
          SecurityQuestion? question,
          String? fullname}) =>
      AppFormState(
          dateOfBirth: dateOfBirth ?? this.dateOfBirth,
          phoneNumber: phoneNumber ?? this.phoneNumber,
          otp: otp ?? this.otp,
          pin: pin ?? this.pin,
          lga: state != null ? null : (lga ?? this.lga),
          state: state ?? this.state,
          answer2: answer2 ?? this.answer2,
          answer1: answer1 ?? this.answer1,
          altQuestion: altQuestion ?? this.altQuestion,
          question: question ?? this.question,
          fullname: fullname ?? this.fullname,
          gender: gender ?? this.gender);

  bool get isPhoneNumberValid => verifyPhoneNumber(phoneNumber) == null;
  bool get isBasicInformationValid =>
      verifyFullName(fullname) == null &&
      gender != null &&
      dateOfBirth != null &&
      state != null &&
      lga != null;

  bool get isSecurityFormValid =>
      question != null &&
      altQuestion != null &&
      answer1 != null &&
      answer1!.isNotEmpty &&
      answer2 != null &&
      answer2!.isNotEmpty;
  @override
  List<Object?> get props => [
        phoneNumber,
        otp,
        gender,
        fullname,
        dateOfBirth,
        pin,
        altQuestion,
        question,
        state,
        lga,
        answer1,
        answer2
      ];

  Map<String, dynamic> get formToMap => {
        'phoneNumber': phoneNumberSanitized,
        'otp': otp,
        'pin': pin,
        'dateOfBirth': dateOfBirth,
        'fullname': fullname,
        'gender': gender,
        'question': question,
        'state': state?.id,
        'lga': lga?.id
      };

  @override
  String toString() => {
        'phoneNumber': phoneNumber,
        'otp': otp,
        'pin': pin,
        'dateOfBirth': dateOfBirth,
        'fullname': fullname,
        'gender': gender,
        'question': question,
        'state': state,
        'lga': lga
      }.toString();
}
