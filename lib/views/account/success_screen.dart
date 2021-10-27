import 'package:challenge/constants/dimens.dart';
import 'package:challenge/core/extensions/index.dart';
import 'package:challenge/widgets/medium_button.dart';
import 'package:flutter/material.dart';
import 'package:spring/spring.dart';

class SuccessScreen extends StatelessWidget {
  final String title, subtitle;
  const SuccessScreen({Key? key, required this.subtitle, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.paddingNormal),
        child: Column(
          children: [
            .0.s,
            const SuccessIcon(),
            40.0.h,
            Text(
              title,
              textAlign: TextAlign.center,
              style: context.headline4?.copyWith(fontSize: 18),
            ),
            9.0.h,
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: context.bodyText1?.copyWith(fontSize: 12),
            ),
            135.0.h,
            MediumButton(
              label: 'Okay',
              onPressed: () => Navigator.pop(context),
            ),
            .0.s,
          ],
        ),
      ),
    );
  }
}

class SuccessIcon extends StatefulWidget {
  const SuccessIcon({
    Key? key,
  }) : super(key: key);

  @override
  _SuccessIconState createState() => _SuccessIconState();
}

class _SuccessIconState extends State<SuccessIcon> {
  final SpringController springController = SpringController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      springController.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    var color = context.isDark ? Colors.white60 : context.primaryColor;
    return Spring.fadeIn(
        animDuration: const Duration(milliseconds: 500),
        child: Spring.shake(
          springController: springController,
          animDuration: const Duration(milliseconds: 700),
          start: 100,
          end: 90,
          // child: Spring.scale(
          //   springController: springController,
          //   start: 0.4,
          //   end: 1.0,
          //   animDuration: const Duration(milliseconds: 700),
          //   animStatus: (AnimStatus status) {
          //     print(status);
          //   },
          //   curve: Curves.bounceInOut,
          child: Material(
              shape: const CircleBorder(),
              color: color.withOpacity(.1),
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Material(
                    shape: const CircleBorder(),
                    color: color,
                    child: Padding(
                      padding: const EdgeInsets.all(26.0),
                      child: Spring.rotate(
                          startAngle: 320,
                          animDuration: const Duration(milliseconds: 100),
                          child: Icon(
                            Icons.check,
                            size: 60,
                          )),
                    ),
                  ))),
        ));
  }
}
