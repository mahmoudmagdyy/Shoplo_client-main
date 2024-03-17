import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';

import '../../../../resources/colors/colors.dart';
import 'other_restaurants.dart';
import 'our_restaurants.dart';

class RestaurantsScreen extends HookWidget {
  const RestaurantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          bottom: TabBar(
            indicatorColor: AppColors.primaryL,
            indicator: BoxDecoration(
              border: Border.all(
                width: 2,
                color: AppColors.primaryL,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            indicatorWeight: 0,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: AppColors.primaryL,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            tabs: <Widget>[
              Tab(
                text: '    ${context.tr.our_restaurants}    ',
              ),
              Tab(
                text: '    ${context.tr.other_restaurants}    ',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            OurRestaurantsScreen(),
            OtherRestaurantsScreen(),
          ],
        ),
      ),
    );
  }
}
