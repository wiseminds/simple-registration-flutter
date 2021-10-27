import 'package:flutter/cupertino.dart';
import 'package:challenge/core/extensions/index.dart';
import 'package:flutter/material.dart';

class DateInputField extends StatelessWidget {
  final FocusNode? focusNode;
  final DateTime? value;
  final int? maximumYear, minimumYear;
  final Function(DateTime date) onChanged;
  final String label, hint;
  final String? errorText;
  final bool showLabel;
  final bool showIcon;
  final EdgeInsets? margin, padding;
  const DateInputField({
    Key? key,
    this.focusNode,
    this.value,
    required this.onChanged,
    this.label = '',
    this.hint = '',
    this.errorText,
    this.showLabel = true,
    this.margin,
    this.padding,
    this.showIcon = true,
    this.maximumYear,
    this.minimumYear,
    // this.options
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (value != null)
            Text(label,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                    )),
          Container(
              // margin: margin,
              decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(6),
                  border: Border(
                      bottom: Theme.of(context)
                              .inputDecorationTheme
                              .enabledBorder
                              ?.borderSide
                              .copyWith(width: .5) ??
                          BorderSide())),
              child: InkWell(
                onTap: () => _pickDate(context),
                child: Padding(
                  padding: padding ??
                      const EdgeInsets.only(
                          left: 4.0, right: 12.0, bottom: 13, top: 13),
                  child: Row(
                    children: [
                      Text(value?.readableFormat ?? hint,
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: .1,
                                  fontSize: 12.0,
                                  color: context.bodyText1?.color?.withOpacity(
                                    value != null ? 1 : .5,
                                  ))),
                      Spacer(),
                      if (showIcon)
                        SizedBox(
                            child: Icon(Icons.calendar_today,
                                size: 12, color: context.bodyText1?.color)),
                    ],
                  ),
                ),
              )),
          if (errorText != null &&
              Form.of(context)?.widget.autovalidateMode !=
                  AutovalidateMode.disabled)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(errorText!,
                  style: Theme.of(context).inputDecorationTheme.errorStyle),
            ),
        ],
      ),
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    var background = context.isDark
        ? CupertinoColors.darkBackgroundGray
        : CupertinoColors.opaqueSeparator;
    WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
    await showModalBottomSheet(
        context: context,
        backgroundColor: background,
        builder: (c) => Theme(
            data: Theme.of(context).copyWith(
              cupertinoOverrideTheme: NoDefaultCupertinoThemeData(
                  textTheme: CupertinoTextThemeData(
                textStyle: context.bodyText1,
                actionTextStyle: context.bodyText1,
              )),
              // brightness: Brightness.dark
            ),
            child: SizedBox(
                height: 300.0,
                child: Column(
                  children: [
                    Container(
                      color: background,
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          style: ButtonStyle(
                              textStyle: MaterialStateProperty.all(TextStyle(
                                  color: context.primaryColor,
                                  fontWeight: FontWeight.bold))),
                          // textColor: Theme.of(context).primaryColor,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Done')),
                    ),
                    const Divider(height: .1),
                    Expanded(
                        child: CupertinoDatePicker(
                      backgroundColor: background,
                      onDateTimeChanged: onChanged,
                      maximumYear: maximumYear,
                      minimumYear: minimumYear ?? 1,
                      mode: CupertinoDatePickerMode.date,
                      //  selectionOverlay: Container(
                      //   decoration: BoxDecoration(
                      //       border: Border(
                      //     top: BorderSide(width: .05),
                      //     bottom: BorderSide(width: .05),
                      //   )),
                      // ),
                      maximumDate: DateTime.now(),
                      initialDateTime: value ?? DateTime(1990),
                    )),
                  ],
                ))));
  }
}
