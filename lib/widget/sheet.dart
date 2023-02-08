import 'package:flutter/material.dart';
import 'package:time_picker_sheet/widget/composition/body.dart';
import 'package:time_picker_sheet/widget/composition/header.dart';
import 'package:time_picker_sheet/widget/composition/indicator.dart';
import 'package:time_picker_sheet/widget/provider/time_picker.dart';
import 'package:time_picker_sheet/widget/time_picker.dart';

/// Using date time format to initialize data and also for the final result.
/// the sheet only care about the hour and minute values, the other will be
/// ignored.
class TimePickerSheet extends TimePicker {
  /// you can set initial time from screen, so if time picker sheet
  /// opened will be directly selected the time based on [initialTime].
  /// but this is optional, if [initialTime] not set the selected time
  /// will be 0.
  final Duration initialTime;

  /// will be used as a minute interval, the default value is 15 but you can
  /// adjust based on your needs from screen. if the value is 15 then the
  /// options will be 0, 15, 30, 45.
  final int minuteInterval;

  /// will be used as a hour interval, the default value is 1 but you can
  /// adjust based on your needs from screen. if the value is 1 then the
  /// options will be start from 0 and default to 24.
  final int hourInterval;

  /// max hour should be >= 0. outside the range will
  /// trigger an error on the screen.
  final int maxHour;

  /// min hour should be >= 0. outside the range will
  /// trigger an error on the screen.
  final int minHour;

  /// max minute should be >= 0 && <= 60. outside the range will
  /// trigger an error on the screen.
  final int maxMinute;

  /// min minute should be >= 0 && <= 60. outside the range will
  /// trigger an error on the screen.
  final int minMinute;

  /// to enable two digit format in time picker sheet,
  /// the default value is false. When this format enabled
  /// the return value/result is still using one digit. Ex:
  /// you select 03:45 then the result would be 3:45. so you
  /// don't need to reformat or mapping anything on the screen.
  final bool twoDigit;

  final Icon sheetCloseIcon;

  /// title on the top of the sheet.
  final String sheetTitle;

  /// you can customize the style to align with your requirement.
  final TextStyle sheetTitleStyle;

  final String minuteTitle;

  final TextStyle minuteTitleStyle;

  final String hourTitle;

  final TextStyle hourTitleStyle;

  final TextStyle wheelNumberItemStyle;

  final TextStyle wheelNumberSelectedStyle;

  final String saveButtonText;

  final ButtonStyle saveButtonStyle;

  const TimePickerSheet({
    Key? key,
    required this.sheetTitle,
    required this.minuteTitle,
    required this.hourTitle,
    required this.saveButtonText,
    this.initialTime = Duration.zero,
    this.minuteInterval = 15,
    this.hourInterval = 1,
    this.minHour = 0,
    this.maxHour = 24,
    this.minMinute = 0,
    this.maxMinute = 60,
    this.twoDigit = true,
    this.sheetCloseIcon = const Icon(Icons.close),
    this.saveButtonStyle = const ButtonStyle(),
    this.sheetTitleStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
    this.hourTitleStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
    this.minuteTitleStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
    this.wheelNumberItemStyle = const TextStyle(
      fontSize: 14,
    ),
    this.wheelNumberSelectedStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
  })  : assert(minHour >= 0),
        assert(maxHour >= 0),
        assert(minMinute >= 0 && maxMinute <= 60),
        assert(maxMinute >= 0 && maxMinute <= 60),
        assert(minMinute <= maxMinute),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final halfOfScreen = MediaQuery.of(context).size.height / 2;

    return TimePickerProvider(
      sheetCloseIcon: sheetCloseIcon,
      sheetTitle: sheetTitle,
      sheetTitleStyle: sheetTitleStyle,
      minuteTitle: minuteTitle,
      minuteTitleStyle: minuteTitleStyle,
      hourTitle: hourTitle,
      hourTitleStyle: hourTitleStyle,
      wheelNumberItemStyle: wheelNumberItemStyle,
      wheelNumberSelectedStyle: wheelNumberSelectedStyle,
      saveButtonText: saveButtonText,
      saveButtonStyle: saveButtonStyle,
      twoDigit: twoDigit,
      child: SizedBox(
        height: halfOfScreen,
        child: SafeArea(
          child: Column(
            children: [
              const SheetHeader(),
              const SizedBox(height: 16),
              Expanded(
                child: Stack(
                  children: [
                    const TimePickerIndicator(),
                    TimePickerBody(
                      initial: initialTime,
                      itemHeight: 40,

                      /// normalize the interval to be have positive
                      /// value if somehow the interval is negative.
                      minuteInterval: minuteInterval.abs(),

                      /// normalize the interval to be have positive
                      /// value if somehow the interval is negative.
                      hourInterval: hourInterval.abs(),
                      maxHour: maxHour,
                      minHour: minHour,
                      maxMinute: maxMinute,
                      minMinute: minMinute,
                      visibleItems: 3,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
