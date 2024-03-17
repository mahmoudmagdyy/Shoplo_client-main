import 'package:flutter/material.dart';

import 'our_stores.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 1,
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
          ),
          // bottom: PreferredSize(
          //     preferredSize: const Size.fromHeight(45),
          //     child: Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 20),
          //       child: CustomTapBar<int>(
          //         items: const [0],
          //         onChange: (index) {
          //           DefaultTabController.of(context).animateTo(index);
          //         },
          //         itemAsString: (s) {
          //           // if (s == 0) {
          //           return context.tr.our_stores;
          //           // }
          //           // else {
          //           //   return context.tr.other_stores;
          //           // }
          //         },
          //       ),
          //     ))

          // //  TabBar(
          // //   indicatorPadding: const EdgeInsets.all(0),
          // //   indicatorColor: AppColors.primaryL,
          // //   indicator: BoxDecoration(
          // //     border: Border.all(
          // //       width: 2,
          // //       color: AppColors.primaryL,
          // //     ),
          // //     borderRadius: const BorderRadius.all(
          // //       Radius.circular(5),
          // //     ),
          // //   ),
          // //   indicatorWeight: 0,
          // //   indicatorSize: TabBarIndicatorSize.label,
          // //   labelColor: AppColors.primaryL,
          // //   labelStyle: const TextStyle(
          // //     fontWeight: FontWeight.bold,
          // //     fontSize: 15,
          // //   ),
          // //   tabs: <Widget>[
          // //     Tab(
          // //       text: '    ${context.tr.our_stores}    ',
          // //     ),
          // //     Tab(
          // //       text: '    ${context.tr.other_stores}    ',
          // //     ),
          // //   ],
          // // ),
          // ),
          body: const TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              OurStoresScreen(),
              // OtherStoresScreen(),
            ],
          ),
        );
      }),
    );
  }
}
