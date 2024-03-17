// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import '../core/utils/media/dimensions.dart';
// import '../cubit/app/app_cubit.dart';
// import '../resources/colors/colors.dart';
// import '../resources/images/images.dart';
// import '../routes/app_routes.dart';
// import 'app_loading.dart';
// import 'category_card/category_card.dart';
// import 'empty_data/empty_data.dart';
//
// class AppListSliver extends StatefulWidget {
//   final bool loadingListItems;
//   final bool hasReachedEndOfResults;
//   final bool endLoadingFirstTime;
//   final bool loadingMoreResults;
//   final List<dynamic> listItems;
//   final Widget Function(BuildContext context, int index) itemBuilder;
//
//   //final void Function(Map<String, dynamic> quray) fetchPageData;
//
//   final WidgetBuilder? emptyBuilder;
//   final Color? loadingColor;
//
//   final bool grid;
//   final int numberOfColumn;
//   final double childAspectRatio;
//
//   final ScrollPhysics physics;
//   final Widget appBarChild;
//
//   const AppListSliver({
//     Key? key,
//     required this.loadingListItems,
//     required this.hasReachedEndOfResults,
//     required this.endLoadingFirstTime,
//     this.loadingMoreResults = false,
//     required this.listItems,
//     // required this.itemBuilder,
//     // required this.fetchPageData,
//     this.emptyBuilder,
//     this.loadingColor,
//     this.grid = true,
//     this.numberOfColumn = 2,
//     this.childAspectRatio = 1.0,
//     this.physics = const BouncingScrollPhysics(),
//     required this.appBarChild,
//     required this.itemBuilder,
//   }) : super(key: key);
//
//   @override
//   _AppListSliverState createState() => _AppListSliverState();
// }
//
// class _AppListSliverState extends State<AppListSliver> {
//   ScrollController? _controller;
//   TextEditingController search = TextEditingController();
//   final _form = GlobalKey<FormState>();
//   int? selectCatId = 0;
//   bool adsLoaded=false;
//
//   ///moving dynamicly
//   int _currentPage = 0;
//   Timer? _timer;
//   final PageController _pageController = PageController(
//     initialPage: 0,
//     viewportFraction: .6,
//   );
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = ScrollController();
//     //widget.fetchPageData({});
//     // CouponsCubit.get(context).getCoupons({
//     //   //This Attribute is for make change only
//     //   "category": 0
//     // });
//
//     // _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
//     //   int length = 0;
//     //   if (AdCubit.get(context).listAds.isNotEmpty) {
//     //     length = AdCubit.get(context).listAds.length - 1;
//     //   }
//     //   AdCubit.get(context).listAds.length - 1;
//     //   if (_currentPage < length) {
//     //     _currentPage++;
//     //   } else {
//     //     _currentPage = 0;
//     //   }
//     //   _pageController.animateToPage(
//     //     _currentPage,
//     //     duration: const Duration(milliseconds: 350),
//     //     curve: Curves.linear,
//     //   );
//     // });
//   }
//
//   Future refreshData() async {
//     debugPrint('refresh data +++===============');
//     await Future.delayed(const Duration(milliseconds: 1000));
//
//     // AdCubit.get(context).getAds();
//     // AdTitleCubit.get(context).getAdTitle();
//     // CategoriesCubit.get(context).getCategories();
//     // CouponsCubit.get(context).getCoupons(
//     //   {"category_id ": selectCatId == 0 ? "" : selectCatId},
//     // );
//     // widget.fetchPageData({'loadMore': true});
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _controller!.dispose();
//     _timer?.cancel();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var height = getSize(context).height;
//     var width = getSize(context).width;
//     return NotificationListener<ScrollNotification>(
//       onNotification: _handleScrollNotification,
//       child: RefreshIndicator(
//         onRefresh: refreshData,
//         child: Container(
//           child: CustomScrollView(
//             key: widget.key,
//             controller: _controller,
//            // physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
//             physics: const AlwaysScrollableScrollPhysics(),
//            // shrinkWrap: false,
//             slivers: [
//               // if(widget.appBarChild!=null) widget.appBarChild,
//               MediaQuery.removePadding(
//                 context: context,
//                 removeBottom: true,
//                 child: SliverAppBar(
//                   backgroundColor: AppColors.white,
//                   pinned: false,
//                   titleSpacing: 0,
//                   primary: false,
//                   automaticallyImplyLeading: false,
//                   flexibleSpace: SingleChildScrollView(
//                     physics: const NeverScrollableScrollPhysics(),
//                     child: Container(
//                       height: height,
//                       decoration: const BoxDecoration(
//                         image: DecorationImage(
//                             image: AssetImage(AppImages.frame),
//                             fit: BoxFit.fill),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(height: height * .1),
//                             Container(
//                               padding: const EdgeInsets.all(10),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(100),
//                                 boxShadow: [
//                                   BoxShadow(
//                                       color: AppColors.grey.withOpacity(.3),
//                                       spreadRadius: .2,
//                                       blurRadius: 10,
//                                       offset: const Offset(0, .5)),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                     collapsedHeight:height * .21,
//                 ),
//               ),
//               // BlocBuilder<AdCubit,AdState>(builder: (context,state){
//               //   return state is GetAdsEmptyState ?SliverToBoxAdapter(child: Container()):
//               //
//               // }),
//               SliverToBoxAdapter(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       SizedBox(
//                         height: height * .06,
//                         child: BlocBuilder<CategoriesCubit, CategoriesState>(
//                           builder: (context, state) {
//                             if (state is GetCategoriesSuccessState) {
//                               List<Widget> children = [];
//                               children.add(CategoryCard(
//                                 id: 0,
//                                 name:  context.tr.all,
//                                 imageUrl: "",
//                                 isActive: selectCatId == 0,
//                                 onSelect: (catId) {
//                                   setState(() {
//                                     selectCatId = 0;
//                                     // CouponsCubit.get(context).getCoupons({
//                                     //   //This Attribute is for make change only
//                                     //   "category": 0
//                                     // });
//                                   });
//                                 },
//                               ));
//                               children.addAll(List.generate(
//                                   state.categoryModel.length, (index) {
//                                 return CategoryCard(
//                                   id: state.categoryModel[index].id,
//                                   name: state.categoryModel[index].name!,
//                                   imageUrl: state.categoryModel[index].image!,
//                                   isActive: selectCatId ==
//                                       state.categoryModel[index].id,
//                                   onSelect: (catId) {
//                                     setState(() {
//                                       selectCatId = catId;
//                                       // CouponsCubit.get(context).getCoupons(
//                                       //     {"category_id ": selectCatId});
//                                     });
//                                   },
//                                 );
//                               }));
//                               return MediaQuery.removePadding(
//                                 context: context,
//                                 removeTop: true,
//                                 removeBottom: true,
//                                 child: MediaQuery.removePadding(
//                                   context: context,
//                                   removeBottom: true,
//                                   removeTop: true,
//                                   child: ListView(
//                                     physics: const BouncingScrollPhysics(),
//                                     scrollDirection: Axis.horizontal,
//                                     children: children,
//                                   ),
//                                 ),
//                               );
//                             } else if (state is GetCategoriesLoadingState) {
//                               return const AppLoading();
//                             } else if (state is GetCategoriesEmptyState) {
//                               return const EmptyData();
//                             } else {
//                               return Container();
//                             }
//                           },
//                         ),
//                       ),
//                       AppSizedBox.sizedH5,
//                       const Padding(
//                         padding:  EdgeInsets.symmetric(horizontal: 10),
//                         child: Text(
//                           "discount_codes",
//                           style:  TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               if (widget.loadingListItems)
//                 const SliverToBoxAdapter(
//                     child: Padding(
//                       padding: EdgeInsets.all(20),
//                       child: Center(
//                         child: AppLoading(
//                           color: AppColors.loadingColor,
//                         ),
//                       ),
//                     )),
//               if (widget.listItems.isEmpty &&
//                   widget.endLoadingFirstTime &&
//                   !widget.loadingListItems)
//                 widget.emptyBuilder != null
//                     ? SliverToBoxAdapter(child: widget.emptyBuilder!(context))
//                     : _emptyBuilder(),
//               if (widget.listItems.isNotEmpty)
//                 SliverPadding(
//                   padding: const EdgeInsets.all(8),
//                   sliver: SliverList(
//                     delegate: SliverChildBuilderDelegate(
//                       (context, index) {
//                         return index >= widget.listItems.length
//                             ? _buildLoaderListItem()
//                             : widget.itemBuilder(context, index);
//                       },
//                       childCount: calculateListItemCount(),
//                     ),
//                   ),
//                 ),
//
//               // SliverToBoxAdapter(
//               //   child: SizedBox(
//               //     height: height*.02,
//               //   ),
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   bool _handleScrollNotification(ScrollNotification notification) {
//     if (notification is ScrollEndNotification &&
//         _controller!.position.extentAfter == 0 &&
//         !widget.hasReachedEndOfResults) {
//       debugPrint('is buttom ====== ');
//       //widget.fetchPageData({'loadMore': true});
//       // CouponsCubit.get(context).getCoupons(
//       //   {"loadMore": true, "category_id ": selectCatId == 0 ? "" : selectCatId},
//       // );
//     }
//
//     return false;
//   }
//
//   int calculateListItemCount() {
//     if (widget.hasReachedEndOfResults || !widget.endLoadingFirstTime) {
//       return widget.listItems.length;
//     } else {
//       // + 1 for the loading indicator
//
//       if (widget.loadingMoreResults) {
//         return widget.listItems.length + 1;
//       } else {
//         return widget.listItems.length;
//       }
//     }
//   }
//
//   Widget _buildLoaderListItem() {
//     if (!widget.hasReachedEndOfResults) {
//       return const AppLoading(
//         color: AppColors.loadingColor,
//       );
//     } else {
//       return Center(
//         //child: Text( context.tr.no_more_data,),
//         child: Container(),
//       );
//     }
//   }
//
//   Widget _emptyBuilder() {
//     return SliverFillRemaining(
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Center(
//           child: Text( context.tr.no_data),
//         ),
//       ),
//     );
//   }
// }
