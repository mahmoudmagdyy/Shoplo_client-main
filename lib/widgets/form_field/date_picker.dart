import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/core/extensions/extensions_on_time.dart';

import '../../core/config/constants.dart';
import '../../resources/colors/colors.dart';
import '../../resources/styles/app_text_style.dart';

class AppDatePicker extends StatefulWidget {
  final String type;
  final TextEditingController controller;
  final String dateFormat;
  final DateTime? firstDate;
  final String label;
  final Widget? suffixIcon;
  final bool readOnly;
  final ValueChanged<DateTime> ?onInit;

  const AppDatePicker({
    super.key,
    required this.type,
    required this.controller,
    this.dateFormat = 'yyyy-MM-dd',
    this.firstDate,
    required this.label,
    this.suffixIcon,
    this.readOnly = false, this.onInit,
  });

  @override
  State<AppDatePicker> createState() => _AppDatePickerState();
}

class _AppDatePickerState extends State<AppDatePicker> {
  DateTime selectedDate = DateTime.now();

  Future<void> selectDate(BuildContext context) async {
    debugPrint(' widget.firstDate: ${widget.firstDate}', wrapWidth: 1024);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate:widget.firstDate !=null?widget.firstDate! : widget.controller.text.isNotEmpty
          ? DateTime.parse(widget.controller.text)
          : DateTime.now(),
      firstDate: widget.firstDate ?? DateTime.now(),
      lastDate: DateTime(3000),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.secondaryL,
              onPrimary: AppColors.white,
              onSurface: AppColors.black,
              inversePrimary: AppColors.red,
              onSecondary: AppColors.green,
            ),),
          //   // textButtonTheme: TextButtonThemeData(
          //   //   style: TextButton.styleFrom(
          //   //     foregroundColor: AppColors.secondaryL,
          //   //   ),
          //   // ),
          // ),
          // data: ThemeData(
          //   primarySwatch: MaterialColor(
          //     0xff2FDAD0,
          //     const <int, Color>{
          //       50: AppColors.primaryL,
          //       100: AppColors.primaryL,
          //       200: AppColors.primaryL,
          //       300: AppColors.primaryL,
          //       400:AppColors.primaryL,
          //       500:AppColors.primaryL,
          //       600: AppColors.primaryL,
          //       700: AppColors.primaryL,
          //       800: AppColors.primaryL,
          //       900: AppColors.primaryL,
          //     },
          //   ),
          //     primaryColor: AppColors.primaryL,
          //     accentColor: AppColors.primaryL,
          //     cardColor:AppColors.primaryL,
          //     backgroundColor:AppColors.primaryL,
          //     highlightColor:AppColors.primaryL,
          //     splashColor:AppColors.primaryL,
          //
          // ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      if (widget.type == 'dateTime') {
        setState(() {
          selectedDate = pickedDate;
          widget.onInit!(selectedDate);
        });
        selectTime();
      } else {
        String formattedDate = DateFormat(widget.dateFormat).format(pickedDate);
        widget.controller.text = formattedDate;
      }
    }
  }

  Future<void> selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      debugPrint('PICKED TIME: ${pickedTime.to24hours()}', wrapWidth: 1024);
      if (widget.type == 'dateTime') {
        String formattedDate =
            DateFormat(widget.dateFormat).format(selectedDate);
        // final localizations = MaterialLocalizations.of(context);
        // final formattedTimeOfDay = localizations.formatTimeOfDay(pickedTime);
        // debugPrint('FORMATTED TIME OF DAY: $formattedTimeOfDay',
        //     wrapWidth: 1024);
        widget.controller.text = '$formattedDate ${pickedTime.to24hours()}';
      } else {
        widget.controller.text = pickedTime.toString();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Constants.padding5),
      child: TextFormField(
        readOnly: true,
        controller: widget.controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.text,
        style: AppTextStyle.textStyleEditTextValueRegularBlack,
        decoration: InputDecoration(
          labelText: widget.label,
          suffixIcon: widget.suffixIcon,
        ),
        onTap: () async {
          if (widget.readOnly) {
          } else {
            if (widget.type == 'date') {
              selectDate(context);
            } else if (widget.type == 'time') {
              selectTime();
            } else if (widget.type == 'dateTime') {
              selectDate(context);
            }
          }
        },
        validator: (value) {
          if (value!.isEmpty) {
            return context.tr.required;
          }
          return null;
        },
        onSaved: (value) {},
      ),
    );
  }
}

