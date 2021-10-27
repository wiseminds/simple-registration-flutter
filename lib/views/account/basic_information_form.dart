import 'package:challenge/constants/dimens.dart';
import 'package:challenge/widgets/date_input_field.dart';
import 'package:challenge/widgets/dropdown_input.dart';
import 'package:challenge/widgets/location/state_lga_dropdown.dart';
import 'package:challenge/widgets/medium_button.dart';
import 'package:challenge/widgets/spring_progressbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:challenge/core/extensions/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_header.dart';
import 'bloc/app_form_bloc.dart';

class BasicInformationForm extends StatefulWidget {
  final Function() onSuccess;
  final AppFormBloc formBloc;
  const BasicInformationForm(
      {Key? key, required this.onSuccess, required this.formBloc})
      : super(key: key);

  @override
  _BasicInformationFormState createState() => _BasicInformationFormState();
}

class _BasicInformationFormState extends State<BasicInformationForm> {
  final FocusNode _focusNode = FocusNode();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.formBloc.state.fullname ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.backgroundColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingNormal),
          child: AutofillGroup(
            child: Form(
              autovalidateMode: autovalidateMode,
              child: ListView(
                children: [
                  20.0.h,
                  const SpringProgressbar(progress: 2 / 4),
                  20.0.h,
                  const AuthHeader(
                    title: 'Basic Information',
                    subtitle: 'We would like to know you better',
                  ),
                  40.0.h,
                  BlocBuilder<AppFormBloc, AppFormState>(
                    bloc: widget.formBloc,
                    buildWhen: (prev, current) =>
                        prev.fullname != current.fullname,
                    builder: (context, state) {
                      return TextFormField(
                        controller: _nameController,
                        focusNode: _focusNode,
                        autofillHints: const <String>[AutofillHints.name],
                        autovalidateMode: autovalidateMode,
                        style: context.bodyText1,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        validator: state.verifyFullName,
                        onChanged: (value) =>
                            widget.formBloc.add(FullnameChanged(value)),
                        //added 3 digit to compensate for space added by formatter
                        maxLength: 50,
                        decoration: InputDecoration(
                            // ignore: prefer_const_constructors

                            counterStyle: context.caption!
                                .copyWith(fontSize: .0001, height: .001),
                            labelText: 'Full name',
                            hintText: 'Please enter full name'),
                      );
                    },
                  ),
                  20.0.h,
                  BlocBuilder<AppFormBloc, AppFormState>(
                    bloc: widget.formBloc,
                    buildWhen: (prev, current) =>
                        prev.dateOfBirth != current.dateOfBirth,
                    builder: (context, state) {
                      return DateInputField(
                          label: 'Date of birth',
                          hint: 'Date of birth',
                          errorText: state.validateDOB(state.dateOfBirth),
                          value: state.dateOfBirth,
                          onChanged: (value) {
                            widget.formBloc.add(DateChanged(value));
                          });
                    },
                  ),
                  20.0.h,
                  BlocBuilder<AppFormBloc, AppFormState>(
                    bloc: widget.formBloc,
                    buildWhen: (prev, current) => prev.gender != current.gender,
                    builder: (context, state) {
                      return DropdownInput<Gender>(
                        label: 'Gender',
                        hint: 'Gender',
                        showToplabel: state.gender != null,
                        value: state.gender,
                        errorText: state.gender != null
                            ? null
                            : 'please enter a valid',
                        options: [
                          for (var item in Gender.values)
                            InputItem(item, describeEnum(item).toTitleCase())
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            widget.formBloc.add(GenderChanged(value));
                          }
                        },
                      );
                    },
                  ),
                  10.0.h,
                  BlocBuilder<AppFormBloc, AppFormState>(
                      bloc: widget.formBloc,
                      builder: (context, state) => StateLgaDropdown(
                            initialState: state.state,
                            initialLga: state.lga,
                            onLgaChanged: (value) {
                              widget.formBloc.add(LgaChanged(value));
                              if (autovalidateMode ==
                                  AutovalidateMode.disabled) {
                                setState(() {
                                  autovalidateMode = AutovalidateMode.always;
                                });
                              }
                            },
                            onStateChanged: (value) =>
                                widget.formBloc.add(StateChanged(value)),
                          )),
                  100.0.h,
                  BlocBuilder<AppFormBloc, AppFormState>(
                      bloc: widget.formBloc,
                      builder: (context, state) => MediumButton(
                            label: 'Continue',
                            onPressed: () {
                              if (autovalidateMode ==
                                  AutovalidateMode.disabled) {
                                setState(() {
                                  autovalidateMode = AutovalidateMode.always;
                                });
                              }
                              if (state.isBasicInformationValid) {
                                widget.onSuccess();
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content:
                                      Text('Please enter all required fields'),
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
      ),
    );
  }
}
