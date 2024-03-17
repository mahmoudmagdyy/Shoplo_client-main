import 'dart:async';

import 'package:flutter/material.dart';

import '../../resources/colors/colors.dart';

class AppAutoCompleteDropDown<T> extends StatefulWidget {
  const AppAutoCompleteDropDown(
      {Key? key,
      this.initialValue,
      this.label,
      this.showClearIcon = false,
      this.showSufix = false,
      this.showRequiredStar = false,
      this.keepSuggestionAftertSelect = false,
      this.removeSelectedItem = false,
      required this.onChanged,
      this.onClear,
      required this.function,
      this.itemAsString,
      this.flex = 1,
      this.hideOnLoading = false,
      this.controller,
      this.enabled = true,
      this.disableSearch = false,
      this.hint,
      this.validator,
      this.padding,
      this.border,
      this.itemBuilder,
      this.direction = AxisDirection.down,
      this.showAboveField = false,
      this.emptyWidget,
      this.refreshOnTap = true,
      this.searchInApi = true})
      : super(key: key);
  final Function(T) onChanged;
  final bool showSufix;
  final String? label;
  final String? hint;
  final String? initialValue;
  final FutureOr<Iterable<T>> Function(String) function;
  final VoidCallback? onClear;
  final bool disableSearch;
  final bool showClearIcon;
  final bool enabled;
  final bool hideOnLoading;
  final bool showRequiredStar;
  final bool removeSelectedItem;
  final AxisDirection direction;
  final bool keepSuggestionAftertSelect;
  final TextEditingController? controller;
  final String Function(T)? itemAsString;
  final int flex;
  final bool searchInApi;
  final bool refreshOnTap;
  final String? Function(String?)? validator;
  final EdgeInsetsGeometry? padding;
  final InputBorder? border;
  final bool showAboveField;
  final Widget? emptyWidget;
  final Widget Function(BuildContext, T)? itemBuilder;
  @override
  State<AppAutoCompleteDropDown<T>> createState() => _CutomAutoCompleteTextFeildState<T>();
}

class _CutomAutoCompleteTextFeildState<T> extends State<AppAutoCompleteDropDown<T>> {
  late TextEditingController controller;
  final LayerLink _layerLink = LayerLink();
  bool _hasOpenedOverlay = false;
  bool _isLoading = false;
  OverlayEntry? _overlayEntry;
  Timer? _debounce;
  String? selectedItem;
  List<T> suggestions = [];
  List<T> searchedSuggestions = [];
  @override
  void initState() {
    controller = widget.controller ?? TextEditingController(text: widget.initialValue);

    super.initState();
  }

  @override
  void dispose() {
    _overlayEntry?.dispose();
    _debounce?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        IgnorePointer(
            ignoring: !widget.enabled,
            child: WillPopScope(
              onWillPop: () async {
                if (_hasOpenedOverlay) {
                  closeOverlay();
                  return false;
                } else {
                  return true;
                }
              },
              child: CompositedTransformTarget(
                  link: _layerLink,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                            key: _key,
                            readOnly: widget.disableSearch,
                            decoration: InputDecoration(
                              hintText: widget.hint,
                              filled: widget.enabled == true ? false : true,
                              fillColor: Colors.grey.withOpacity(0.4),
                              labelText: widget.label,
                              suffix: (widget.showClearIcon)
                                  ? Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: IconButton(
                                        onPressed: () {
                                          widget.onClear?.call();
                                          controller.text = "";
                                          selectedItem = null;
                                        },
                                        icon: const Icon(Icons.clear),
                                      ),
                                    )
                                  : null,
                              suffixIcon: widget.showSufix
                                  ? Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Icons.keyboard_arrow_down,
                                          color: AppColors.grey,
                                        )
                                      ],
                                    )
                                  : null,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            ),
                            controller: controller,
                            onChanged: (s) {
                              if (!_hasOpenedOverlay) openOverlay();
                              if (widget.searchInApi) {
                                updateSuggestions(s);
                              } else {
                                searchedSuggestions = suggestions
                                    .where((element) => widget.itemAsString?.call(element).toLowerCase().contains(s.toLowerCase()) ?? true)
                                    .toList();
                                rebuildOverlay();
                              }
                            },
                            onTap: () {
                              openOverlay();
                              updateSuggestions(controller.text, refresh: widget.refreshOnTap);
                            },
                            // onEditingComplete: () => closeOverlay(),
                            validator: widget.validator)
                      ])),
            )),
      ],
    );
  }

  void closeOverlay() {
    if (_hasOpenedOverlay) {
      if (selectedItem != null) {
        controller.text = selectedItem ?? "";
      } else {
        controller.text = "";
      }
      _overlayEntry!.remove();
      setState(() {
        _hasOpenedOverlay = false;
      });
    }
  }

//global key
  final GlobalKey _key = GlobalKey();
  void openOverlay() {
    controller.text = '';
    RenderBox renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    _overlayEntry ??= OverlayEntry(builder: (context) => suggestionList(offset, size, context));
    if (_hasOpenedOverlay == false) {
      print("object");
      Overlay.of(context).insert(_overlayEntry!);
      setState(() => _hasOpenedOverlay = true);
    }
  }

  Widget suggestionList(Offset offset, Size size, BuildContext context) {
    final h = MediaQuery.of(context).size.height * 0.5;
    return Positioned(
        left: offset.dx,
        top: offset.dy + size.height,
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: true,
          offset: Offset(0.0, widget.showAboveField ? -h : size.height + 5),
          child: TapRegion(
            onTapOutside: (event) {
              // if event isnot drag
              if (event is! PointerMoveEvent) {
                closeOverlay();
              }
            },
            child: Card(
              shape: RoundedRectangleBorder(side: const BorderSide(color: Colors.grey, width: 1), borderRadius: BorderRadius.circular(10.0)),
              margin: EdgeInsets.zero,
              color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.3),
                child: _isLoading
                    ? const Center(
                        child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ))
                    : searchedSuggestions.isEmpty
                        ? widget.emptyWidget ??
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("No Items"),
                            )
                        : Scrollbar(
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: searchedSuggestions.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) => InkWell(
                                      onTap: () {
                                        if (widget.keepSuggestionAftertSelect == false) {
                                          selectedItem =
                                              widget.itemAsString?.call(searchedSuggestions[index]) ?? searchedSuggestions[index].toString();
                                          closeOverlay();
                                        }
                                        widget.onChanged(searchedSuggestions[index]);
                                      },
                                      child: widget.itemBuilder?.call(context, searchedSuggestions[index]) ??
                                          ListTile(
                                              shape: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                              title: Text(
                                                  widget.itemAsString?.call(searchedSuggestions[index]) ?? searchedSuggestions[index].toString())),
                                    )),
                          ),
              ),
            ),
          ),
        ));
  }

  void rebuildOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.markNeedsBuild();
    }
  }

  Future<void> updateSuggestions(String input, {bool refresh = false}) async {
    if (widget.searchInApi == false && suggestions.isNotEmpty && !refresh) {
      searchedSuggestions =
          suggestions.where((element) => widget.itemAsString?.call(element).toLowerCase().contains(input.toLowerCase()) ?? true).toList();
      rebuildOverlay();
      return;
    }
    setState(() => _isLoading = true);

    if (_debounce != null && _debounce!.isActive) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      suggestions = (await widget.function.call(input)).toList();
      searchedSuggestions =
          suggestions.where((element) => widget.itemAsString?.call(element).toLowerCase().contains(input.toLowerCase()) ?? true).toList();

      setState(() {
        _isLoading = false;
      });
      rebuildOverlay();
    });
  }
}
