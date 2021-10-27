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
  final FocusNode _focusNode = FocusNode();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CupertinoNavigationBar(
          backgroundColor: context.backgroundColor,
          border: Border.all(color: Colors.transparent),
          trailing: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Step 1 of 3',
              style: context.caption,
            ),
          ),
        ),
        resizeToAvoidBottomInset: true,
        body: Material(
          color: context.backgroundColor,
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: Dimens.paddingNormal),
              child: AutofillGroup(
                child: Column(
                  children: [
                    20.0.h,
                    const SpringProgressbar(progress: 1 / 3),
                    20.0.h,
                    const AuthHeader(
                      title: 'Verify phone number',
                      subtitle: 'Please enter your phone number to begin',
                    ),
                    40.0.h,
                    BlocBuilder<AppFormBloc, AppFormState>(
                      bloc: _formBloc,
                      builder: (context, state) {
                        return TextFormField(
                          focusNode: _focusNode,
                          autovalidateMode: autovalidateMode,
                          style: context.bodyText1,
                          validator: state.verifyPhoneNumber,
                          onChanged: (value) =>
                              _formBloc.add(PhoneNumberChanged(value)),
                          maxLength: 20,
                          decoration: InputDecoration(
                              // ignore: prefer_const_constructors
                              prefix: Text('+234  '),
                              counterStyle: context.caption!
                                  .copyWith(fontSize: .0001, height: .001),
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
                              onPressed: state.isPhoneNumberValid
                                  ? () {}
                                  : () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                            'Please enter a valid phone number'),
                                        backgroundColor: Colors.red,
                                      ));
                                    },
                            )),
                    20.0.h,
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
