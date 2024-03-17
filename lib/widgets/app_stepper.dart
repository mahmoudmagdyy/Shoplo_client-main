import 'package:flutter/material.dart';

import '../resources/colors/colors.dart';

class AppCustomStepper<T> extends StatefulWidget {
  const AppCustomStepper({Key? key, required this.onStepTapped, required this.steps, this.selectedStep}) : super(key: key);
  final Function(T) onStepTapped;
  final List<T> steps;
  final T? selectedStep;

  @override
  State<AppCustomStepper<T>> createState() => _AppCustomStepperState<T>();
}

class _AppCustomStepperState<T> extends State<AppCustomStepper<T>> {
  T? selectedStep;
  @override
  void initState() {
    selectedStep = widget.selectedStep ?? widget.steps.first;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AppCustomStepper<T> oldWidget) {
    if (widget.selectedStep != null && widget.selectedStep != selectedStep) {
      setState(() {
        selectedStep = widget.selectedStep;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    // index of selected step
    final selectedStepIndex = widget.steps.indexWhere((element) => element == this.selectedStep);
    // index of next step

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < widget.steps.length; i++)
          Row(
            children: [
              InkWell(
                customBorder: const CircleBorder(),
                onTap: () => widget.onStepTapped(widget.steps[i]),
                child: CircleAvatar(
                  foregroundColor: i <= selectedStepIndex ? Colors.white : Colors.black,
                  backgroundColor: i <= selectedStepIndex ? AppColors.primaryL : Colors.grey,
                  child: Text(widget.steps[i].toString()),
                ),
              ),
              if (i != widget.steps.length - 1)
                Container(
                  width: 100,
                  height: 1,
                  color: selectedStep == widget.steps[i] ? AppColors.primaryL : Colors.grey,
                )
            ],
          ),
      ],
    );
  }
}
