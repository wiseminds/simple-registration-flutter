import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MediumButton extends StatelessWidget {
  final Color? color, textColor;
  final String label;
  final bool isLoading, varyOpacity;
  final double? horizontalPadding, radius, elevation;
  final Function()? onPressed;

  const MediumButton(
      {Key? key,
      this.isLoading = false,
      this.varyOpacity = true,
      this.color,
      this.textColor,
      required this.label,
      this.onPressed,
      this.elevation = 10,
      this.radius,
      this.horizontalPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = this.color ?? Theme.of(context).primaryColor;
    var textColor = this.textColor ?? Colors.black;
    return SizedBox(
      width: 600,
      child: ElevatedButton(
          style: ButtonStyle(
              shadowColor: MaterialStateProperty.all(color.withOpacity(.2)),
              elevation: MaterialStateProperty.all(elevation),
              padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
              backgroundColor: MaterialStateProperty.all(varyOpacity
                  ? color.withOpacity(isLoading || onPressed == null ? .6 : 1)
                  : color),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius ?? 4.0)))),
          child: isLoading
              ? SizedBox.fromSize(
                  size: Size.fromRadius(10),
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: textColor,
                  ))
              : Text(
                  label,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
          onPressed: onPressed),
    );
  }
}

class MediumButtonOutlined extends StatelessWidget {
  final Color? color;
  final Color? textColor;
  final String label;
  final bool isLoading, varyOpacity;
  final double? horizontalPadding, radius, elevation;
  final Function()? onPressed;

  const MediumButtonOutlined(
      {Key? key,
      this.isLoading = false,
      this.varyOpacity = true,
      this.color,
      this.textColor,
      required this.label,
      this.onPressed,
      this.elevation,
      this.radius,
      this.horizontalPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = this.color ?? Theme.of(context).primaryColor;
    var textColor = this.textColor ?? Colors.black;
    return SizedBox(
      width: 600,
      child: OutlinedButton(
          style: ButtonStyle(
              elevation: MaterialStateProperty.all(elevation),
              padding: MaterialStateProperty.all(EdgeInsets.all(15)),
              side: MaterialStateProperty.all(
                  BorderSide(color: color, width: 1.5)),
              backgroundColor: MaterialStateProperty.all(varyOpacity
                  ? color.withOpacity(isLoading || onPressed == null ? .6 : 1)
                  : color),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius ?? 8.0)))),
          child: isLoading
              ? SizedBox.fromSize(
                  size: Size.fromRadius(10),
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: textColor,
                  ))
              : Text(
                  label,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
          onPressed: onPressed),
    );
  }
}
