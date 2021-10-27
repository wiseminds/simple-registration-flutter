import 'dart:math';

import 'package:challenge/views/account/bloc/app_form_bloc.dart';
import 'package:challenge/widgets/medium_button.dart';
import 'package:challenge/widgets/spring_progressbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:challenge/core/extensions/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_header.dart';
import 'otp_verification_form.dart';

class PinForm extends StatefulWidget {
  final Function() onSuccess;
  final AppFormBloc formBloc;

  const PinForm({Key? key, required this.onSuccess, required this.formBloc})
      : super(key: key);

  @override
  _PinFormState createState() => _PinFormState();
}

class _PinFormState extends State<PinForm> {
  late FocusNode _focusNode;

  late TextEditingController _controller;

  @override
  void initState() {
    _focusNode = FocusNode();
    _controller = TextEditingController();
    _controller.text = widget.formBloc.state.pin ?? '';

    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      resizeToAvoidBottomInset: true,
      body: BlocConsumer<AppFormBloc, AppFormState>(
          bloc: widget.formBloc,
          listener: (context, state) {},
          builder: (context, state) => Stack(
                fit: StackFit.expand,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            20.0.h,
                            const SpringProgressbar(progress: 3 / 4),
                            20.0.h,
                            const AuthHeader(
                              title: 'Create Pin',
                              subtitle:
                                  'Please create your pin to secure your account',
                            ),
                            GestureDetector(
                              onLongPress: () async {
                                var data =
                                    await Clipboard.getData("text/plain");
                                if (data?.text?.isNotEmpty ?? false) {
                                  var text = data!.text!.trim();
                                  if (text.length == 6) {
                                    _controller.text = text;
                                    update(text);
                                  }
                                }
                              },
                              onTap: _focusNode.requestFocus,
                              child: SizedBox(
                                height: 90,
                                child: Stack(children: [
                                  AutofillGroup(
                                    child: TextField(
                                      controller: _controller,
                                      focusNode: _focusNode,
                                      enabled: true,
                                      autofillHints: const <String>[
                                        AutofillHints.oneTimeCode
                                      ],
                                      autofocus: false,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(6)
                                      ],
                                      autocorrect: false,
                                      onChanged: update,
                                      keyboardType: TextInputType.number,
                                      // enableInteractiveSelection: false,
                                      // showCursor: false,
                                      maxLength: 6,

                                      buildCounter: (c,
                                              {int? currentLength,
                                              bool? isFocused,
                                              int? maxLength}) =>
                                          const Text(''),
                                      cursorWidth: 0.01,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(0),
                                        border: InputBorder.none,
                                        fillColor: Colors.red,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                      ),
                                      style: const TextStyle(
                                        color: Colors.transparent,
                                        height: .01,
                                        fontSize:
                                            0.01, // it is a hidden textfield which should remain transparent and extremely small
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      for (var i = 0; i < 6; i++)
                                        Expanded(
                                            child: OtpChip(
                                                encryptDisplay: true,
                                                key: ValueKey(i),
                                                number: getOtpItem(i),
                                                isFocused: _focusNode
                                                        .hasPrimaryFocus &&
                                                    (state.pin ?? '').length ==
                                                        i)),
                                    ],
                                  ),
                                ]),
                              ),
                            ),
                            .0.s,
                            BlocBuilder<AppFormBloc, AppFormState>(
                                bloc: widget.formBloc,
                                builder: (context, state) => SizedBox(
                                      child: MediumButton(
                                        label: 'Continue',
                                        onPressed: () {
                                          if (state.validatePin(
                                                  state.pin ?? '') ==
                                              null) {
                                            widget.onSuccess();
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Please enter a valid pin'),
                                              backgroundColor: Colors.red,
                                            ));
                                          }
                                        },
                                      ),
                                    )),
                            70.0.h,
                          ])),
                ],
              )),
    );
  }

  update(String text) {
    text.trim().replaceAll(' ', '');
    text = text.substring(0, min(6, text.length));

    widget.formBloc.add(PinChanged(text));

    if (text.length == 6) {
      WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
    }
  }

  String getOtpItem(int index) {
    if ((widget.formBloc.state.pin?.length ?? 0) > index) {
      return widget.formBloc.state.pin![index];
    }
    return '';
  }
}
