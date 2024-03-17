import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/resources/styles/app_sized_box.dart';

import '../../resources/colors/colors.dart';
import '../../resources/images/images.dart';

class CustomDateAndTimePicker extends StatefulWidget {
  const CustomDateAndTimePicker(
      {Key? key,
      required this.onChanged,
      this.initValue,
      this.validator,
      this.showLable = true,
      this.label,
      this.flex = 1,
      this.startDate})
      : super(key: key);
  final Function(DateTime?) onChanged;
  final String? initValue;
  final String? label;
  final bool showLable;
  final int flex;
  final DateTime? startDate;
  final String? Function(String?)? validator;

  @override
  State<CustomDateAndTimePicker> createState() =>
      _CustomDateTimeRangePickerState();
}

class _CustomDateTimeRangePickerState extends State<CustomDateAndTimePicker> {
  DateTime? dateTime;
  final TextEditingController _date = TextEditingController();
  final TextEditingController _time = TextEditingController();
  @override
  void dispose() {
    _date.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: FormField<String>(
                initialValue: widget.initValue ?? "",
                validator: widget.validator,
                builder: (state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      if (widget.showLable)
                        Text(
                          (widget.label ?? 'date_and_time'),
                        ),
                      if (widget.showLable)
                        const SizedBox(
                          height: 10,
                        ),
                      GestureDetector(
                        onTap: () async {
                          log('onTap');
                          final DateTime? picked = await showDatePicker(
                              context: context,
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: const ColorScheme.light(
                                      primary: AppColors.secondaryL,
                                      onPrimary: AppColors.white,
                                      onSurface: AppColors.black,
                                      inversePrimary: AppColors.red,
                                      onSecondary: AppColors.green,
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                              initialDate: widget.startDate ?? DateTime.now(),
                              firstDate: widget.startDate ?? DateTime.now(),
                              lastDate: DateTime(2101));
                          if (picked != null && picked != dateTime) {
                            // pick time
                            final TimeOfDay? time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (time != null) {
                              setState(() {
                                dateTime = DateTime(picked.year, picked.month,
                                    picked.day, time.hour, time.minute);
                              });
                              _date.text =
                                  DateFormat('yyyy-MM-dd').format(picked);
                              _time.text = time.format(context);

                              widget.onChanged(dateTime);
                              state.didChange(dateTime.toString());
                            }
                          }
                        },
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                  enabled: false,
                                  controller: _date,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                      hintText: context.tr.date,
                                      suffixIcon: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SvgPicture.asset(
                                            AppImages.calender,
                                            height: 20,
                                            width: 20,
                                          ),
                                        ],
                                      ))),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: _time,
                                enabled: false,
                                readOnly: true,
                                decoration: InputDecoration(
                                    hintText: context.tr.time,
                                    suffixIcon: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SvgPicture.asset(
                                          AppImages.time,
                                          height: 20,
                                          width: 20,
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      AppSizedBox.sizedH10,
                      if (state.hasError)
                        Center(
                          child: Text(
                            state.errorText ?? "",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                                fontSize: 14),
                          ),
                        )
                    ],
                  );
                })),
      ],
    );
  }
}
