import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';

import '../resources/colors/colors.dart';
import '../resources/images/images.dart';
import 'header_decoration.dart';

class AppPicker extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final String initialValue;
  final String initialLabel;

  const AppPicker({
    Key? key,
    required this.data,
    required this.initialValue,
    required this.initialLabel,
  }) : super(key: key);

  @override
  State<AppPicker> createState() => _AppPickerState();
}

class _AppPickerState extends State<AppPicker> {
  late String value;
  late String label;

  showLangPicker(BuildContext context) {
    var languagesData = widget.data
        .map(
          (e) => PickerItem(
            text:
                Text(e['name'], style: const TextStyle(fontFamily: "Poppins")),
            value: e['id'],
          ),
        )
        .toList();
    final selectedIndex = widget.data.indexWhere((e) => e['id'] == value);
    Picker(
      headerColor: AppColors.primaryL,
      headerDecoration: headerDecoration(),
      selecteds: selectedIndex != -1 ? [selectedIndex] : [],
      adapter: PickerDataAdapter(data: languagesData),
      title: Text(
        context.tr.lang,
        style: const TextStyle(
          color: AppColors.white,
        ),
      ),
      cancelText: context.tr.cancel,
      cancelTextStyle: const TextStyle(
        color: AppColors.white,
      ),
      confirmText: context.tr.confirm,
      confirmTextStyle: const TextStyle(color: AppColors.white),
      onConfirm: (Picker picker, List values) {
        var selectedLang = widget.data.firstWhere(
            (element) => element['id'] == picker.getSelectedValues()[0]);
        setState(() {
          label = selectedLang['name'];
          value = picker.getSelectedValues()[0].toString();
        });
      },
    ).showModal(context);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      value = widget.initialValue;
      label = widget.initialLabel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // if (state is GetStatesLoadingState) return;
        showLangPicker(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: AppColors.textGray,
              width: .5,
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                const SizedBox(
                  width: 10,
                ),
                Image.asset(
                  value == "ar" ? AppImages.ar : AppImages.en,
                  width: 35,
                  height: 30,
                  fit: BoxFit.contain,
                ),

                const SizedBox(
                  width: 10,
                ),
                // state is GetCitiesLoadingState
                //     ? AppLoading(
                //         scale: .5,
                //         color: AppColors.primaryL,
                //       )
                //     :
                Text(
                  label != '' ? label : context.tr.lang,
                  style:
                      const TextStyle(fontSize: 16, color: AppColors.textGray),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.keyboard_arrow_down, color: AppColors.textGray),
            )
          ],
        ),
      ),
    );
  }
}
