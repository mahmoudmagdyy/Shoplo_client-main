import 'package:flutter/material.dart';

import '../../../../resources/colors/colors.dart';

class CustomTapBar<T> extends StatefulWidget {
  const CustomTapBar({
    super.key,
    required this.onChange,
    this.selectedType,
    required this.items,
    this.itemAsString,
  });
  final Function(T)? onChange;
  final T? selectedType;
  final List<T> items;
  final String Function(T)? itemAsString;

  @override
  State<CustomTapBar<T>> createState() => _CustomTapBarState<T>();
}

class _CustomTapBarState<T> extends State<CustomTapBar<T>> {
  T? selectedType;
  int selectedIndex = 0;
  @override
  void didUpdateWidget(covariant CustomTapBar<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    selectedType = widget.selectedType ?? widget.items.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      final itemWidth = constrains.maxWidth / widget.items.length;

      return Center(
        child: SizedBox(
            height: 45,
            child: Stack(
              textDirection: TextDirection.ltr,
              children: [
                AnimatedPositionedDirectional(
                  height: 45,
                  width: itemWidth,
                  start: (selectedIndex * itemWidth),
                  duration: const Duration(milliseconds: 300),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      width: itemWidth,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primaryL, width: 2),
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Row(
                    children: [
                      ...widget.items.map(
                        (e) => Expanded(
                            child: InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedType = e;
                                    selectedIndex = widget.items.indexOf(e);
                                  });
                                  widget.onChange?.call(e);
                                },
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 500),
                                  child: Center(
                                    key: ValueKey(e),
                                    child: Text(
                                      (widget.itemAsString?.call(e) ??
                                          e.toString()),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: selectedType == e
                                              ? AppColors.primaryL
                                              : AppColors.black),
                                    ),
                                  ),
                                ))),
                      )
                    ],
                  ),
                )
              ],
            )),
      );
    });
  }
}
