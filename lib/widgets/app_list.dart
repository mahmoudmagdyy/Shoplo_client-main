import 'package:flutter/material.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';

import '../resources/colors/colors.dart';
import '../resources/styles/app_sized_box.dart';
import 'app_button_outline.dart';
import 'app_loading.dart';
import 'separator_builder.dart';

class AppList extends StatefulWidget {
  final bool refresh;
  final bool horizontal;
  final bool loadingListItems;
  final bool hasReachedEndOfResults;
  final bool endLoadingFirstTime;
  final bool loadingMoreResults;
  List listItems;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final void Function(Map<String, dynamic> query) fetchPageData;
  final WidgetBuilder? emptyBuilder;
  final Color? loadingColor;
  final bool grid;
  final bool reverse;
  final int numberOfColumn;
  final double childAspectRatio;
  final bool stopRefresh;
  final ScrollPhysics physics;
  final bool noSeparatorBuilder;
  final String? noDataMessage;

  AppList({
    Key? key,
    this.refresh = false,
    this.horizontal = false,
    required this.loadingListItems,
    required this.hasReachedEndOfResults,
    required this.endLoadingFirstTime,
    this.loadingMoreResults = false,
    required this.listItems,
    required this.itemBuilder,
    required this.fetchPageData,
    this.emptyBuilder,
    this.loadingColor,
    this.grid = false,
    this.reverse = false,
    this.stopRefresh = false,
    this.noSeparatorBuilder = false,
    this.numberOfColumn = 2,
    this.childAspectRatio = 1.0,
    this.noDataMessage,
    this.physics = const BouncingScrollPhysics(),
  }) : super(key: key);

  @override
  State<AppList> createState() => _AppListState();
}

class _AppListState extends State<AppList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    widget.fetchPageData({});
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // @override
  // didChangeDependencies() {
  //   debugPrint(
  //     "🚀 ~ file: app_list.dart ~ line 62 ~ _AppListState ~ didChangeDependencies ~ didChangeDependencies",
  //   );
  //   super.didChangeDependencies();
  //   if (widget.refresh) {
  //     widget.fetchPageData({});
  //   }
  // }

  Future refreshData() async {
    debugPrint('refresh data +++===============');
    await Future.delayed(const Duration(milliseconds: 1000));
    if (widget.key == const Key('NotificationsList')) {
      //NotificationsCountCubit.get(context).getNotificationsCount();
    }
    if (widget.stopRefresh) {
      return;
    } else {
      widget.fetchPageData({'loadMore': true});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.loadingListItems) {
      return AppLoading(
        color: widget.loadingColor ?? AppColors.loadingColor,
      );
    } else if (widget.listItems.isEmpty && widget.endLoadingFirstTime) {
      debugPrint('====== empty ');
      if (widget.emptyBuilder != null) {
        return widget.emptyBuilder!(context);
      } else {
        return _emptyBuilder();
      }
    } else {
      return RefreshIndicator(
        backgroundColor: AppColors.primaryL,
        color: AppColors.white,
        onRefresh: refreshData,
        child: NotificationListener<ScrollNotification>(
          onNotification: _handleScrollNotification,
          child: widget.grid
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: widget.numberOfColumn,
                    childAspectRatio: widget.childAspectRatio,
                  ),
                  physics: widget.physics,
                  shrinkWrap: true,
                  controller: _scrollController,
                  itemCount: calculateListItemCount(),
                  itemBuilder: (context, index) {
                    return index >= widget.listItems.length
                        ? _buildLoaderListItem()
                        : widget.itemBuilder(context, index);
                  },
                )
              : widget.noSeparatorBuilder
                  ? ListView.builder(
                      reverse: widget.reverse,
                      scrollDirection:
                          widget.horizontal ? Axis.horizontal : Axis.vertical,
                      physics: widget.physics,
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: calculateListItemCount(),
                      // separatorBuilder: separatorBuilder,
                      itemBuilder: (context, index) {
                        return index >= widget.listItems.length
                            ? _buildLoaderListItem()
                            : widget.itemBuilder(context, index);
                      },
                    )
                  : ListView.separated(
                      reverse: widget.reverse,
                      scrollDirection:
                          widget.horizontal ? Axis.horizontal : Axis.vertical,
                      physics: widget.physics,
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: calculateListItemCount(),
                      separatorBuilder: separatorBuilder,
                      itemBuilder: (context, index) {
                        return index >= widget.listItems.length
                            ? _buildLoaderListItem()
                            : widget.itemBuilder(context, index);
                      },
                    ),
        ),
      );
    }
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0 &&
        !widget.hasReachedEndOfResults) {
      debugPrint('is bottom ====== ');
      widget.fetchPageData({'loadMore': true});
    }

    return false;
  }

  int calculateListItemCount() {
    if (widget.hasReachedEndOfResults || !widget.endLoadingFirstTime) {
      return widget.listItems.length;
    } else {
      // + 1 for the loading indicator

      if (widget.loadingMoreResults) {
        return widget.listItems.length + 1;
      } else {
        return widget.listItems.length;
      }
    }
  }

  Widget _buildLoaderListItem() {
    // return const AppLoading(
    //   color: AppColors.loadingColor,
    // );
    if (!widget.hasReachedEndOfResults) {
      return const AppLoading(
        color: AppColors.loadingColor,
      );
    } else {
      return Center(
        child: Text(
          context.tr.no_more_data,
        ),
      );
    }
  }

  Widget _emptyBuilder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.noDataMessage ?? context.tr.no_data),
          AppSizedBox.sizedH10,
          SizedBox(
            width: 100,
            child: AppButtonOutline(
              title: context.tr.reload,
              onPressed: () {
                refreshData();
              },
              // child: Text(
              //   context.tr.reload,
              //   style: AppTextStyle.textStyleSemiBoldGold16
              //       .copyWith(color: AppColors.red),
              // )
            ),
          ),
        ],
      ),
    );
  }
}
