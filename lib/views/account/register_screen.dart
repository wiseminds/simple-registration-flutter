import 'package:challenge/core/router/app_route.dart';
import 'package:challenge/core/router/transissions/fade_route.dart';
import 'package:challenge/views/account/basic_information_form.dart';
import 'package:challenge/views/account/pin_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:challenge/core/extensions/index.dart';

import 'bloc/app_form_bloc.dart';
import 'bloc/auth_bloc.dart';
import 'security_questions_form.dart';
import 'success_screen.dart';

class RegisterScreen extends StatefulWidget implements AppRoute {
  static String get routeName => 'register';

  @override
  Widget get page => this;

  @override
  String get route => routeName;
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late PageController _controller;
  late AppFormBloc _formBloc;

  int page = 0;

  @override
  void initState() {
    _controller = PageController();
    _formBloc = AppFormBloc();
    super.initState();
    _controller.addListener(() {
      page = (_controller.page ?? 0).toInt();
    });
  }

  @override
  void dispose() {
    _formBloc.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (page > 0) {
          _controller.previousPage(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOutQuad);
          return false;
        }
        return true;
      },
      child: Scaffold(
          appBar: CupertinoNavigationBar(
            backgroundColor: context.backgroundColor,
            border: Border.all(color: Colors.transparent),
            leading: Material(
              type: MaterialType.transparency,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, c) => BackButton(
                    onPressed: page > 0
                        ? () {
                            _controller.previousPage(
                                duration: const Duration(milliseconds: 600),
                                curve: Curves.easeInOutQuad);
                          }
                        : null),
              ),
            ),
            trailing: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, c) {
                    return Text(
                      'Step ${(page) + 2} of 4',
                      style: context.caption,
                    );
                  }),
            ),
          ),
          resizeToAvoidBottomInset: true,
          body: BlocProvider(
            create: (context) => AuthBloc(),
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _controller,
              children: [
                BasicInformationForm(
                  key: const ValueKey('basic-information'),
                  onSuccess: () {
                    _controller.nextPage(
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeInOutQuad);
                  },
                  formBloc: _formBloc,
                ),
                PinForm(
                  key: const ValueKey('basic-information'),
                  formBloc: _formBloc,
                  onSuccess: () {
                    _controller.nextPage(
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeInOutQuad);
                  },
                ),
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is SuccessAuthState) {
                      Navigator.of(context).pushReplacement(FadeRoute(
                          settings: const RouteSettings(name: 'success'),
                          page: const SuccessScreen(
                            title: 'Account Created successfully',
                            subtitle:
                                'You will be contacted once your account is approved',
                          )));
                    }
                  },
                  child: SecurityQuestionsForm(
                    key: const ValueKey('basic-information'),
                    formBloc: _formBloc,
                    onSuccess: () {},
                  ),
                )
              ],
            ),
          )),
    );
  }
}
