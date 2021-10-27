import 'package:challenge/constants/dimens.dart';
import 'package:challenge/models/security_question.dart';
import 'package:challenge/widgets/dropdown_input.dart';
import 'package:challenge/widgets/medium_button.dart';
import 'package:challenge/widgets/spring_progressbar.dart';
import 'package:flutter/material.dart';
import 'package:challenge/core/extensions/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_header.dart';
import 'bloc/app_form_bloc.dart';
import 'bloc/auth_bloc.dart';

class SecurityQuestionsForm extends StatefulWidget {
  final AppFormBloc formBloc;
  final Function() onSuccess;
  const SecurityQuestionsForm(
      {Key? key, required this.onSuccess, required this.formBloc})
      : super(key: key);

  @override
  _SecurityQuestionsFormState createState() => _SecurityQuestionsFormState();
}

class _SecurityQuestionsFormState extends State<SecurityQuestionsForm> {
  AutovalidateMode autovalidateModeQ1 = AutovalidateMode.disabled;
  AutovalidateMode autovalidateModeQ2 = AutovalidateMode.disabled;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final TextEditingController _qController1 = TextEditingController();
  final TextEditingController _qController2 = TextEditingController();
  final FocusNode _a1Node = FocusNode();
  final FocusNode _a2Node = FocusNode();

  @override
  void initState() {
    _qController1.text = widget.formBloc.state.answer1 ?? '';
    _qController2.text = widget.formBloc.state.answer2 ?? '';
    super.initState();
    _a2Node.addListener(() {
      if (!_a2Node.hasPrimaryFocus) {
        setState(() {
          autovalidateModeQ2 = AutovalidateMode.always;
          autovalidateModeQ1 = AutovalidateMode.always;
          autovalidateMode = AutovalidateMode.always;
        });
      }
    });
    _a1Node.addListener(() {
      if (!_a1Node.hasPrimaryFocus) {
        setState(() {
          autovalidateModeQ1 = AutovalidateMode.always;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: context.backgroundColor,
        child: SafeArea(
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.paddingNormal),
                child: AutofillGroup(
                  child: Form(
                    autovalidateMode: autovalidateMode,
                    child: ListView(
                      children: [
                        20.0.h,
                        const SpringProgressbar(progress: 4 / 4),
                        20.0.h,
                        const AuthHeader(
                          title: 'Recovery options',
                          subtitle: 'Pease set up security questions',
                        ),
                        40.0.h,
                        BlocBuilder<AppFormBloc, AppFormState>(
                            bloc: widget.formBloc,
                            builder: (context, state) {
                              return DropdownInput<SecurityQuestion>(
                                enabled: authState is! LoadingAuthState,
                                label: 'Security Question 1',
                                hint: 'Security Question',
                                showToplabel: state.question != null,
                                value: state.question,
                                errorText: state.question != null
                                    ? null
                                    : 'please select security questions',
                                options: [
                                  for (var item in securityQuestions)
                                    InputItem(item, item.question)
                                ],
                                onChanged: (value) {
                                  if (value != null &&
                                      state.altQuestion != value) {
                                    widget.formBloc
                                        .add(SecurityQuestionChanged(value));
                                  }
                                },
                              );
                            }),
                        40.0.h,
                        BlocBuilder<AppFormBloc, AppFormState>(
                          bloc: widget.formBloc,
                          buildWhen: (prev, current) =>
                              prev.answer1 != current.answer1,
                          builder: (context, state) {
                            return TextFormField(
                              enabled: authState is! LoadingAuthState,
                              controller: _qController1,
                              focusNode: _a1Node,
                              autovalidateMode: autovalidateModeQ1,
                              style: context.bodyText1,
                              validator: (text) => (text ?? '').isEmpty
                                  ? 'Please enter security answer'
                                  : null,
                              onChanged: (value) =>
                                  widget.formBloc.add(Answer1Changed(value)),
                              //added 3 digit to compensate for space added by formatter
                              maxLength: 100,
                              onEditingComplete: () {
                                setState(() {
                                  autovalidateModeQ1 = AutovalidateMode.always;
                                });
                              },
                              decoration: InputDecoration(
                                  counterStyle: context.caption!
                                      .copyWith(fontSize: .0001, height: .001),
                                  labelText: 'Security answer 1',
                                  hintText: 'Please enter security answer'),
                            );
                          },
                        ),
                        30.0.h,
                        BlocBuilder<AppFormBloc, AppFormState>(
                          bloc: widget.formBloc,
                          builder: (context, state) {
                            return DropdownInput<SecurityQuestion>(
                              enabled: authState is! LoadingAuthState,
                              label: 'Security Question 2',
                              hint: 'Security Question',
                              showToplabel: state.altQuestion != null,
                              value: state.altQuestion,
                              errorText: state.altQuestion != null
                                  ? null
                                  : 'please select security questions',
                              options: [
                                for (var item in securityQuestions)
                                  InputItem(item, item.question)
                              ],
                              onChanged: (value) {
                                if (value != null && state.question != value) {
                                  widget.formBloc
                                      .add(AltSecurityQuestionChanged(value));
                                }
                              },
                            );
                          },
                        ),
                        30.0.h,
                        BlocBuilder<AppFormBloc, AppFormState>(
                          bloc: widget.formBloc,
                          buildWhen: (prev, current) =>
                              prev.answer2 != current.answer2,
                          builder: (context, state) {
                            return TextFormField(
                              enabled: authState is! LoadingAuthState,
                              controller: _qController2,
                              focusNode: _a2Node,
                              autovalidateMode: autovalidateModeQ2,
                              style: context.bodyText1,
                              keyboardType: TextInputType.name,
                              textCapitalization: TextCapitalization.words,
                              validator: (text) => (text ?? '').isEmpty
                                  ? 'Please enter security answer'
                                  : null,
                              onChanged: (value) =>
                                  widget.formBloc.add(Answer2Changed(value)),
                              //added 3 digit to compensate for space added by formatter
                              maxLength: 50,
                              onEditingComplete: () {
                                setState(() {
                                  autovalidateModeQ1 = AutovalidateMode.always;
                                  autovalidateModeQ2 = AutovalidateMode.always;
                                  autovalidateMode = AutovalidateMode.always;
                                });
                              },
                              decoration: InputDecoration(
                                  counterStyle: context.caption!
                                      .copyWith(fontSize: .0001, height: .001),
                                  labelText: 'Security answer 2',
                                  hintText: 'Please enter Security answer '),
                            );
                          },
                        ),
                        100.0.h,
                        BlocBuilder<AppFormBloc, AppFormState>(
                            bloc: widget.formBloc,
                            builder: (context, state) => MediumButton(
                                  label: 'Submit',
                                  isLoading: authState is LoadingAuthState,
                                  onPressed: () {
                                    setState(() {
                                      autovalidateModeQ1 =
                                          AutovalidateMode.always;
                                      autovalidateModeQ2 =
                                          AutovalidateMode.always;
                                      autovalidateMode =
                                          AutovalidateMode.always;
                                    });
                                    if (state.isSecurityFormValid) {
                                      context
                                          .read<AuthBloc>()
                                          .add(SubmitRegister(state.formToMap));
                                      widget.onSuccess();
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content:
                                            Text('Please fill in all fields'),
                                        backgroundColor: Colors.red,
                                      ));
                                    }
                                  },
                                )),
                        50.0.h,
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
