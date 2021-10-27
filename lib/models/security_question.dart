import 'package:equatable/equatable.dart';

class SecurityQuestion extends Equatable {
  final String slug, question;

  const SecurityQuestion(this.slug, this.question);

  @override
  List<Object?> get props => [slug, question];
}
