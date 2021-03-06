import 'dart:async';
import 'dart:math';

import 'package:challenge/core/extensions/index.dart';
import 'package:challenge/core/router/app_router.dart';
import 'package:challenge/core/router/route_transisions.dart';
import 'package:challenge/widgets/spring_progressbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_header.dart';
import 'bloc/app_form_bloc.dart';
import 'bloc/auth_bloc.dart';
import 'register_screen.dart';

class OtpVerificationForm extends StatefulWidget {
  const OtpVerificationForm({
    Key? key,
  }) : super(key: key);

  @override
  _OtpVerificationFormState createState() => _OtpVerificationFormState();
}

class _OtpVerificationFormState extends State<OtpVerificationForm> {
  late FocusNode _focusNode;
  late AuthBloc _bloc;
  late AppFormBloc _formBloc;
  late TextEditingController _controller;

  @override
  void initState() {
    _focusNode = FocusNode();
    _formBloc = AppFormBloc();
    _controller = TextEditingController();
    _controller.text = _formBloc.state.otp ?? '';
    _bloc = AuthBloc();

    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _bloc.close();
    _formBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: context.backgroundColor,
        leading: const CloseButton(),
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
      body: BlocConsumer<AuthBloc, AuthState>(
          bloc: _bloc,
          listener: (context, state) {
            if (state is FailureAuthState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ));
              update('');
            } else if (state is SuccessAuthState) {
              Navigator.of(context).pop();
              Future.delayed(const Duration(milliseconds: 500), () {
                AppRouter.navigationKey.currentState?.pushReplacementNamed(
                    RegisterScreen.routeName,
                    arguments: Transissions.slideLeft);
              });
            }
          },
          builder: (context, authState) => BlocConsumer<AppFormBloc,
                  AppFormState>(
              bloc: _formBloc,
              listener: (context, state) {},
              builder: (context, state) => Stack(
                    fit: StackFit.expand,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // 20.0.h,
                                const AuthHeader(
                                  title: '',
                                  subtitle:
                                      'Please enter OTP sent to your mobile number',
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
                                        child: TextField(key: const ValueKey('otp'),
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
                                                    key: ValueKey(i),
                                                    number: getOtpItem(i),
                                                    isFocused: _focusNode
                                                            .hasPrimaryFocus &&
                                                        (state.otp ?? '')
                                                                .length ==
                                                            i)),
                                        ],
                                      ),
                                    ]),
                                  ),
                                ),

                                30.0.h,
                                .0.s
                              ])),
                      if (authState is LoadingAuthState)
                        Container(
                            color: Colors.black26,
                            alignment: Alignment.center,
                            child: const CupertinoActivityIndicator()),
                    ],
                  ))),
    );
  }

  update(String text) {
    text.trim().replaceAll(' ', '');
    text = text.substring(0, min(6, text.length));

    _formBloc.add(OtpNumberChanged(text));

    if (text.length == 6) {
      WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
      _bloc.add(SubmitOTP(text));
    }
  }

  String getOtpItem(int index) {
    if ((_formBloc.state.otp?.length ?? 0) > index) {
      return _formBloc.state.otp![index];
    }
    return '';
  }
}

class OtpChip extends StatelessWidget {
  final String number;
  final bool isFocused;
  final bool encryptDisplay;

  const OtpChip(
      {Key? key,
      this.number = '',
      this.isFocused = false,
      this.encryptDisplay = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(6),
            border: Border(
                bottom: BorderSide(
                    width: isFocused ? 2 : 1,
                    color:
                        context.primaryColor.withOpacity(isFocused ? 1 : .6)))),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: SizedBox(
              // width: 40.0.width,
              // size: Size.fromRadius(30.0),
              child: Center(
                  child: Text(
            encryptDisplay ? (number.isEmpty ? '' : '*') : number,
            style: context.headline4,
          ))),
        ),
      ),
    );
  }
}
