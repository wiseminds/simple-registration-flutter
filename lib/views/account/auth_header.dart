 
import 'package:flutter/material.dart'; 
import 'package:challenge/core/extensions/index.dart';

class AuthHeader extends StatelessWidget {
  final String title, subtitle;
  final bool showBackbutton;
  const AuthHeader(
      {Key? key,
      required this.title,
      required this.subtitle,
      this.showBackbutton = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizedBox(height: showBackbutton ? 80 : 50),
        Align(
            alignment: Alignment.centerLeft,
            child: Text(title,
                style:
                    context.headline5?.copyWith(fontWeight: FontWeight.w700))),
       10.0.h,
        Text(subtitle,
            style: context.caption),
      ],
    );
  }
}
