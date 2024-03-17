import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AppResponsiveWrapper extends StatelessWidget {
  const AppResponsiveWrapper({super.key, this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return ResponsiveBreakpoints.builder(
        //maxWidth: 1200,

        breakpoints: const [
          Breakpoint(start: 0, end: 450, name: MOBILE),
          Breakpoint(start: 451, end: 800, name: TABLET),
          Breakpoint(start: 801, end: 1920, name: DESKTOP),
          Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
        child: Builder(builder: (context) {
          return ResponsiveScaledBox(
              width: ResponsiveValue<double>(context, conditionalValues: [
                const Condition.equals(name: MOBILE, value: 405),
                const Condition.equals(name: TABLET, value: 600),
                const Condition.equals(name: DESKTOP, value: 700),
                const Condition.equals(name: "4k", value: 2300),

                // There are no conditions for width over 1200
                // because the `maxWidth` is set to 1200 via the MaxWidthBox.
              ]).value,
              child: child!);
        }));
  }
}
