import 'package:challenge/core/utils/number_formatter.dart';
import 'package:challenge/views/account/otp_verification_form.dart';
import 'package:challenge/widgets/spring_progressbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:challenge/constants/dimens.dart';
import 'package:challenge/core/router/app_route.dart';
import 'package:challenge/widgets/medium_button.dart';
import 'package:challenge/core/extensions/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_header.dart';
import 'bloc/app_form_bloc.dart';
import 'bloc/auth_bloc.dart';

class PhoneVerificationScreen extends StatefulWidget implements AppRoute {
  static String get routeName => 'phone-verification';

  @override
  Widget get page => this;

  @override
  String get route => routeName;
  const PhoneVerificationScreen({Key? key}) : super(key: key);

  @override
  _PhoneVerificationScreenState createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  late AppFormBloc _formBloc;
  late AuthBloc _bloc;
  final FocusNode _focusNode = FocusNode();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    _bloc = AuthBloc();
    _formBloc = AppFormBloc();
    super.initState();

    /// only show validation when the user has attempted to enter phone number
    _focusNode.addListener(() {
      if (!_focusNode.hasPrimaryFocus) {
        setState(() {
          autovalidateMode = AutovalidateMode.always;
        });
      }
    });
  }

  @override
  dispose() {
    _bloc.close();
    _formBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CupertinoNavigationBar(
          backgroundColor: context.backgroundColor,
          border: Border.all(color: Colors.transparent),
          trailing: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Step 1 of 4',
              style: context.caption,
            ),
          ),
        ),
        resizeToAvoidBottomInset: true,
        body: Builder(builder: (context) {
          return BlocConsumer<AuthBloc, AuthState>(
            bloc: _bloc,
            listener: (context, state) {
              if (state is FailureAuthState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.message),
                  duration: const Duration(milliseconds: 500),
                  backgroundColor: Colors.red,
                ));
              } else if (state is SuccessAuthState) {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (c) => SizedBox(
                      height: MediaQuery.of(context).size.height * .8,
                      child: const OtpVerificationForm()),
                );
              }
            },
            builder: (context, authState) {
              return Material(
                color: context.backgroundColor,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.paddingNormal),
                    child: AutofillGroup(
                      child: Column(
                        children: [
                          20.0.h,
                          const SpringProgressbar(progress: 1 / 4),
                          20.0.h,
                          const AuthHeader(
                            title: '',
                            subtitle: 'Please enter your phone number to begin',
                          ),
                          40.0.h,
                          BlocBuilder<AppFormBloc, AppFormState>(
                            bloc: _formBloc,
                            buildWhen: (prev, current) =>
                                prev.phoneNumber != current.phoneNumber,
                            builder: (context, state) {
                              return TextFormField(
                                enabled: authState
                                    is! LoadingAuthState, // disable text field when submiting
                                focusNode: _focusNode,
                                autofillHints: authState is LoadingAuthState
                                    ? null
                                    : const <String>[
                                        AutofillHints.telephoneNumber,
                                        AutofillHints.telephoneNumberNational
                                      ],
                                autovalidateMode: autovalidateMode,
                                style: context.bodyText1,
                                keyboardType: TextInputType.phone,
                                inputFormatters: [NumberFormatter()],
                                validator: state.verifyPhoneNumber,
                                onChanged: (value) =>
                                    _formBloc.add(PhoneNumberChanged(value)),
                                //added 3 digit to compensate for space added by formatter
                                maxLength: 20 + 3,
                                decoration: InputDecoration(
                                    // ignore: prefer_const_constructors
                                    prefix: Text('+234  '),
                                    counterStyle: context.caption!.copyWith(
                                        fontSize: .0001, height: .001),
                                    labelText: 'Phone number',
                                    hintText: 'Please enter phone number'),
                              );
                            },
                          ),
                          .0.s,
                          BlocBuilder<AppFormBloc, AppFormState>(
                              bloc: _formBloc,
                              builder: (context, state) => MediumButton(
                                    label: 'Continue',
                                    isLoading: authState is LoadingAuthState,
                                    onPressed: () {
                                      setState(() {
                                        autovalidateMode =
                                            AutovalidateMode.always;
                                      });
                                      if (state.isPhoneNumberValid) {
                                        _bloc.add(SubmitPhoneNumber(
                                            state.phoneNumberSanitized));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              'Please enter a valid phone number'),
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
                ),
              );
            },
          );
        }));
  }
}
