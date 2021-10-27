import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:challenge/core/extensions/index.dart';
import 'package:flutter/material.dart';

class DropdownInput<T> extends StatelessWidget {
  final FocusNode? focusNode;
  final T? value;
  final Function(T?)? onChanged;
  final Function(T)? done;
  final Function()? onTap;
  final String? label;
  final String? hint;
  final String? errorText;
  final bool showToplabel;
  final List<InputItem<T>>? options;
  final BoxDecoration? decoration;
  final TextStyle? style;
  final TextStyle? textStyle;
  final Color? textColor;
  final bool isDense, enabled;
  final Widget? prefix;
  final bool isLoading;
  final Widget? suffix;
  final Size? iconSize;
  final String? Function(T?)? validator;
  final EdgeInsets? horizontalPadding;
  DropdownInput(
      {Key? key,
      this.focusNode,
      this.value,
      this.onChanged,
      this.label,
      this.options,
      this.decoration,
      this.enabled = true,
      this.showToplabel = false,
      this.style,
      this.textStyle,
      this.isDense = false,
      this.iconSize,
      this.horizontalPadding,
      this.prefix,
      this.errorText,
      this.textColor,
      this.suffix,
      this.hint,
      this.done,
      this.isLoading = false,
      this.onTap,
      this.validator})
      : super(key: key);
  // T v;
  @override
  Widget build(BuildContext context) {
    var border =
        Theme.of(context).inputDecorationTheme.enabledBorder?.borderSide;
    // var border = Theme.of(context).inputDecorationTheme.errorBorder;
    return Stack(
      children: [
        GestureDetector(
          onTap: enabled &&
                  !(options != null && options!.isNotEmpty && !isLoading)
              ? onTap
              : () {
                  WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
                  if (Platform.isAndroid) return;

                  _select(context);
                },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showToplabel)
                  Padding(
                    padding: const EdgeInsets.only(left: .0, bottom: 2),
                    child: Text(label ?? '',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              // color: Colors.white54
                            )),
                  ),
                Container(
                  margin: EdgeInsets.only(top: showToplabel ? 0 : 10),
                  padding: EdgeInsets.symmetric(
                    horizontal: 1,
                    vertical: 0,
                  ),
                  decoration: decoration ??
                      BoxDecoration(
                          border: Border(
                              bottom: Theme.of(context)
                                      .inputDecorationTheme
                                      .enabledBorder
                                      ?.borderSide
                                      .copyWith(width: .5) ??
                                  BorderSide())),
                  child: AbsorbPointer(
                    absorbing: Platform.isIOS,
                    child: DropdownButton<T>(
                        itemHeight: kMinInteractiveDimension,
                        // onTap: () => _select(context),
                        // iconSize: 30,
                        icon: isLoading
                            ? const CupertinoActivityIndicator()
                            : suffix,
                        underline: const SizedBox.shrink(),
                        focusNode: focusNode,
                        value: value,
                        hint: Row(
                          children: [
                            // 6.0.w,
                            Text(
                              hint ?? label!,
                              style: Theme.of(context)
                                      .inputDecorationTheme
                                      .hintStyle
                                      ?.copyWith(fontSize: 13) ??
                                  Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                          color: context.caption?.color
                                              ?.withOpacity(.83),
                                          fontWeight: FontWeight.w300,
                                          fontSize: 13),
                            ),
                          ],
                        ),
                        isExpanded: true,
                        isDense: isDense,
                        items: [
                          for (var option in options!)
                            DropdownMenuItem(
                              value: option.value,
                              child: Row(
                                children: [
                                  // if (option.value == null)
                                  //   Padding(
                                  //     padding: const EdgeInsets.only(right: 8.0),
                                  //     child: prefix!,
                                  //   ),
                                  Text(option.title,
                                      style: textStyle ??
                                          Theme.of(context)
                                              .textTheme
                                              .bodyText1),
                                ],
                              ),
                            )
                        ],
                        onChanged: onChanged),
                  ),
                ),
                if (errorText != null &&
                    Form.of(context)?.widget.autovalidateMode !=
                        AutovalidateMode.disabled)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0.0, top: 10),
                      child: Text(errorText ?? '',
                          style: Theme.of(context)
                              .inputDecorationTheme
                              .errorStyle),
                    ),
                  )
              ],
            ),
          ),
        ),
        // if (value != null && showToplabel ||
        //     (validator != null && validator!(value) != null))
        //   Positioned(
        //     left: 50,
        //     child: Container(
        //       padding: EdgeInsets.symmetric(horizontal: 8.0),
        //       // color: Colors.white,
        //       child: Text(label ?? (validator != null ? validator!(value) : ''),
        //           style: Theme.of(context).textTheme.bodyText1!.copyWith(
        //               fontWeight: FontWeight.bold,
        //               fontSize: 9,
        //               color: Color(0xff283461))),
        //     ),
        //   )
      ],
    );
  }

  Future _select(
    BuildContext context,
  ) async {
    T val = value ?? options![0].value;
    var background = context.isDark
        ? CupertinoColors.darkBackgroundGray
        : CupertinoColors.opaqueSeparator;

    return showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      backgroundColor: background,
      builder: (c) => SizedBox(
        height: 300,
        child: Theme(
          data: Theme.of(context).copyWith(
            cupertinoOverrideTheme: NoDefaultCupertinoThemeData(
                textTheme: CupertinoTextThemeData(
              textStyle: context.bodyText1,
              actionTextStyle: context.bodyText1,
            )),
            // brightness: Brightness.dark
          ),
          child: Column(
            children: [
              Container(
                color: background,
                alignment: Alignment.centerRight,
                child: FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.of(c).pop();
                    },
                    child: Text('Done')),
              ),
              Divider(height: 2, thickness: 1, color: context.primaryColor),
              Expanded(
                child: CupertinoPicker.builder(
                    scrollController: FixedExtentScrollController(
                        initialItem:
                            options!.indexWhere((v) => v.value == value)),
                    onSelectedItemChanged: (i) {
                      onChanged!(options![i].value);
                      val = options![i].value;
                    },
                    itemExtent: 25,
                    diameterRatio: 2,
                    magnification: 1.3,
                    backgroundColor: background,
                    useMagnifier: true,
                    squeeze: .7,
                    childCount: options?.length ?? 0,
                    itemBuilder: (c, i) => Center(
                          child: Text(options![i].title,
                              style: style?.copyWith(
                                  // color: Color(0xff283461),
                                  fontSize: 12,
                                  color: Colors.white,
                                  //     // decorationColor: Colors.white,
                                  backgroundColor: Colors.white,
                                  fontWeight: FontWeight.w400)),
                        )),
              ),
            ],
          ),
        ),
      ),
    ).then((value) {
      if (done != null) done!(val);
    });
  }
}

class InputItem<T> {
  final T value;
  final String title;

  InputItem(this.value, this.title);
}
