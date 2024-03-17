import 'package:flutter/material.dart';

import '../../../../resources/colors/colors.dart';

class SwitchButton extends StatefulWidget {
  final String name;
  final bool val;
  final ValueChanged<bool> ? onVal;

  const SwitchButton({Key? key, required this.name, this.onVal,  this.val=false}) : super(key: key);

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  late bool _lights ;
  @override
  void initState() {
    super.initState();
    _lights =widget.val;
  }
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(widget.name),
      value: _lights,
      inactiveThumbColor: AppColors.gray.withOpacity(.3),
      inactiveTrackColor: AppColors.gray,
      onChanged: (bool value) {
        setState(() {
          _lights = value;
          widget.onVal!(_lights);
        });
      },
    );
  }
}
