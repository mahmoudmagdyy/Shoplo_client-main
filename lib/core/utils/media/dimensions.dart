import 'package:flutter/material.dart';

///Font Sizes
///0.0025*pixel size=flutter pixel

const kAppBarButtonsSize = 0.06;
const kDefaultPadding = 0.04;

double renderFontSizeFromPixels(BuildContext context, double textSize) =>
    MediaQuery.of(context).size.width * textSize;

const k8TextSize = 0.025;
const k10TextSize = 0.03;
const k12TextSize = 0.035;
const k14TextSize = 0.04;
const k16TextSize = 0.045;
const k18TextSize = 0.048;
const k20TextSize = 0.05;
const k22TextSize = 0.055;
const k24TextSize = 0.06;
const k28TextSize = 0.07;
const k30TextSize = 0.075;
const k32TextSize = 0.08;
const k36TextSize = 0.09;
const k40TextSize = 0.1;
const k48TextSize = 0.12;
const k50TextSize = 0.125;
const k60TextSize = 0.15;
const k72TextSize = 0.18;

// Padding size
const kTopScreenPadding = 0.04;
const kHorizontalPaddingOfTextField = 0.07;
const kPadding30 = 0.05;
const kPadding8 = 0.01;
const kPadding9 = 0.015;
const kPadding10 = 0.03;
const kPadding24 = 0.04;
const kPadding27 = 0.07;

///return size mediaQuery
Size getSize(context) {
  return MediaQuery.of(context).size;
}
